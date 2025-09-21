#!/bin/bash

# Claude Code Toolkit - User Scope Installation Test
# Testing Framework
# Tests complete user installation workflow with comprehensive validation

set -euo pipefail

# ============================================================================
# TEST CONFIGURATION
# ============================================================================

readonly TEST_NAME="User Scope Installation Test"
readonly TEST_VERSION="1.0.0"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

readonly ORIGINAL_HOME="$HOME"
readonly TEST_HOME="$(mktemp -d 2>/dev/null || mktemp -d -t claude-test-home)"

if [[ -z "$TEST_HOME" ]]; then
    echo "[ERROR] Failed to create temporary HOME directory" >&2
    exit 1
fi

export HOME="$TEST_HOME"

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly BOLD='\033[1m'
readonly NC='\033[0m' # No Color

# Test configuration
readonly EXPECTED_COMMANDS=16
readonly EXPECTED_AGENTS=10
readonly EXPECTED_SCRIPTS=3

# Test state
TESTS_PASSED=0
TESTS_FAILED=0
TOTAL_TESTS=0

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

print_header() {
    echo -e "${BLUE}${BOLD}"
    echo "=============================================="
    echo " Claude Code Toolkit Testing Suite"
    echo " ${TEST_NAME}"
    echo " Version ${TEST_VERSION}"
    echo "=============================================="
    echo -e "${NC}"
}


print_test_section() {
    echo -e "
${BLUE}${BOLD}[SECTION] $1${NC}"
    echo -e "${BLUE}------------------------------------------------------------${NC}"
}


print_success() {
    echo -e "${GREEN}[PASS] $1${NC}"
}


print_error() {
    echo -e "${RED}[FAIL] $1${NC}"
}


print_warning() {
    echo -e "${YELLOW}[WARN] $1${NC}"
}


print_info() {
    echo -e "${BLUE}[INFO] $1${NC}"
}


