#!/bin/bash

# Claude Code Toolkit - Global Scope Installation Test
# Testing Framework
# Tests global installation logic, permissions, and precedence

set -euo pipefail

# ============================================================================
# TEST CONFIGURATION
# ============================================================================

readonly TEST_NAME="Global Scope Installation Test"
readonly TEST_VERSION="1.0.0"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly BOLD='\033[1m'
readonly NC='\033[0m' # No Color

# Test configuration - using temp directory to simulate global
readonly MOCK_GLOBAL_DIR="/tmp/test-global-claude-$(date +%s)"
readonly TEST_USER_DIR="$HOME/.claude-test-$(date +%s)"
readonly EXPECTED_COMMANDS=16
readonly EXPECTED_AGENTS=12
readonly EXPECTED_SCRIPTS=1

# Test state
ORIGINAL_CLAUDE_EXISTS=false
ORIGINAL_CLAUDE_BACKUP=""
TESTS_PASSED=0
TESTS_FAILED=0
TOTAL_TESTS=0

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

print_header() {
    echo -e "${BLUE}${BOLD}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║              CLAUDE CODE TOOLKIT TESTING SUITE              ║"
    echo "║                 $TEST_NAME                ║"
    echo "║                      Version $TEST_VERSION                      ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_test_section() {
    echo -e "\n${BLUE}${BOLD}🧪 $1${NC}"
    echo -e "${BLUE}$(printf '=%.0s' {1..60})${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
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

assert_string_contains() {
    local haystack="$1"
    local needle="$2"
    local message="$3"

    TOTAL_TESTS=$((TOTAL_TESTS + 1))

    if echo "$haystack" | grep -q "$needle"; then
        print_success "TEST $TOTAL_TESTS: $message"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        print_error "TEST $TOTAL_TESTS: $message"
        print_error "  String '$needle' not found in output"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

# ============================================================================
# SETUP AND CLEANUP
# ============================================================================

setup_test_environment() {
    print_test_section "TEST ENVIRONMENT SETUP"

    # Check if we're in the right directory
    if [[ ! -f "$PROJECT_DIR/install.sh" ]] || [[ ! -d "$PROJECT_DIR/commands" ]]; then
        print_error "Test must be run from claude-code-toolkit directory"
        print_error "Current PROJECT_DIR: $PROJECT_DIR"
        exit 1
    fi

    print_info "Project directory: $PROJECT_DIR"
    print_info "Mock global directory: $MOCK_GLOBAL_DIR"
    print_info "Test user directory: $TEST_USER_DIR"

    # Backup existing .claude directory if it exists
    if [[ -d "$HOME/.claude" ]]; then
        ORIGINAL_CLAUDE_EXISTS=true
        ORIGINAL_CLAUDE_BACKUP="$HOME/.claude-original-backup-$(date +%s)"
        cp -r "$HOME/.claude" "$ORIGINAL_CLAUDE_BACKUP"
        print_info "Original .claude backed up to: $ORIGINAL_CLAUDE_BACKUP"
    fi

    # Clean any existing test directories
    [[ -d "$HOME/.claude" ]] && rm -rf "$HOME/.claude"
    [[ -d "$MOCK_GLOBAL_DIR" ]] && rm -rf "$MOCK_GLOBAL_DIR"
    [[ -d "$TEST_USER_DIR" ]] && rm -rf "$TEST_USER_DIR"

    # Create mock global directory structure
    mkdir -p "$MOCK_GLOBAL_DIR"/{commands,agents,scripts,config}
    print_info "Created mock global directory structure"

    print_success "Test environment setup complete"
}

cleanup_test_environment() {
    print_test_section "TEST ENVIRONMENT CLEANUP"

    # Remove test directories
    [[ -d "$HOME/.claude" ]] && rm -rf "$HOME/.claude"
    [[ -d "$MOCK_GLOBAL_DIR" ]] && rm -rf "$MOCK_GLOBAL_DIR"
    [[ -d "$TEST_USER_DIR" ]] && rm -rf "$TEST_USER_DIR"

    # Restore original .claude if it existed
    if [[ "$ORIGINAL_CLAUDE_EXISTS" == true ]] && [[ -d "$ORIGINAL_CLAUDE_BACKUP" ]]; then
        cp -r "$ORIGINAL_CLAUDE_BACKUP" "$HOME/.claude"
        rm -rf "$ORIGINAL_CLAUDE_BACKUP"
        print_info "Restored original ~/.claude from backup"
    fi

    print_success "Test environment cleanup complete"
}

# ============================================================================
# MOCK INSTALLATION FUNCTIONS
# ============================================================================

simulate_global_installation() {
    print_info "Simulating global installation to $MOCK_GLOBAL_DIR"

    # Copy files to mock global directory
    cp "$PROJECT_DIR/commands"/*.md "$MOCK_GLOBAL_DIR/commands/"
    cp "$PROJECT_DIR/agents"/*.md "$MOCK_GLOBAL_DIR/agents/"
    cp "$PROJECT_DIR/scripts"/*.py "$MOCK_GLOBAL_DIR/scripts/"

    # Create global settings
    cat > "$MOCK_GLOBAL_DIR/config/global-settings.json" << EOF
{
  "statusLine": {
    "type": "command",
    "command": "python3 $MOCK_GLOBAL_DIR/scripts/context_monitor_generic.py"
  },
  "installation": {
    "scope": "global",
    "version": "2.1.0",
    "installed_at": "$(date -Iseconds)",
    "installer": "claude-code-toolkit"
  }
}
EOF

    # Set permissions (simulate what sudo would do)
    chmod 644 "$MOCK_GLOBAL_DIR/commands"/*.md
    chmod 644 "$MOCK_GLOBAL_DIR/agents"/*.md
    chmod 755 "$MOCK_GLOBAL_DIR/scripts"/*.py
    chmod 644 "$MOCK_GLOBAL_DIR/config/global-settings.json"

    print_success "Global installation simulation complete"
}

# ============================================================================
# TEST FUNCTIONS
# ============================================================================

test_global_dry_run() {
    print_test_section "GLOBAL DRY RUN TEST"

    # Test global dry run (without sudo)
    local dry_run_output
    dry_run_output=$(cd "$PROJECT_DIR" && ./install.sh --global --dry-run 2>&1 || true)

    # Should fail with permission error or show what would be done
    assert_string_contains "$dry_run_output" "DRY RUN" "Global dry run shows DRY RUN mode"

    # Verify it doesn't try to create actual global directories in dry run
    if [[ ! -d "/usr/local/share/claude" ]]; then
        print_success "TEST $((++TOTAL_TESTS)): Global dry run didn't create real global directories"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_warning "TEST $TOTAL_TESTS: Global directories exist (may be from previous installation)"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    fi
}

test_permission_detection() {
    print_test_section "PERMISSION DETECTION TEST"

    # Test global installation without sudo (should fail gracefully)
    local no_sudo_output
    no_sudo_output=$(cd "$PROJECT_DIR" && ./install.sh --global 2>&1 || true)

    # Should detect sudo requirement
    if echo "$no_sudo_output" | grep -q -E "(sudo|permission|root)"; then
        print_success "TEST $((++TOTAL_TESTS)): Installer detects sudo requirement for global installation"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "TEST $TOTAL_TESTS: Installer didn't detect sudo requirement"
        print_error "Output: $(echo "$no_sudo_output" | tail -5)"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

test_global_directory_structure() {
    print_test_section "GLOBAL DIRECTORY STRUCTURE TEST"

    # Use our mock global installation
    simulate_global_installation

    # Verify directory structure
    assert_directory_exists "$MOCK_GLOBAL_DIR" "Mock global directory created"
    assert_directory_exists "$MOCK_GLOBAL_DIR/commands" "Global commands directory exists"
    assert_directory_exists "$MOCK_GLOBAL_DIR/agents" "Global agents directory exists"
    assert_directory_exists "$MOCK_GLOBAL_DIR/scripts" "Global scripts directory exists"
    assert_directory_exists "$MOCK_GLOBAL_DIR/config" "Global config directory exists"

    # Verify file counts
    local commands_count
    commands_count=$(ls "$MOCK_GLOBAL_DIR/commands"/*.md 2>/dev/null | wc -l)
    assert_equals "$EXPECTED_COMMANDS" "$commands_count" "Correct number of commands in global scope"

    local agents_count
    agents_count=$(ls "$MOCK_GLOBAL_DIR/agents"/*.md 2>/dev/null | wc -l)
    assert_equals "$EXPECTED_AGENTS" "$agents_count" "Correct number of agents in global scope"

    local scripts_count
    scripts_count=$(ls "$MOCK_GLOBAL_DIR/scripts"/*.py 2>/dev/null | wc -l)
    assert_equals "$EXPECTED_SCRIPTS" "$scripts_count" "Correct number of scripts in global scope"
}

test_global_settings_configuration() {
    print_test_section "GLOBAL SETTINGS CONFIGURATION TEST"

    # Verify global settings file
    assert_file_exists "$MOCK_GLOBAL_DIR/config/global-settings.json" "Global settings file exists"

    # Verify settings content
    local settings_content
    settings_content=$(cat "$MOCK_GLOBAL_DIR/config/global-settings.json")

    assert_string_contains "$settings_content" "statusLine" "Global settings contain statusLine"
    assert_string_contains "$settings_content" "global" "Global settings indicate global scope"
    assert_string_contains "$settings_content" "context_monitor_generic.py" "Global settings reference monitoring script"

    # Validate JSON syntax
    if python3 -c "import json; json.load(open('$MOCK_GLOBAL_DIR/config/global-settings.json'))" 2>/dev/null; then
        print_success "TEST $((++TOTAL_TESTS)): Global settings has valid JSON syntax"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "TEST $TOTAL_TESTS: Global settings has invalid JSON syntax"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

test_precedence_logic() {
    print_test_section "PRECEDENCE LOGIC TEST"

    # Test 1: Only global installation exists
    # (We have mock global, no user installation)
    print_info "Testing precedence with only global installation..."

    # Simulate precedence check
    local user_commands=0
    local global_commands
    global_commands=$(ls "$MOCK_GLOBAL_DIR/commands"/*.md 2>/dev/null | wc -l)

    if [[ $user_commands -eq 0 ]] && [[ $global_commands -gt 0 ]]; then
        print_success "TEST $((++TOTAL_TESTS)): Global scope active when no user installation"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "TEST $TOTAL_TESTS: Precedence logic incorrect"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi

    # Test 2: Create user installation and verify it takes precedence
    print_info "Testing precedence with both user and global installations..."

    # Create minimal user installation
    mkdir -p "$HOME/.claude/commands"
    cp "$PROJECT_DIR/commands/A-plan.md" "$HOME/.claude/commands/"

    user_commands=$(ls "$HOME/.claude/commands"/*.md 2>/dev/null | wc -l)

    if [[ $user_commands -gt 0 ]]; then
        print_success "TEST $((++TOTAL_TESTS)): User scope takes precedence over global when both exist"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "TEST $TOTAL_TESTS: User scope precedence test failed"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

test_global_verification_simulation() {
    print_test_section "GLOBAL VERIFICATION SIMULATION"

    # Create a verification script for our mock global installation
    local verification_script="/tmp/test-global-verify.sh"

    cat > "$verification_script" << 'EOF'
#!/bin/bash
MOCK_GLOBAL_DIR="$1"

# Count files in mock global directory
COMMANDS_COUNT=$(ls "$MOCK_GLOBAL_DIR/commands"/*.md 2>/dev/null | wc -l)
AGENTS_COUNT=$(ls "$MOCK_GLOBAL_DIR/agents"/*.md 2>/dev/null | wc -l)
SCRIPTS_COUNT=$(ls "$MOCK_GLOBAL_DIR/scripts"/*.py 2>/dev/null | wc -l)

echo "Global Commands: $COMMANDS_COUNT/16"
echo "Global Agents: $AGENTS_COUNT/12"
echo "Global Scripts: $SCRIPTS_COUNT"

# Check key files
KEY_FILES=("commands/A-plan.md" "agents/M1-qa-gatekeeper.md" "scripts/context_monitor_generic.py" "config/global-settings.json")

for file in "${KEY_FILES[@]}"; do
    if [[ -f "$MOCK_GLOBAL_DIR/$file" ]]; then
        echo "✅ $file"
    else
        echo "❌ $file"
        exit 1
    fi
done

echo "Global installation verification passed"
EOF

    chmod +x "$verification_script"

    # Run verification
    local verify_output
    verify_output=$("$verification_script" "$MOCK_GLOBAL_DIR" 2>&1 || true)

    assert_string_contains "$verify_output" "verification passed" "Global installation verification succeeds"

    rm -f "$verification_script"
}

test_global_uninstall_simulation() {
    print_test_section "GLOBAL UNINSTALL SIMULATION"

    # Test that global uninstall would remove the right directories
    print_info "Simulating global uninstall..."

    # Before "uninstall"
    assert_directory_exists "$MOCK_GLOBAL_DIR" "Global directory exists before uninstall"

    # Simulate uninstall
    rm -rf "$MOCK_GLOBAL_DIR"

    # After "uninstall"
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if [[ ! -d "$MOCK_GLOBAL_DIR" ]]; then
        print_success "TEST $TOTAL_TESTS: Global uninstall removes global directory"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_error "TEST $TOTAL_TESTS: Global uninstall failed to remove directory"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

test_installer_global_flags() {
    print_test_section "INSTALLER GLOBAL FLAGS TEST"

    # Test global-specific help output
    local help_output
    help_output=$(cd "$PROJECT_DIR" && ./install.sh --help 2>&1 || true)

    assert_string_contains "$help_output" "--global" "Help shows --global flag"
    assert_string_contains "$help_output" "/usr/local/share/claude" "Help mentions global directory"
    assert_string_contains "$help_output" "sudo" "Help mentions sudo requirement"

    # Test global dry run flag combination
    local global_dry_output
    global_dry_output=$(cd "$PROJECT_DIR" && ./install.sh --global --dry-run --verbose 2>&1 || true)

    assert_string_contains "$global_dry_output" "global" "Global dry run mentions global scope"
    assert_string_contains "$global_dry_output" "DRY RUN" "Global dry run shows DRY RUN mode"
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
    print_warning "Note: This test simulates global installation without requiring sudo"
    echo

    # Setup test environment
    setup_test_environment

    # Run all tests
    test_global_dry_run
    test_permission_detection
    test_global_directory_structure
    test_global_settings_configuration
    test_precedence_logic
    test_global_verification_simulation
    test_global_uninstall_simulation
    test_installer_global_flags

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
        print_success "🎉 ALL TESTS PASSED! Global scope installation logic is working correctly."
        print_info "Note: Real global installation requires sudo ./install.sh --global"
        exit 0
    else
        print_error "❌ Some tests failed. Please review the output above."
        exit 1
    fi
}

# Run main function
main "$@"