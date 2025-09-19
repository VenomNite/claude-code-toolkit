#!/bin/bash

# Claude Code Toolkit - Master Test Runner
# Testing Framework
# Runs comprehensive test suite for dual-scope installation system

set -euo pipefail

# ============================================================================
# TEST CONFIGURATION
# ============================================================================

readonly TEST_SUITE_NAME="Claude Code Toolkit Complete Test Suite"
readonly TEST_SUITE_VERSION="1.0.0"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly BOLD='\033[1m'
readonly NC='\033[0m' # No Color

# Test configuration
readonly REPORT_DIR="/tmp/claude-toolkit-test-reports-$(date +%Y%m%d_%H%M%S)"
readonly TEST_TIMEOUT=300  # 5 minutes per test

# Test suite state
declare -a TEST_RESULTS=()
declare -a TEST_TIMES=()
declare -a TEST_NAMES=()
TOTAL_SUITE_TIME=0
TESTS_PASSED=0
TESTS_FAILED=0

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

print_suite_header() {
    echo -e "${BLUE}${BOLD}"
    echo "╔════════════════════════════════════════════════════════════════════╗"
    echo "║                CLAUDE CODE TOOLKIT TESTING SUITE                  ║"
    echo "║                        Testing Framework                       ║"
    echo "║                         Version $TEST_SUITE_VERSION                          ║"
    echo "╚════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_section() {
    echo -e "\n${BLUE}${BOLD}🚀 $1${NC}"
    echo -e "${BLUE}$(printf '=%.0s' {1..70})${NC}"
}

