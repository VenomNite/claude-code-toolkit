#!/usr/bin/env python3
"""Claude Code Context Monitor v2.1 - Optimized Version"""
import json, sys, os, re, subprocess, glob
from datetime import datetime, timedelta, timezone

try:
    from plan_detector import get_plan_config
    PLAN_DETECTION_AVAILABLE = True
except ImportError:
    PLAN_DETECTION_AVAILABLE = False

def get_dynamic_plan_limits():
    """Get dynamic plan limits with fallback."""
    if PLAN_DETECTION_AVAILABLE:
        try:
            config = get_plan_config()
            return {'token_limit': config.get('token_limit', 88000), 'normalization_factor': config.get('normalization_factor', 1.55), 'plan_name': config.get('plan_name', 'max_x5'), 'confidence': config.get('detection_confidence', 0)}
        except Exception: pass
    return {'token_limit': 88000, 'normalization_factor': 1.55, 'plan_name': 'max_x5', 'confidence': 0}

def parse_context_from_transcript(transcript_path):
    """Enhanced context estimation using real token data."""
    if not transcript_path or not os.path.exists(transcript_path):
        return {'percent': 15, 'method': 'no_transcript', 'accurate': False}

    try:
        with open(transcript_path, 'r') as f:
            lines = f.readlines()[-30:]  # Last 30 lines only

        # Priority 1: Claude system warnings
        for line in reversed(lines):
            try:
                data = json.loads(line.strip())
                if data.get('type') == 'system_message':
                    content = data.get('content', '')
                    for pattern, warning in [('Context low \((\d+)% remaining\)', 'low'), ('Context left until auto-compact: (\d+)%', 'auto-compact')]:
                        match = re.search(pattern, content)
                        if match:
                            return {'percent': 100 - int(match.group(1)), 'warning': warning, 'method': 'claude_system', 'accurate': True}
            except: continue

        # Priority 2: Real token data
        max_tokens, message_count = 0, 0
        for line in reversed(lines):
            try:
                data = json.loads(line.strip())
                if data.get('type') == 'assistant':
                    usage = data.get('message', {}).get('usage', {})
                    if usage:
                        tokens = usage.get('input_tokens', 0) + usage.get('cache_read_input_tokens', 0) + usage.get('cache_creation_input_tokens', 0)
                        max_tokens = max(max_tokens, tokens)
                        message_count += 1
                        if message_count >= 5: break
            except: continue

        if max_tokens > 0:
            real_percent = min(99, (max_tokens / 200000) * 100)
            return {'percent': real_percent, 'tokens_used': max_tokens, 'method': 'real_tokens', 'accurate': True}

        # Fallback: Message-based estimation
        depth, length = 0, 0
        for line in reversed(lines):
            try:
                data = json.loads(line.strip())
                if data.get('type') in ['assistant', 'user']:
                    depth += 1
                    content = data.get('message', {}).get('content', [])
                    if isinstance(content, list):
                        for item in content:
                            if isinstance(item, dict) and item.get('type') == 'text':
                                length += len(item.get('text', ''))
                    if depth >= 15: break
            except: continue

        if depth > 0:
            percent = min(85, min(20, depth * 1.5) + min(30, length / 1000))
            return {'percent': percent, 'messages': depth, 'method': 'estimate', 'accurate': False}

        return {'percent': 15, 'method': 'default', 'accurate': False}
    except:
        return {'percent': 15, 'method': 'error', 'accurate': False}

def get_context_display(context_info):
    """Generate context display with enhanced indicators."""
    if not context_info: return "🔵 ???%"

    percent = context_info.get('percent', 0)
    warning = context_info.get('warning')
    accurate = context_info.get('accurate', False)
    method = context_info.get('method', '')
    tokens_used = context_info.get('tokens_used', 0)

    # Color/icon selection
    if warning in ['low', 'auto-compact']: icon, color = "🔴", "\033[31;1m"
    elif method.startswith('real_tokens'):
        if percent >= 90: icon, color = "🔴", "\033[31m"
        elif percent >= 75: icon, color = "🟠", "\033[91m"
        elif percent >= 50: icon, color = "🟡", "\033[33m"
        else: icon, color = "🟢", "\033[32m"
    elif accurate:
        if percent >= 85: icon, color = "🟠", "\033[91m"
        elif percent >= 70: icon, color = "🟡", "\033[33m"
        else: icon, color = "🟢", "\033[32m"
    else:
        if percent >= 80: icon, color = "🟠", "\033[91m"
        elif percent >= 60: icon, color = "🟡", "\033[33m"
        else: icon, color = "🟢", "\033[32m"

    # Progress bar
    filled = int((percent / 100) * 4)
    bar = "█" * filled + "▁" * (4 - filled)

    # Accuracy indicator
    indicator = "✓" if method.startswith('real_tokens') and 'cache' in method else "" if accurate else "~" if not method.startswith('real_tokens') else ""

    # Token display
    token_display = f" ({tokens_used//1000}k)" if tokens_used > 0 and method.startswith('real_tokens') else ""

    return f"{icon} {color}{bar}\033[0m {indicator}{percent:.0f}%{token_display}"

