# 🧪 Claude Code Toolkit Testing Suite
## Testing Framework

**Comprehensive testing system for the dual-scope installation architecture.**

## 🎯 Overview

This testing suite validates the complete dual-scope installation system, ensuring robust functionality across user and global installation scopes with proper precedence management.

### 🏗️ Architecture Tested

- **User Scope**: `~/.claude/` (personal installations)
- **Global Scope**: `/usr/local/share/claude/` (system-wide installations)
- **Precedence System**: User → Global → Built-in defaults
- **Backup/Restore**: Automatic backup creation and restoration
- **Permission Handling**: Sudo detection and graceful fallbacks

## 📋 Test Suite Components

### 1. 🏠 User Scope Installation Test
**File:** `test-user-installation.sh`

**Purpose:** Validates complete user scope installation workflow

**Tests:**
- ✅ Installer syntax validation
- ✅ Help and version flag functionality
- ✅ Dry run mode (no file creation)
- ✅ User scope installation (16 commands, 10 agents, 2 scripts)
- ✅ Settings configuration (`~/.claude/settings.json`)
- ✅ Backup functionality
- ✅ Installation verification
- ✅ Python dependencies (psutil)

**Duration:** ~30-60 seconds

### 2. 🌐 Global Scope Installation Test
**File:** `test-global-installation.sh`

**Purpose:** Tests global installation logic and permissions (simulated)

**Tests:**
- ✅ Global dry run validation
- ✅ Permission detection (sudo requirement)
- ✅ Global directory structure simulation
- ✅ Global settings configuration
- ✅ Precedence logic (global-only scenarios)
- ✅ Global verification simulation
- ✅ Global uninstall simulation
- ✅ Installer global flags

**Duration:** ~20-40 seconds
**Note:** Uses mock directories to avoid requiring sudo

### 3. ⚖️ Dual-Scope Precedence Test
**File:** `test-dual-scope-precedence.sh`

**Purpose:** Comprehensive precedence and scope switching validation

**Tests:**
- ✅ Initial clean state
- ✅ Global-only precedence
- ✅ User-only precedence
- ✅ Dual-scope precedence (user overrides global)
- ✅ Partial override precedence
- ✅ Scope switching scenarios
- ✅ Backup and restore functionality
- ✅ Conflict resolution
- ✅ Installation verification for both scopes
- ✅ Installer integration

**Duration:** ~45-90 seconds

### 4. 🚀 Master Test Runner
**File:** `run-all-tests.sh`

**Purpose:** Orchestrates complete test suite with comprehensive reporting

**Features:**
- ✅ Pre-flight environment checks
- ✅ Installer syntax validation
- ✅ Sequential test execution with timeout protection
- ✅ Detailed reporting (Markdown + JSON)
- ✅ Performance metrics and timing
- ✅ Failure analysis and troubleshooting guidance

## 🚀 Quick Start

### Run Complete Test Suite
```bash
# Execute all tests with comprehensive reporting
cd claude-code-toolkit/testing
./run-all-tests.sh
```

### Run Individual Tests
```bash
# Test user scope installation
./test-user-installation.sh

# Test global scope logic
./test-global-installation.sh

# Test dual-scope precedence
./test-dual-scope-precedence.sh
```

## 📊 Test Reports

### Automatic Report Generation
Each test run generates detailed reports in `/tmp/claude-toolkit-test-reports-YYYYMMDD_HHMMSS/`:

- **`master-test-report.md`** - Comprehensive markdown report
- **`test-statistics.json`** - Machine-readable statistics
- **`test-N-*.log`** - Individual test execution logs

### Sample Report Output
```
Claude Code Toolkit Test Suite Results
════════════════════════════════════════

📊 Overall Statistics:
   Total Tests: 3
   Passed: 3
   Failed: 0
   Success Rate: 100%
   Total Duration: 2m 15s

🧪 Individual Test Results:
   1. User Scope Installation Test
      Status: PASSED
      Duration: 45s

   2. Global Scope Installation Test
      Status: PASSED
      Duration: 32s

   3. Dual-Scope Precedence Test
      Status: PASSED
      Duration: 58s

🎉 ALL TESTS PASSED!
The ULTRATHINK dual-scope installation system is PRODUCTION READY.
```

## 🔧 Test Environment

### Prerequisites
- **Python 3.8+** (required for dependency testing)
- **Bash 4.0+** (for advanced shell features)
- **Git** (recommended for version checking)
- **timeout command** (optional, for test timeout protection)

### System Requirements
- **Disk Space**: ~50MB for test artifacts
- **Memory**: ~64MB for test execution
- **Time**: 3-5 minutes for complete test suite

### Supported Platforms
- ✅ **Linux** (Ubuntu, Debian, CentOS, etc.)
- ✅ **macOS** (with Homebrew bash)
- ✅ **Windows WSL** (Ubuntu, Debian)

## 🛡️ Safety Features

### Non-Destructive Testing
- ✅ **Automatic backup** of existing `~/.claude/` installations
- ✅ **Complete restoration** after test completion
- ✅ **Mock directories** for global scope testing (no sudo required)
- ✅ **Isolated test environments** to prevent conflicts

### Error Handling
- ✅ **Graceful failures** with detailed error messages
- ✅ **Automatic cleanup** on test interruption (Ctrl+C)
- ✅ **Timeout protection** (5 minutes per test)
- ✅ **Exit code propagation** for CI/CD integration

## 🔍 Troubleshooting

### Common Issues