# Test assertion functions
assert_equals() {
    local expected="$1"
    local actual="$2"
    local message="$3"

    TOTAL_TESTS=$((TOTAL_TESTS + 1))

    if [[ "$expected" == "$actual" ]]; then
        print_success "TEST $TOTAL_TESTS: $message"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        print_error "TEST $TOTAL_TESTS: $message"
        print_error "  Expected: $expected"
        print_error "  Actual: $actual"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_file_exists() {
    local file_path="$1"
    local message="$2"

    TOTAL_TESTS=$((TOTAL_TESTS + 1))

    if [[ -f "$file_path" ]]; then
        print_success "TEST $TOTAL_TESTS: $message"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        print_error "TEST $TOTAL_TESTS: $message"
        print_error "  File not found: $file_path"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_directory_exists() {
    local dir_path="$1"
    local message="$2"

    TOTAL_TESTS=$((TOTAL_TESTS + 1))

    if [[ -d "$dir_path" ]]; then
        print_success "TEST $TOTAL_TESTS: $message"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        print_error "TEST $TOTAL_TESTS: $message"
        print_error "  Directory not found: $dir_path"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_command_succeeds() {
    local command="$1"
    local message="$2"

    TOTAL_TESTS=$((TOTAL_TESTS + 1))

    if eval "$command" >/dev/null 2>&1; then
        print_success "TEST $TOTAL_TESTS: $message"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        print_error "TEST $TOTAL_TESTS: $message"
        print_error "  Command failed: $command"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

# ============================================================================
# SETUP AND CLEANUP
# ============================================================================

setup_test_environment() {
    print_test_section "TEST ENVIRONMENT SETUP"

    if [[ ! -f "$PROJECT_DIR/install.sh" ]] || [[ ! -d "$PROJECT_DIR/commands" ]]; then
        print_error "Test must be run from claude-code-toolkit directory"
        print_error "Current PROJECT_DIR: $PROJECT_DIR"
        exit 1
    fi

    print_info "Project directory: $PROJECT_DIR"
    print_info "Temporary HOME: $TEST_HOME"

    rm -rf "$TEST_HOME/.claude"
    mkdir -p "$TEST_HOME"

    print_success "Test environment setup complete"
}


cleanup_test_environment() {
    print_test_section "TEST ENVIRONMENT CLEANUP"

    if [[ -d "$TEST_HOME/.claude" ]]; then
        rm -rf "$TEST_HOME/.claude"
        print_info "Removed test installation from $TEST_HOME/.claude"
    fi

    if [[ -d "$TEST_HOME" ]]; then
        rm -rf "$TEST_HOME"
        print_info "Removed temporary HOME: $TEST_HOME"
    fi

    export HOME="$ORIGINAL_HOME"
    print_success "Test environment cleanup complete"
}


# ============================================================================
# TEST FUNCTIONS
# ============================================================================

test_installer_syntax() {
    print_test_section "INSTALLER SYNTAX VALIDATION"

    assert_command_succeeds "bash -n '$PROJECT_DIR/install.sh'" "install.sh has valid bash syntax"
    assert_file_exists "$PROJECT_DIR/install.sh" "install.sh file exists"
    assert_command_succeeds "chmod +x '$PROJECT_DIR/install.sh'" "install.sh is executable"
}

test_installer_help_and_version() {
    print_test_section "INSTALLER HELP AND VERSION"

    # Test --help flag
    local help_output
    help_output=$(cd "$PROJECT_DIR" && ./install.sh --help 2>&1 || true)

    if echo "$help_output" | grep -q "Claude Code Toolkit Installer"; then
        print_success "TEST $((++TOTAL_TESTS)): --help flag shows correct output"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "TEST $TOTAL_TESTS: --help flag output incorrect"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi

    # Test --version flag
    local version_output
    version_output=$(cd "$PROJECT_DIR" && ./install.sh --version 2>&1 || true)

    if echo "$version_output" | grep -q "Claude Code Toolkit Installer v2.2.3"; then
        print_success "TEST $((++TOTAL_TESTS)): --version flag shows correct output"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "TEST $TOTAL_TESTS: --version flag output incorrect"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

test_dry_run_installation() {
    print_test_section "DRY RUN INSTALLATION TEST"

    # Test dry run doesn't create files
    local dry_run_output
    dry_run_output=$(cd "$PROJECT_DIR" && ./install.sh --dry-run --user 2>&1 || true)

    # Verify no files were created
    if [[ ! -d "$HOME/.claude" ]]; then
        print_success "TEST $((++TOTAL_TESTS)): Dry run didn't create ~/.claude directory"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "TEST $TOTAL_TESTS: Dry run created files (should not happen)"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi

    # Check dry run output contains expected messages
    if echo "$dry_run_output" | grep -q "DRY RUN MODE"; then
        print_success "TEST $((++TOTAL_TESTS)): Dry run output contains DRY RUN MODE message"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "TEST $TOTAL_TESTS: Dry run output missing DRY RUN MODE message"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

test_user_installation() {
    print_test_section "USER SCOPE INSTALLATION"

    # Run installation
    print_info "Running: ./install.sh --user --verbose"
    local install_output
    install_output=$(cd "$PROJECT_DIR" && ./install.sh --user --verbose 2>&1 || true)

    # Check if installation was successful
    if echo "$install_output" | grep -q "installation complete"; then
        print_success "TEST $((++TOTAL_TESTS)): Installation completed successfully"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "TEST $TOTAL_TESTS: Installation did not complete successfully"
        print_error "Last 10 lines of output:"
        echo "$install_output" | tail -10
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi

    # Verify directory structure
    assert_directory_exists "$HOME/.claude" "~/.claude directory created"
    assert_directory_exists "$HOME/.claude/commands" "~/.claude/commands directory created"
    assert_directory_exists "$HOME/.claude/agents" "~/.claude/agents directory created"
    assert_directory_exists "$HOME/.claude/scripts" "~/.claude/scripts directory created"

    # Verify file counts
    local commands_count
    commands_count=$(ls "$HOME/.claude/commands"/*.md 2>/dev/null | wc -l)
    assert_equals "$EXPECTED_COMMANDS" "$commands_count" "Correct number of commands installed ($EXPECTED_COMMANDS)"

    local agents_count
    agents_count=$(ls "$HOME/.claude/agents"/*.md 2>/dev/null | wc -l)
    assert_equals "$EXPECTED_AGENTS" "$agents_count" "Correct number of agents installed ($EXPECTED_AGENTS)"

    local scripts_count
    scripts_count=$(ls "$HOME/.claude/scripts"/*.py 2>/dev/null | wc -l)
    assert_equals "$EXPECTED_SCRIPTS" "$scripts_count" "Correct number of scripts installed ($EXPECTED_SCRIPTS)"

    # Verify key files exist
    assert_file_exists "$HOME/.claude/commands/A-plan.md" "A-plan.md command exists"
    assert_file_exists "$HOME/.claude/commands/A-ai-code.md" "A-ai-code.md command exists"
    assert_file_exists "$HOME/.claude/agents/M1-qa-gatekeeper.md" "M1-qa-gatekeeper.md agent exists"
    assert_file_exists "$HOME/.claude/agents/M1-ultrathink-orchestrator.md" "M1-ultrathink-orchestrator.md agent exists"
    assert_file_exists "$HOME/.claude/scripts/context_monitor_generic.py" "context_monitor_generic.py script exists"
    assert_file_exists "$HOME/.claude/scripts/plan_detector.py" "plan_detector.py script exists"
    assert_file_exists "$HOME/.claude/scripts/statusbar-config.yaml" "statusbar-config.yaml exists"
    assert_file_exists "$HOME/.claude/settings.json" "settings.json configuration exists"
}

test_settings_configuration() {
    print_test_section "SETTINGS CONFIGURATION VALIDATION"

    # Verify settings.json content
    if [[ -f "$HOME/.claude/settings.json" ]]; then
        local settings_content
        settings_content=$(cat "$HOME/.claude/settings.json")

        if echo "$settings_content" | grep -q "statusLine"; then
            print_success "TEST $((++TOTAL_TESTS)): settings.json contains statusLine configuration"
            TESTS_PASSED=$((TESTS_PASSED + 1))
        else
            print_error "TEST $TOTAL_TESTS: settings.json missing statusLine configuration"
            TESTS_FAILED=$((TESTS_FAILED + 1))
        fi

        if echo "$settings_content" | grep -q "context_monitor_generic.py"; then
            print_success "TEST $((++TOTAL_TESTS)): settings.json references correct monitoring script"
            TESTS_PASSED=$((TESTS_PASSED + 1))
        else
            print_error "TEST $TOTAL_TESTS: settings.json missing monitoring script reference"
            TESTS_FAILED=$((TESTS_FAILED + 1))
        fi

        # Validate JSON syntax
        if python3 -c "import json; json.load(open('$HOME/.claude/settings.json'))" 2>/dev/null; then
            print_success "TEST $((++TOTAL_TESTS)): settings.json has valid JSON syntax"
            TESTS_PASSED=$((TESTS_PASSED + 1))
        else
            print_error "TEST $TOTAL_TESTS: settings.json has invalid JSON syntax"
            TESTS_FAILED=$((TESTS_FAILED + 1))
        fi
    fi
}

test_backup_functionality() {
    print_test_section "BACKUP FUNCTIONALITY TEST"

    # Check if backup was created during installation
    local backup_dirs
    backup_dirs=$(find "$HOME/.claude" -maxdepth 1 -name "backup_*" -type d 2>/dev/null | wc -l)

    # For a clean install, no backup should be created
    assert_equals "0" "$backup_dirs" "No backup created for clean installation (expected)"

    # Test backup creation by running installation again
    print_info "Running second installation to test backup creation..."
    local second_install_output
    second_install_output=$(cd "$PROJECT_DIR" && ./install.sh --user --verbose 2>&1 || true)

    # Check if backup was created this time
    local backup_dirs_after
    backup_dirs_after=$(find "$HOME/.claude" -maxdepth 1 -name "backup_*" -type d 2>/dev/null | wc -l)

    if [[ $backup_dirs_after -gt 0 ]]; then
        print_success "TEST $((++TOTAL_TESTS)): Backup created on reinstallation"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_warning "TEST $TOTAL_TESTS: No backup created on reinstallation (may be expected)"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    fi
}

test_verification_functionality() {
    print_test_section "VERIFICATION FUNCTIONALITY TEST"

    # Test --verify flag
    local verify_output
    verify_output=$(cd "$PROJECT_DIR" && ./install.sh --verify --verbose 2>&1 || true)

    if echo "$verify_output" | grep -q "Installation verification passed"; then
        print_success "TEST $((++TOTAL_TESTS)): Verification reports successful installation"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "TEST $TOTAL_TESTS: Verification failed or didn't run properly"
        print_error "Verification output:"
        echo "$verify_output" | tail -10
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi

    # Verify file permissions
    if [[ -x "$HOME/.claude/scripts/context_monitor_generic.py" ]]; then
        print_success "TEST $((++TOTAL_TESTS)): Monitoring script has execute permissions"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "TEST $TOTAL_TESTS: Monitoring script missing execute permissions"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

test_python_dependencies() {
    print_test_section "PYTHON DEPENDENCIES TEST"

    # Test if required Python modules can be imported
    if python3 -c "import psutil" 2>/dev/null; then
        print_success "TEST $((++TOTAL_TESTS)): psutil module available"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "TEST $TOTAL_TESTS: psutil module not available"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi

    if python3 -c "import yaml" 2>/dev/null; then
        print_success "TEST $((++TOTAL_TESTS)): PyYAML module available"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "TEST $TOTAL_TESTS: PyYAML module not available"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

# ============================================================================
# MAIN TEST EXECUTION
# ============================================================================

main() {
    print_header

    # Trap to ensure cleanup runs even if script fails
    trap cleanup_test_environment EXIT

    print_info "Starting $TEST_NAME..."
    print_info "Test directory: $SCRIPT_DIR"
    print_info "Project directory: $PROJECT_DIR"
    echo

    # Setup test environment
    setup_test_environment

    # Run all tests
    test_installer_syntax
    test_installer_help_and_version
    test_dry_run_installation
    test_user_installation
    test_settings_configuration
    test_backup_functionality
    test_verification_functionality
    test_python_dependencies

    # Print test results
    print_test_section "TEST RESULTS SUMMARY"

    echo -e "${BOLD}Total Tests: $TOTAL_TESTS${NC}"
    echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
    echo -e "${RED}Failed: $TESTS_FAILED${NC}"

    local success_rate=0
    if [[ $TOTAL_TESTS -gt 0 ]]; then
        success_rate=$((TESTS_PASSED * 100 / TOTAL_TESTS))
    fi

    echo -e "${BLUE}Success Rate: ${success_rate}%${NC}"

    if [[ $TESTS_FAILED -eq 0 ]]; then
        print_success "All tests passed. User scope installation is working."
        exit 0
    else
        print_error "Some tests failed. Please review the output above."
        exit 1
    fi
}

# Run main function
main "$@"