def get_directory_display(workspace_data):
    """Get directory display name."""
    current_dir = workspace_data.get('current_dir', '')
    project_dir = workspace_data.get('project_dir', '')

    if current_dir and project_dir and current_dir.startswith(project_dir):
        rel_path = current_dir[len(project_dir):].lstrip('/')
        return rel_path or os.path.basename(project_dir)
    return os.path.basename(current_dir) if current_dir else os.path.basename(project_dir) if project_dir else "unknown"

def get_git_info():
    """Get Git branch information."""
    try:
        # Get branch
        result = subprocess.run(['git', 'rev-parse', '--abbrev-ref', 'HEAD'], capture_output=True, text=True, timeout=2)
        if result.returncode != 0: return "🌿-"
        branch = result.stdout.strip()

        # Get status
        status_result = subprocess.run(['git', 'status', '--porcelain', '-b'], capture_output=True, text=True, timeout=2)
        if status_result.returncode != 0: return f"🌿{branch}"

        status_lines = status_result.stdout.strip().split('\n')
        if not status_lines: return f"🌿{branch}"

        first_line, ahead_behind = status_lines[0], ""
        # Check ahead/behind
        for pattern, symbol in [('ahead (\d+)', '↑'), ('behind (\d+)', '↓')]:
            match = re.search(pattern, first_line)
            if match: ahead_behind += f"{symbol}{match.group(1)}"

        # Count modified files
        modified_count = len([line for line in status_lines[1:] if line.strip()])
        if modified_count > 0: ahead_behind += f" *{modified_count}"

        return f"🌿{branch}{ahead_behind}" if ahead_behind else f"🌿{branch}"
    except:
        return "🌿-"

def get_claude_session_data_claude_monitor_exact():
    """EXACT replication of claude-monitor algorithm."""
    try:
        claude_dir = os.path.expanduser('~/.claude')
        now = datetime.now(timezone.utc)
        cutoff_time = now - timedelta(hours=192)  # 8 days

        # Find JSONL files
        recent_files = []
        for pattern in [os.path.join(claude_dir, '*.jsonl'), os.path.join(claude_dir, 'projects', '*', '*.jsonl')]:
            recent_files.extend([f for f in glob.glob(pattern) if os.path.isfile(f)])

        if not recent_files: return {}

        # Load entries with deduplication
        all_entries, processed_hashes = [], set()
        for file_path in recent_files:
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
                                            message = data.get("message", {})
                                            message_id = data.get("message_id") or (message.get("id") if isinstance(message, dict) else None)
                                            request_id = data.get("requestId") or data.get("request_id")
                                            unique_hash = f"{message_id}:{request_id}" if message_id and request_id else None

                                            if unique_hash and unique_hash in processed_hashes: continue

                                            usage = data.get('message', {}).get('usage', {})
                                            if usage:
                                                input_tokens = usage.get('input_tokens', 0)
                                                output_tokens = usage.get('output_tokens', 0)
                                                if input_tokens == 0 and output_tokens == 0: continue

                                                all_entries.append({
                                                    'timestamp': timestamp,
                                                    'total_tokens': input_tokens + output_tokens,
                                                    'message_id': message_id or "",
                                                    'request_id': request_id or "unknown"
                                                })
                                                if unique_hash: processed_hashes.add(unique_hash)
                            except: continue
            except: continue

        if not all_entries: return {}

        # Transform to session blocks
        all_entries.sort(key=lambda x: x['timestamp'])
        session_blocks, current_block = [], None
        session_duration = timedelta(hours=5)

        for entry in all_entries:
            entry_time = entry['timestamp']
            should_create_new_block = (current_block is None or entry_time >= current_block['end_time'] or
                                     (current_block['entries'] and entry_time - current_block['entries'][-1]['timestamp'] >= timedelta(hours=2)))

            if should_create_new_block:
                if current_block and current_block['entries']:
                    current_block['actual_end_time'] = current_block['entries'][-1]['timestamp']
                    session_blocks.append(current_block)

                start_time = entry_time.replace(minute=0, second=0, microsecond=0)
                current_block = {
                    'id': start_time.isoformat(),
                    'start_time': start_time,
                    'end_time': start_time + session_duration,
                    'entries': [],
                    'total_tokens': 0,
                    'is_active': False
                }

            current_block['entries'].append(entry)
            current_block['total_tokens'] += entry['total_tokens']

        if current_block and current_block['entries']:
            current_block['actual_end_time'] = current_block['entries'][-1]['timestamp']
            session_blocks.append(current_block)

        # Mark active blocks
        for block in session_blocks:
            if (block['end_time'] > now and len(block['entries']) >= 3 and block['entries'] and
                (now - block['entries'][-1]['timestamp']).total_seconds() <= 1800):
                block['is_active'] = True

        active_blocks = [b for b in session_blocks if b['is_active']]
        if active_blocks:
            current_session = max(active_blocks, key=lambda x: x['start_time'])
            return {
                'reset_time': current_session['end_time'].astimezone().strftime('%H:%M'),
                'cost_percent': (current_session['total_tokens'] / get_dynamic_plan_limits()['token_limit']) * 100,
                'tokens_used': current_session['total_tokens'],
                'session_active': True,
                'approach': 'claude_monitor_exact'
            }
        elif session_blocks:
            latest_block = max(session_blocks, key=lambda x: x['start_time'])
            return {
                'reset_time': 'EXPIRED',
                'cost_percent': 100.0,
                'tokens_used': latest_block['total_tokens'],
                'session_active': False,
                'approach': 'claude_monitor_exact'
            }
        return {}
    except: return {}