#### Tests Fail to Start
```bash
# Check that you're in the right directory
ls install.sh commands/ agents/  # Should all exist

# Verify test script permissions
chmod +x test/*.sh

# Check system dependencies
python3 --version  # Should be 3.8+
```

#### Permission Errors
```bash
# Tests run in user space and don't require sudo
# If you see permission errors, check:
whoami  # Should not be root
ls -la test/  # Scripts should be executable
```

#### Python Dependency Errors
```bash
# Install required dependencies
pip3 install --user psutil

# Verify installation
python3 -c "import psutil; print('OK')"
```

#### Tests Hang or Timeout
```bash
# Tests have 5-minute timeout protection
# If hanging, check system resources:
top  # Look for high CPU/memory usage
ps aux | grep test  # Check for stuck test processes
```

### Debug Mode
```bash
# Run individual tests with verbose output
./test-user-installation.sh 2>&1 | tee debug.log

# Check test environment setup
./run-all-tests.sh 2>&1 | head -50
```

## 🎯 Test Coverage

### Installation Components
- ✅ **Commands**: 16 files validation (`A-*.md`, `B-*.md`)
- ✅ **Agents**: 10 files validation (`M1-*.md`)
- ✅ **Scripts**: 2 monitoring scripts (`context_monitor_generic.py`, `plan_detector.py`)
- ✅ **Settings**: JSON configuration validation

### Installation Scenarios
- ✅ **Clean installation** (no existing files)
- ✅ **Upgrade installation** (existing files with backup)
- ✅ **User scope only** (personal use)
- ✅ **Global scope only** (system-wide)
- ✅ **Dual scope** (user overrides global)
- ✅ **Partial installation** (incomplete user scope)

### System Validation
- ✅ **File counts** (exact number validation)
- ✅ **File permissions** (executable scripts, readable configs)
- ✅ **JSON syntax** (settings file validation)
- ✅ **Python imports** (dependency verification)
- ✅ **Directory structure** (proper hierarchy)

## 🚀 CI/CD Integration

### Exit Codes
- **0**: All tests passed
- **1**: One or more tests failed
- **2**: Environment setup failed

### GitHub Actions Example
```yaml
name: Test Claude Code Toolkit
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.8'
      - name: Install dependencies
        run: pip3 install psutil
      - name: Run test suite
        run: ./test/run-all-tests.sh
      - name: Upload test reports
        uses: actions/upload-artifact@v3
        if: always()
        with:
          name: test-reports
          path: /tmp/claude-toolkit-test-reports-*/
```

### Jenkins Pipeline Example
```groovy
pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                sh './test/run-all-tests.sh'
            }
            post {
                always {
                    archiveArtifacts artifacts: '/tmp/claude-toolkit-test-reports-*/**/*'
                    publishHTML([
                        allowMissing: false,
                        alwaysLinkToLastBuild: true,
                        keepAll: true,
                        reportDir: '/tmp/claude-toolkit-test-reports-*/',
                        reportFiles: 'master-test-report.md',
                        reportName: 'Test Report'
                    ])
                }
            }
        }
    }
}
```

## 📈 Performance Benchmarks

### Expected Performance
- **User Installation Test**: 30-60 seconds
- **Global Installation Test**: 20-40 seconds
- **Dual-Scope Precedence Test**: 45-90 seconds
- **Total Suite**: 2-4 minutes

### Performance Factors
- **System I/O speed** (SSD vs HDD)
- **Python startup time** (imports and dependency checking)
- **File system type** (ext4, NTFS, APFS)

### Optimization Tips
```bash
# Run tests on SSD for faster I/O
# Use recent Python version for faster startup
# Close other applications to reduce system load
```

## 🔒 Security Considerations

### Test Isolation
- Tests run in **user space only** (no sudo required)
- **Mock directories** prevent system modification
- **Automatic cleanup** removes all test artifacts

### Data Safety
- **Original installations backed up** before any changes
- **Complete restoration** guaranteed after test completion
- **No network access** required for testing

## 🤝 Contributing

### Adding New Tests
1. Create test script in `test/` directory
2. Follow naming convention: `test-feature-name.sh`
3. Include comprehensive assertions and cleanup
4. Add to master test runner
5. Update this documentation

### Test Framework Guidelines
- Use colored output for clarity
- Include detailed error messages
- Implement proper cleanup (trap EXIT)
- Validate all assertions with clear messages
- Generate machine-readable output when possible

## 📚 Additional Resources

- **[Installation Guide](../INSTALLATION.md)** - Complete installation documentation
- **[Auto-Install Guide](../AUTO-INSTALL.md)** - Claude Code auto-installation instructions
- **[Contributing Guide](../docs/CONTRIBUTING.md)** - Development and contribution guidelines
- **[Troubleshooting Wiki](https://github.com/Ghenwy/claude-code-toolkit/wiki/Troubleshooting)** - Community troubleshooting

---

## 🏆 ULTRATHINK Testing Framework

**Professional-grade testing system with:**

- ✅ **Comprehensive coverage** - All installation scenarios tested
- ✅ **Safety-first design** - Non-destructive with automatic backup/restore
- ✅ **Professional reporting** - Detailed analysis and troubleshooting
- ✅ **CI/CD ready** - Proper exit codes and artifact generation
- ✅ **Cross-platform** - Linux, macOS, Windows WSL support
- ✅ **Performance focused** - Optimized for speed with timeout protection

**Ready for production deployment and continuous integration.**
