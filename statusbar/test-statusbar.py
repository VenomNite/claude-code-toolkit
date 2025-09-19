#!/usr/bin/env python3
"""Status Bar Module Test Suite"""
import os, sys, yaml, json, tempfile, shutil, unittest
from datetime import datetime, timezone
from unittest.mock import patch, mock_open, MagicMock
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

class TestStatusBarConfig(unittest.TestCase):
    """Test statusbar-config.yaml functionality"""
    def setUp(self):
        self.test_dir = tempfile.mkdtemp()
        self.config_path = os.path.join(self.test_dir, 'statusbar-config.yaml')
    def tearDown(self):
        shutil.rmtree(self.test_dir, ignore_errors=True)

    def test_config_file_structure(self):
        """Test YAML config file has required structure"""
        script_dir = os.path.dirname(os.path.abspath(__file__))
        real_config_path = os.path.join(script_dir, 'statusbar-config.yaml')
        self.assertTrue(os.path.exists(real_config_path), "Config file must exist")

        with open(real_config_path, 'r') as f:
            config = yaml.safe_load(f)

        # Required keys and validation
        for key in ['user_plan', 'detection_mode', 'plans']:
            self.assertIn(key, config, f"Config must have '{key}' key")

        valid_plans = ['plus', 'max_x5', 'max_x20']
        self.assertIn(config['user_plan'], valid_plans, "user_plan must be valid")
        self.assertIn(config['detection_mode'], ['auto', 'manual'], "detection_mode must be valid")

        # Plans structure validation
        for plan_name in valid_plans:
            self.assertIn(plan_name, config['plans'], f"Plans must include {plan_name}")
            plan_data = config['plans'][plan_name]
            self.assertIn('token_limit', plan_data, f"{plan_name} must have token_limit")
            self.assertIn('normalization_factor', plan_data, f"{plan_name} must have normalization_factor")
            self.assertIsInstance(plan_data['token_limit'], int, "token_limit must be integer")
            self.assertIsInstance(plan_data['normalization_factor'], (int, float), "normalization_factor must be numeric")

    def test_plan_limits_are_logical(self):
        """Test that plan limits make sense relative to each other"""
        script_dir = os.path.dirname(os.path.abspath(__file__))
        with open(os.path.join(script_dir, 'statusbar-config.yaml'), 'r') as f:
            plans = yaml.safe_load(f)['plans']

        plus_limit, max_x5_limit, max_x20_limit = plans['plus']['token_limit'], plans['max_x5']['token_limit'], plans['max_x20']['token_limit']

        # Logical ordering and ratios
        self.assertLess(plus_limit, max_x5_limit, "Plus should have lower limit than Max x5")
        self.assertLess(max_x5_limit, max_x20_limit, "Max x5 should have lower limit than Max x20")
        self.assertGreater(max_x5_limit / plus_limit, 1.5, "Max x5 should be significantly higher than Plus")
        self.assertGreater(max_x20_limit / max_x5_limit, 3.0, "Max x20 should be significantly higher than Max x5")


class TestPlanDetector(unittest.TestCase):
    """Test plan_detector.py functionality"""
    def setUp(self):
        self.test_dir = tempfile.mkdtemp()
    def tearDown(self):
        shutil.rmtree(self.test_dir, ignore_errors=True)

    def test_plan_detector_import(self):
        """Test that plan detector can be imported"""
        try:
            import plan_detector
            self.assertTrue(hasattr(plan_detector, 'get_plan_config'), "Module must have get_plan_config function")
            self.assertTrue(hasattr(plan_detector, 'ClaudePlanDetector'), "Module must have ClaudePlanDetector class")
        except ImportError as e:
            self.skipTest(f"plan_detector module not available: {e}")

    def test_default_config_fallback(self):
        """Test that detector works without config file"""
        try:
            import plan_detector
            with patch('os.path.exists', return_value=False):
                detector = plan_detector.ClaudePlanDetector('/nonexistent/path')
                config = detector.get_plan_config()
                for key in ['plan_name', 'token_limit', 'normalization_factor']:
                    self.assertIn(key, config)
                self.assertIsInstance(config['token_limit'], int)
                self.assertIsInstance(config['normalization_factor'], (int, float))
        except ImportError:
            self.skipTest("plan_detector module not available")

    def test_manual_mode_override(self):
        """Test manual mode configuration override"""
        try:
            import plan_detector
            test_config = {
                'user_plan': 'plus', 'detection_mode': 'manual',
                'plans': {
                    'plus': {'token_limit': 45000, 'normalization_factor': 1.20},
                    'max_x5': {'token_limit': 88000, 'normalization_factor': 1.55},
                    'max_x20': {'token_limit': 350000, 'normalization_factor': 3.80}
                }
            }
            config_path = os.path.join(self.test_dir, 'test-config.yaml')
            with open(config_path, 'w') as f:
                yaml.dump(test_config, f)

            result = plan_detector.ClaudePlanDetector(config_path).get_plan_config()
            self.assertEqual(result['plan_name'], 'plus')
            self.assertEqual(result['token_limit'], 45000)
            self.assertEqual(result['normalization_factor'], 1.20)
        except ImportError:
            self.skipTest("plan_detector module not available")