def get_claude_session_reset():
    """Get Claude session reset time."""
    session_data = get_claude_session_data_claude_monitor_exact()
    if not session_data: return "L.R. @ --:--"
    reset_time = session_data.get('reset_time', '')
    return "L.R. EXPIRED" if reset_time == 'EXPIRED' else f"L.R. @ {reset_time}🕐" if reset_time else "L.R. @ --:--"

def get_cost_usage():
    """Get Claude cost usage."""
    session_data = get_claude_session_data_claude_monitor_exact()
    if not session_data or 'cost_percent' not in session_data: return "C.U. 🔵??%"

    percent = session_data.get('cost_percent', 0)
    if not session_data.get('session_active', False): return "C.U. 🔴█████EXP"

    # Normalize display percentage
    display_percent = min(100, percent / get_dynamic_plan_limits()['normalization_factor'])

    # Color selection
    if percent >= 95: icon, color = "🔴", "\033[31;1m"
    elif percent >= 90: icon, color = "🔴", "\033[31m"
    elif percent >= 75: icon, color = "🟠", "\033[91m"
    elif percent >= 60: icon, color = "🟡", "\033[33m"
    else: icon, color = "🟢", "\033[32m"

    filled = int((display_percent / 100) * 4)
    bar = "█" * filled + "▁" * (4 - filled)
    return f"C.U. {icon} {color}{bar}\033[0m {display_percent:.0f}%"

def get_live_datetime():
    """Get current date and time."""
    try: return f"⌚ {datetime.now().strftime('%H:%M %b %d')}"
    except: return "⌚ --:--"

def main():
    try:
        data = json.load(sys.stdin)
        workspace = data.get('workspace', {})
        transcript_path = data.get('transcript_path', '')

        # Build status components
        context_info = parse_context_from_transcript(transcript_path)
        context_display = get_context_display(context_info)
        directory = get_directory_display(workspace)
        git_info = get_git_info()
        claude_reset = get_claude_session_reset()
        cost_usage = get_cost_usage()
        live_datetime = get_live_datetime()

        # Build 3 sections
        section1 = f"\033[93m📁 {directory}\033[0m {git_info}"
        section2 = f"{context_display}"
        section3 = f"{claude_reset} {cost_usage} {live_datetime}"

        separator = " \033[90m|\033[0m "
        print(f"{section1}{separator}{section2}{separator}{section3}")

    except Exception as e:
        try:
            git_fallback = get_git_info()
            claude_reset_fallback = get_claude_session_reset()
            cost_usage_fallback = get_cost_usage()
            datetime_fallback = get_live_datetime()

            section1_fallback = f"\033[93m📁 {os.path.basename(os.getcwd())}\033[0m {git_fallback}"
            section2_fallback = f"\033[31m[Error]\033[0m"
            section3_fallback = f"{claude_reset_fallback} {cost_usage_fallback} {datetime_fallback}"

            separator = " \033[90m|\033[0m "
            print(f"{section1_fallback}{separator}{section2_fallback}{separator}{section3_fallback}")
        except:
            separator = " \033[90m|\033[0m "
            print(f"\033[93m📁 {os.path.basename(os.getcwd())}\033[0m 🌿-{separator}\033[31m[Error: {str(e)[:20]}]\033[0m{separator}L.R. @ --:-- C.U. 🔵 ??% ⌚ --:--")

if __name__ == "__main__": main()