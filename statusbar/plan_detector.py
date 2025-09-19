#!/usr/bin/env python3
"""Claude Plan Detection Module v1.0"""
import os, json, yaml, glob, re
from datetime import datetime, timedelta, timezone
from typing import Dict, Tuple, Optional, List


class ClaudePlanDetector:
    """Intelligent Claude plan detection with confidence scoring."""

    def __init__(self, config_path: Optional[str] = None):
        self.config_path = config_path or os.path.join(os.path.dirname(os.path.abspath(__file__)), 'statusbar-config.yaml')
        self.config = self._load_config()

    def _load_config(self) -> Dict:
        """Load configuration with fallback."""
        try:
            if os.path.exists(self.config_path):
                with open(self.config_path, 'r') as f:
                    return yaml.safe_load(f)
            return self._get_default_config()
        except: return self._get_default_config()

    def _get_default_config(self) -> Dict:
        """Default configuration fallback."""
        return {
            'user_plan': 'max_x5',
            'plans': {
                'plus': {'token_limit': 45000, 'normalization_factor': 1.20},
                'max_x5': {'token_limit': 88000, 'normalization_factor': 1.55},
                'max_x20': {'token_limit': 350000, 'normalization_factor': 3.80}
            },
            'auto_detection': {'analysis_days': 14, 'min_sessions': 5, 'confidence_threshold': 95}
        }

    def get_plan_config(self) -> Dict:
        """Get current plan configuration with auto-detection."""
        detection_mode = self.config.get('detection_mode', 'auto')

        if detection_mode == 'auto':
            confidence, detected_plan = self._detect_plan_with_confidence()
            threshold = self.config.get('confidence_threshold', 95)
            plan_name = detected_plan if confidence >= threshold else self.config.get('user_plan', 'max_x5')
            if confidence >= threshold: self._save_detected_plan(detected_plan, confidence)
        else:
            plan_name = self.config.get('user_plan', 'max_x5')

        plan_info = self.config['plans'].get(plan_name, self.config['plans']['max_x5'])
        return {
            'plan_name': plan_name,
            'token_limit': plan_info['token_limit'],
            'normalization_factor': plan_info['normalization_factor'],
            'detection_confidence': getattr(self, '_last_confidence', 0)
        }

    def _detect_plan_with_confidence(self) -> Tuple[float, str]:
        """Detect Claude plan with confidence scoring."""
        try:
            usage_data = self._analyze_recent_usage()
            if not usage_data: return (0, 'max_x5')

            # Multiple detection signals with weights
            signals = [
                (self._analyze_peak_usage(usage_data)[0] * 0.4, self._analyze_peak_usage(usage_data)[1]),
                (self._analyze_rate_limits()[0] * 0.3, self._analyze_rate_limits()[1]),
                (self._analyze_session_frequency(usage_data)[0] * 0.2, self._analyze_session_frequency(usage_data)[1]),
                (self._analyze_usage_patterns(usage_data)[0] * 0.1, self._analyze_usage_patterns(usage_data)[1])
            ]

            # Weighted confidence calculation
            plan_scores = {'plus': 0, 'max_x5': 0, 'max_x20': 0}
            total_weight = 0

            for weight, plan in signals:
                if plan in plan_scores:
                    plan_scores[plan] += weight
                    total_weight += weight

            if total_weight == 0: return (0, 'max_x5')

            best_plan = max(plan_scores.items(), key=lambda x: x[1])
            confidence = (best_plan[1] / total_weight) * 100
            self._last_confidence = confidence
            return (confidence, best_plan[0])
        except: return (0, 'max_x5')

    def _analyze_recent_usage(self) -> List[Dict]:
        """Analyze recent Claude usage from transcript files."""
        try:
            claude_dir = os.path.expanduser('~/.claude')
            cutoff_time = datetime.now(timezone.utc) - timedelta(days=self.config.get('auto_detection', {}).get('analysis_days', 14))
            usage_entries = []

            for pattern in [os.path.join(claude_dir, '*.jsonl'), os.path.join(claude_dir, 'projects', '*', '*.jsonl')]:
                for file_path in glob.glob(pattern):
                    if os.path.isfile(file_path):
                        usage_entries.extend(self._extract_usage_from_file(file_path, cutoff_time))

            return sorted(usage_entries, key=lambda x: x['timestamp'])
        except: return []

    def _extract_usage_from_file(self, file_path: str, cutoff_time: datetime) -> List[Dict]:
        """Extract usage data from a single transcript file."""
        entries = []
        try:
            with open(file_path, 'r') as f:
                for line in f:
                    if line.strip():
                        try:
                            data = json.loads(line.strip())
                            if data.get('type') == 'assistant':
                                timestamp_str = data.get('timestamp')
                                if timestamp_str:
                                    timestamp = datetime.fromisoformat(timestamp_str.replace('Z', '+00:00'))
                                    if timestamp >= cutoff_time:
                                        usage = data.get('message', {}).get('usage', {})
                                        if usage:
                                            total_tokens = usage.get('input_tokens', 0) + usage.get('output_tokens', 0)
                                            if total_tokens > 0:
                                                entries.append({
                                                    'timestamp': timestamp,
                                                    'total_tokens': total_tokens,
                                                    'input_tokens': usage.get('input_tokens', 0),
                                                    'output_tokens': usage.get('output_tokens', 0)
                                                })
                        except: continue
        except: pass
        return entries

    def _analyze_peak_usage(self, usage_data: List[Dict]) -> Tuple[float, str]:
        """Analyze peak token usage to determine plan."""
        if not usage_data: return (0, 'max_x5')

        sessions = self._group_into_sessions(usage_data, hours=5)
        if not sessions: return (0, 'max_x5')

        peak_usage = max(sum(entry['total_tokens'] for entry in session) for session in sessions)

        if peak_usage > 300000: return (85, 'max_x20')
        elif peak_usage > 150000: return (75, 'max_x20')
        elif peak_usage > 70000: return (80, 'max_x5')
        elif peak_usage > 35000: return (70, 'max_x5')
        else: return (60, 'plus')

    def _analyze_rate_limits(self) -> Tuple[float, str]:
        """Look for rate limit messages in recent transcripts."""
        return (0, 'max_x5')  # Simplified - not implemented

    def _analyze_session_frequency(self, usage_data: List[Dict]) -> Tuple[float, str]:
        """Analyze session frequency patterns."""
        sessions = self._group_into_sessions(usage_data, hours=5)
        if len(sessions) < 3: return (0, 'max_x5')
        if len(sessions) > 20: return (60, 'max_x20')
        elif len(sessions) > 10: return (55, 'max_x5')
        else: return (50, 'plus')

    def _analyze_usage_patterns(self, usage_data: List[Dict]) -> Tuple[float, str]:
        """Analyze consistent usage patterns."""
        if not usage_data: return (0, 'max_x5')
        avg_tokens = sum(entry['total_tokens'] for entry in usage_data) / len(usage_data)
        if avg_tokens > 15000: return (40, 'max_x20')
        elif avg_tokens > 8000: return (45, 'max_x5')
        else: return (40, 'plus')

    def _group_into_sessions(self, usage_data: List[Dict], hours: int = 5) -> List[List[Dict]]:
        """Group usage data into time-based sessions."""
        if not usage_data: return []

        sessions, current_session = [], []
        session_duration = timedelta(hours=hours)

        for entry in usage_data:
            if not current_session:
                current_session = [entry]
            else:
                time_diff = entry['timestamp'] - current_session[0]['timestamp']
                if time_diff <= session_duration:
                    current_session.append(entry)
                else:
                    if current_session: sessions.append(current_session)
                    current_session = [entry]

        if current_session: sessions.append(current_session)
        return sessions

    def _save_detected_plan(self, plan: str, confidence: float):
        """Save auto-detected plan to config."""
        try:
            self.config.update({
                'user_plan': plan,
                'detection_mode': 'auto',
                'last_detection': {'plan': plan, 'confidence': confidence, 'timestamp': datetime.now().isoformat()}
            })
            with open(self.config_path, 'w') as f:
                yaml.dump(self.config, f, default_flow_style=False)
        except: pass

    def _prompt_manual_config(self, confidence: float, detected_plan: str):
        """Prompt user for manual configuration (low confidence)."""
        pass  # Simplified - fall back to default


def get_plan_config() -> Dict:
    """Main entry point for plan detection."""
    return ClaudePlanDetector().get_plan_config()

if __name__ == "__main__":
    config = get_plan_config()
    print(f"Detected plan: {config['plan_name']}")
    print(f"Token limit: {config['token_limit']}")
    print(f"Normalization factor: {config['normalization_factor']}")
    print(f"Detection confidence: {config['detection_confidence']:.1f}%")