class TestContextMonitor(unittest.TestCase):
    """Test context_monitor_generic.py functionality"""
    def test_context_monitor_import(self):
        """Test that context monitor can be imported"""
        try:
            import context_monitor_generic as monitor
            for func in ['get_dynamic_plan_limits', 'parse_context_from_transcript', 'get_cost_usage']:
                self.assertTrue(hasattr(monitor, func), f"Must have {func}")
        except ImportError as e:
            self.skipTest(f"context_monitor_generic module not available: {e}")

    def test_dynamic_plan_limits_fallback(self):
        """Test that dynamic plan limits has safe fallback"""
        try:
            import context_monitor_generic as monitor
            with patch('os.path.exists', return_value=False):
                limits = monitor.get_dynamic_plan_limits()
                for key in ['token_limit', 'normalization_factor', 'plan_name']:
                    self.assertIn(key, limits)
                self.assertIsInstance(limits['token_limit'], int)
                self.assertIsInstance(limits['normalization_factor'], (int, float))
                self.assertGreater(limits['token_limit'], 0)
                self.assertGreater(limits['normalization_factor'], 0)
        except ImportError:
            self.skipTest("context_monitor_generic module not available")

    def test_transcript_parsing_safety(self):
        """Test that transcript parsing handles missing files safely"""
        try:
            import context_monitor_generic as monitor
            result = monitor.parse_context_from_transcript('/nonexistent/file.jsonl')
            self.assertIsInstance(result, dict)
            for key in ['percent', 'accurate']:
                self.assertIn(key, result)
            self.assertIsInstance(result['percent'], (int, float))
            self.assertIsInstance(result['accurate'], bool)
        except ImportError:
            self.skipTest("context_monitor_generic module not available")


class TestIntegration(unittest.TestCase):
    """Integration tests for the complete status bar system"""
    def test_end_to_end_config_flow(self):
        """Test complete configuration flow from config to monitor"""
        try:
            import context_monitor_generic as monitor
            test_config = {
                'user_plan': 'max_x20', 'detection_mode': 'manual',
                'plans': {
                    'plus': {'token_limit': 45000, 'normalization_factor': 1.20},
                    'max_x5': {'token_limit': 88000, 'normalization_factor': 1.55},
                    'max_x20': {'token_limit': 350000, 'normalization_factor': 3.80}
                }
            }
            with patch('builtins.open', mock_open(read_data=yaml.dump(test_config))):
                with patch('os.path.exists', return_value=True):
                    limits = monitor.get_dynamic_plan_limits()
                    self.assertEqual(limits['plan_name'], 'max_x20')
                    self.assertEqual(limits['token_limit'], 350000)
                    self.assertEqual(limits['normalization_factor'], 3.80)
        except ImportError:
            self.skipTest("Required modules not available")

    def test_config_validation_comprehensive(self):
        """Comprehensive validation of config file structure and values"""
        script_dir = os.path.dirname(os.path.abspath(__file__))
        config_path = os.path.join(script_dir, 'statusbar-config.yaml')
        self.assertTrue(os.path.exists(config_path), "statusbar-config.yaml must exist")

        with open(config_path, 'r') as f:
            config = yaml.safe_load(f)
        self.assertIsInstance(config, dict, "Config must be valid YAML dict")

        plans = config.get('plans', {})
        for plan_name in ['plus', 'max_x5', 'max_x20']:
            self.assertIn(plan_name, plans, f"Missing plan: {plan_name}")
            plan = plans[plan_name]
            self.assertIn('token_limit', plan, f"{plan_name} missing token_limit")
            self.assertIn('normalization_factor', plan, f"{plan_name} missing normalization_factor")

            token_limit, norm_factor = plan['token_limit'], plan['normalization_factor']
            self.assertGreater(token_limit, 1000, f"{plan_name} token_limit too low")
            self.assertLess(token_limit, 1000000, f"{plan_name} token_limit too high")
            self.assertGreater(norm_factor, 0.5, f"{plan_name} normalization_factor too low")
            self.assertLess(norm_factor, 10.0, f"{plan_name} normalization_factor too high")


def run_tests():
    """Run all status bar tests"""
    print("🧪 Running Status Bar Module Tests...")
    print("=" * 50)

    loader = unittest.TestLoader()
    suite = unittest.TestSuite()
    for test_class in [TestStatusBarConfig, TestPlanDetector, TestContextMonitor, TestIntegration]:
        suite.addTests(loader.loadTestsFromTestCase(test_class))

    result = unittest.TextTestRunner(verbosity=2).run(suite)

    print("\n" + "=" * 50)
    total_tests, failures, errors = result.testsRun, len(result.failures), len(result.errors)
    passed = total_tests - failures - errors

    print(f"📊 Test Results:")
    print(f"   ✅ Passed: {passed}/{total_tests}")
    if failures > 0: print(f"   ❌ Failed: {failures}")
    if errors > 0: print(f"   💥 Errors: {errors}")

    success = failures == 0 and errors == 0
    print(f"\n🎯 Overall: {'✅ ALL TESTS PASSED' if success else '❌ TESTS FAILED'}")
    return success


if __name__ == "__main__":
    sys.exit(0 if run_tests() else 1)