print_test_header() {
    echo -e "\n${YELLOW}${BOLD}🧪 Running: $1${NC}"
    echo -e "${YELLOW}$(printf '-%.0s' {1..50})${NC}"
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

format_time() {
    local seconds=$1
    if [[ $seconds -lt 60 ]]; then
        echo "${seconds}s"
    else
        local minutes=$((seconds / 60))
        local remaining_seconds=$((seconds % 60))
        echo "${minutes}m ${remaining_seconds}s"
    fi
}

# ============================================================================
# TEST EXECUTION FUNCTIONS
# ============================================================================

run_single_test() {
    local test_script="$1"
    local test_name="$2"
    local test_index="$3"

    print_test_header "$test_name"

    local start_time=$(date +%s)
    local test_output=""
    local test_exit_code=0

    # Create individual test report file
    local test_report="$REPORT_DIR/test-$test_index-$(basename "$test_script" .sh).log"

    # Run test with timeout
    if timeout "$TEST_TIMEOUT" "$test_script" > "$test_report" 2>&1; then
        test_exit_code=0
        print_success "$test_name completed successfully"
    else
        test_exit_code=$?
        if [[ $test_exit_code -eq 124 ]]; then
            print_error "$test_name timed out after $(format_time $TEST_TIMEOUT)"
            echo "TEST TIMED OUT AFTER $TEST_TIMEOUT SECONDS" >> "$test_report"
        else
            print_error "$test_name failed with exit code $test_exit_code"
        fi
    fi

    local end_time=$(date +%s)
    local test_duration=$((end_time - start_time))

    # Store results
    TEST_RESULTS[$test_index]=$test_exit_code
    TEST_TIMES[$test_index]=$test_duration
    TEST_NAMES[$test_index]="$test_name"

    # Update counters
    if [[ $test_exit_code -eq 0 ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_info "Duration: $(format_time $test_duration)"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_error "Duration: $(format_time $test_duration)"
        print_warning "Check detailed log: $test_report"
    fi

    TOTAL_SUITE_TIME=$((TOTAL_SUITE_TIME + test_duration))

    return $test_exit_code
}

# ============================================================================
# PRE-FLIGHT CHECKS
# ============================================================================

check_test_environment() {
    print_section "PRE-FLIGHT ENVIRONMENT CHECKS"

    # Check if we're in the right directory
    if [[ ! -f "$PROJECT_DIR/install.sh" ]] || [[ ! -d "$PROJECT_DIR/commands" ]]; then
        print_error "Tests must be run from claude-code-toolkit directory"
        print_error "Current PROJECT_DIR: $PROJECT_DIR"
        exit 1
    fi

    print_success "Project directory validated: $PROJECT_DIR"

    # Check if test scripts exist
    local test_scripts=(
        "$SCRIPT_DIR/test-user-installation.sh"
        "$SCRIPT_DIR/test-global-installation.sh"
        "$SCRIPT_DIR/test-dual-scope-precedence.sh"
    )

    for script in "${test_scripts[@]}"; do
        if [[ -f "$script" ]] && [[ -x "$script" ]]; then
            print_success "Test script found: $(basename "$script")"
        else
            print_error "Test script missing or not executable: $(basename "$script")"
            exit 1
        fi
    done

    # Check system dependencies
    if command -v python3 &> /dev/null; then
        local python_version
        python_version=$(python3 --version | cut -d' ' -f2)
        print_success "Python 3 available: $python_version"
    else
        print_error "Python 3 required but not found"
        exit 1
    fi

    if command -v timeout &> /dev/null; then
        print_success "timeout command available"
    else
        print_warning "timeout command not available - tests may run indefinitely if hung"
    fi

    # Create report directory
    mkdir -p "$REPORT_DIR"
    print_success "Report directory created: $REPORT_DIR"

    print_info "Pre-flight checks complete"
}

check_installer_syntax() {
    print_section "INSTALLER SYNTAX VALIDATION"

    # Check install.sh syntax
    if bash -n "$PROJECT_DIR/install.sh"; then
        print_success "install.sh syntax is valid"
    else
        print_error "install.sh has syntax errors"
        exit 1
    fi

    # Check basic installer functionality
    local help_output
    if help_output=$(cd "$PROJECT_DIR" && ./install.sh --help 2>&1); then
        print_success "install.sh --help works"

        if echo "$help_output" | grep -q "Dual-scope"; then
            print_success "install.sh shows dual-scope architecture"
        else
            print_warning "install.sh help may be outdated"
        fi
    else
        print_error "install.sh --help failed"
        exit 1
    fi

    # Check version output
    local version_output
    if version_output=$(cd "$PROJECT_DIR" && ./install.sh --version 2>&1); then
        print_success "install.sh --version works"
        print_info "Version: $(echo "$version_output" | head -1)"
    else
        print_error "install.sh --version failed"
        exit 1
    fi

    print_info "Installer validation complete"
}

# ============================================================================
# TEST EXECUTION
# ============================================================================

run_test_suite() {
    print_section "EXECUTING COMPLETE TEST SUITE"

    local suite_start_time=$(date +%s)

    # Test 1: User Scope Installation
    run_single_test \
        "$SCRIPT_DIR/test-user-installation.sh" \
        "User Scope Installation Test" \
        0

    # Test 2: Global Scope Installation (with simulation)
    run_single_test \
        "$SCRIPT_DIR/test-global-installation.sh" \
        "Global Scope Installation Test" \
        1

    # Test 3: Dual-Scope Precedence
    run_single_test \
        "$SCRIPT_DIR/test-dual-scope-precedence.sh" \
        "Dual-Scope Precedence Test" \
        2

    local suite_end_time=$(date +%s)
    TOTAL_SUITE_TIME=$((suite_end_time - suite_start_time))

    print_info "Test suite execution complete"
}

# ============================================================================
# REPORTING
# ============================================================================

generate_detailed_report() {
    print_section "GENERATING DETAILED REPORTS"

    local master_report="$REPORT_DIR/master-test-report.md"

    cat > "$master_report" << EOF
# Claude Code Toolkit - Test Suite Report

**Test Suite:** $TEST_SUITE_NAME v$TEST_SUITE_VERSION
**Execution Date:** $(date -Iseconds)
**Total Duration:** $(format_time $TOTAL_SUITE_TIME)
**Tests Passed:** $TESTS_PASSED
**Tests Failed:** $TESTS_FAILED

## Executive Summary

$(if [[ $TESTS_FAILED -eq 0 ]]; then
    echo "✅ **ALL TESTS PASSED** - The dual-scope installation system is production ready."
else
    echo "❌ **$TESTS_FAILED TEST(S) FAILED** - Review individual test reports for details."
fi)

## Test Results Summary

| Test | Status | Duration | Details |
|------|--------|----------|---------|
EOF

    # Add test results to table
    for i in {0..2}; do
        local status_icon="❌"
        local status_text="FAILED"

        if [[ ${TEST_RESULTS[$i]} -eq 0 ]]; then
            status_icon="✅"
            status_text="PASSED"
        fi

        echo "| ${TEST_NAMES[$i]} | $status_icon $status_text | $(format_time ${TEST_TIMES[$i]}) | [Log](test-$((i+1))-*.log) |" >> "$master_report"
    done

    cat >> "$master_report" << EOF

## System Information

- **OS:** $(uname -s) $(uname -r)
- **Python:** $(python3 --version 2>&1)
- **Git:** $(git --version 2>&1 || echo "Not available")
- **Project Directory:** $PROJECT_DIR
- **Report Directory:** $REPORT_DIR

## Detailed Test Outputs

See individual test log files in the report directory for detailed output from each test.

## Architecture Validation

The test suite validates the following dual-scope architecture features:

- ✅ User scope installation (`~/.claude/`)
- ✅ Global scope installation (`/usr/local/share/claude/`)
- ✅ Precedence system (User → Global → Built-in)
- ✅ Permission handling and sudo detection
- ✅ Backup and restore functionality
- ✅ Settings configuration (user and global)
- ✅ File count validation (16 commands, 10 agents)
- ✅ JSON syntax validation
- ✅ Python dependency checking
- ✅ Scope switching and conflict resolution

---

**Generated by Testing Framework v$TEST_SUITE_VERSION**
EOF

    print_success "Master report generated: $master_report"

    # Generate summary stats
    local stats_file="$REPORT_DIR/test-statistics.json"
    cat > "$stats_file" << EOF
{
  "test_suite": "$TEST_SUITE_NAME",
  "version": "$TEST_SUITE_VERSION",
  "execution_time": "$(date -Iseconds)",
  "total_duration_seconds": $TOTAL_SUITE_TIME,
  "tests_passed": $TESTS_PASSED,
  "tests_failed": $TESTS_FAILED,
  "total_tests": 3,
  "success_rate": $(( (TESTS_PASSED * 100) / 3 )),
  "individual_tests": [
    {
      "name": "${TEST_NAMES[0]}",
      "status": "$(if [[ ${TEST_RESULTS[0]} -eq 0 ]]; then echo "passed"; else echo "failed"; fi)",
      "duration_seconds": ${TEST_TIMES[0]},
      "exit_code": ${TEST_RESULTS[0]}
    },
    {
      "name": "${TEST_NAMES[1]}",
      "status": "$(if [[ ${TEST_RESULTS[1]} -eq 0 ]]; then echo "passed"; else echo "failed"; fi)",
      "duration_seconds": ${TEST_TIMES[1]},
      "exit_code": ${TEST_RESULTS[1]}
    },
    {
      "name": "${TEST_NAMES[2]}",
      "status": "$(if [[ ${TEST_RESULTS[2]} -eq 0 ]]; then echo "passed"; else echo "failed"; fi)",
      "duration_seconds": ${TEST_TIMES[2]},
      "exit_code": ${TEST_RESULTS[2]}
    }
  ]
}
EOF

    print_success "Statistics file generated: $stats_file"
}

print_final_summary() {
    print_section "FINAL TEST SUITE SUMMARY"

    echo -e "${BOLD}Claude Code Toolkit Test Suite Results${NC}"
    echo -e "${BOLD}════════════════════════════════════════${NC}"
    echo
    echo -e "📊 ${BOLD}Overall Statistics:${NC}"
    echo -e "   Total Tests: ${BOLD}3${NC}"
    echo -e "   Passed: ${GREEN}${BOLD}$TESTS_PASSED${NC}"
    echo -e "   Failed: ${RED}${BOLD}$TESTS_FAILED${NC}"
    echo -e "   Success Rate: ${BOLD}$(( (TESTS_PASSED * 100) / 3 ))%${NC}"
    echo -e "   Total Duration: ${BOLD}$(format_time $TOTAL_SUITE_TIME)${NC}"
    echo

    echo -e "🧪 ${BOLD}Individual Test Results:${NC}"
    for i in {0..2}; do
        local status_color=$RED
        local status_text="FAILED"

        if [[ ${TEST_RESULTS[$i]} -eq 0 ]]; then
            status_color=$GREEN
            status_text="PASSED"
        fi

        echo -e "   $((i+1)). ${TEST_NAMES[$i]}"
        echo -e "      Status: ${status_color}${BOLD}$status_text${NC}"
        echo -e "      Duration: $(format_time ${TEST_TIMES[$i]})"
        [[ ${TEST_RESULTS[$i]} -ne 0 ]] && echo -e "      Exit Code: ${TEST_RESULTS[$i]}"
        echo
    done

    echo -e "📁 ${BOLD}Detailed Reports:${NC}"
    echo -e "   Report Directory: ${BLUE}$REPORT_DIR${NC}"
    echo -e "   Master Report: ${BLUE}$REPORT_DIR/master-test-report.md${NC}"
    echo -e "   Statistics: ${BLUE}$REPORT_DIR/test-statistics.json${NC}"
    echo

    if [[ $TESTS_FAILED -eq 0 ]]; then
        echo -e "${GREEN}${BOLD}🎉 ALL TESTS PASSED!${NC}"
        echo -e "${GREEN}The dual-scope installation system is ${BOLD}PRODUCTION READY${NC}${GREEN}.${NC}"
        echo
        echo -e "✅ ${BOLD}Validated Features:${NC}"
        echo -e "   • User scope installation (~/.claude/)"
        echo -e "   • Global scope installation (/usr/local/share/claude/)"
        echo -e "   • Precedence system (User → Global → Built-in)"
        echo -e "   • Permission handling and sudo detection"
        echo -e "   • Backup and restore functionality"
        echo -e "   • Configuration management (user and global)"
        echo -e "   • File integrity (16 commands, 10 agents, 1 script)"
        echo -e "   • Scope switching and conflict resolution"
    else
        echo -e "${RED}${BOLD}❌ $TESTS_FAILED TEST(S) FAILED${NC}"
        echo -e "${RED}Please review the detailed reports and fix the issues before deployment.${NC}"
        echo
        echo -e "🔍 ${BOLD}Troubleshooting Steps:${NC}"
        echo -e "   1. Check individual test logs in $REPORT_DIR"
        echo -e "   2. Review the master report for detailed analysis"
        echo -e "   3. Verify system dependencies and permissions"
        echo -e "   4. Re-run specific failed tests after fixes"
    fi

    echo
    echo -e "${BLUE}${BOLD}Next Steps:${NC}"
    if [[ $TESTS_FAILED -eq 0 ]]; then
        echo -e "   • The installer is ready for production use"
        echo -e "   • Consider running tests on different platforms"
        echo -e "   • Document any platform-specific installation notes"
    else
        echo -e "   • Fix failing tests before proceeding"
        echo -e "   • Re-run test suite after fixes"
        echo -e "   • Consider adding more specific test cases for edge cases"
    fi
    echo
}

# ============================================================================
# CLEANUP
# ============================================================================

cleanup_test_environment() {
    print_section "CLEANING UP TEST ENVIRONMENT"

    # Note: Individual tests handle their own cleanup
    # This is just for any master-level cleanup

    print_info "Individual tests handle their own cleanup automatically"
    print_success "Test environment cleanup complete"
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    print_suite_header

    # Setup trap for cleanup
    trap cleanup_test_environment EXIT

    print_info "Starting complete test suite for Claude Code Toolkit..."
    print_info "Testing directory: $SCRIPT_DIR"
    print_info "Project directory: $PROJECT_DIR"
    print_info "Report directory: $REPORT_DIR"
    echo

    # Pre-flight checks
    check_test_environment
    check_installer_syntax

    # Run the complete test suite
    run_test_suite

    # Generate comprehensive reports
    generate_detailed_report

    # Print final summary
    print_final_summary

    # Return appropriate exit code
    if [[ $TESTS_FAILED -eq 0 ]]; then
        exit 0
    else
        exit 1
    fi
}

# Run main function
main "$@"