#!/usr/bin/env bash
# test_preflight.sh
# Unit tests for pre-flight check functionality

set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Test helper functions
assert_exit_code() {
    local expected=$1
    local actual=$2
    local test_name=$3
    
    ((TESTS_RUN++))
    
    if [[ $actual -eq $expected ]]; then
        echo -e "${GREEN}✓${NC} $test_name"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}✗${NC} $test_name (expected exit code $expected, got $actual)"
        ((TESTS_FAILED++))
    fi
}

assert_output_contains() {
    local expected=$1
    local output=$2
    local test_name=$3
    
    ((TESTS_RUN++))
    
    if echo "$output" | grep -q "$expected"; then
        echo -e "${GREEN}✓${NC} $test_name"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}✗${NC} $test_name (expected output to contain: $expected)"
        ((TESTS_FAILED++))
    fi
}

# Test 1: Pre-flight mode flag exists
test_preflight_flag() {
    echo "Testing pre-flight mode flag..."
    
    local output
    output=$("$PROJECT_ROOT/scripts/health-check.sh" --help 2>&1 || true)
    
    assert_output_contains "--pre-flight" "$output" "Help text includes --pre-flight flag"
}

# Test 2: Auto-fix flag exists
test_autofix_flag() {
    echo "Testing auto-fix mode flag..."
    
    local output
    output=$("$PROJECT_ROOT/scripts/health-check.sh" --help 2>&1 || true)
    
    assert_output_contains "--auto-fix" "$output" "Help text includes --auto-fix flag"
}

# Test 3: Pre-flight mode runs system checks
test_preflight_system_checks() {
    echo "Testing pre-flight system checks..."
    
    # Run pre-flight mode (may exit early if already installed)
    local output
    local exit_code=0
    output=$("$PROJECT_ROOT/scripts/health-check.sh" --pre-flight 2>&1 || exit_code=$?)
    
    # If already installed, it exits early - that's OK
    if echo "$output" | grep -q "Already Installed"; then
        echo "  Skipped (already installed - exits early)"
        ((TESTS_RUN++))
        ((TESTS_PASSED++))
        return 0
    fi
    
    # Otherwise, should check macOS version
    assert_output_contains "macOS" "$output" "Pre-flight checks macOS version"
    
    # Should check disk space
    assert_output_contains "Disk space" "$output" "Pre-flight checks disk space"
    
    # Should check network
    assert_output_contains "network" "$output" "Pre-flight checks network connectivity"
}

# Test 4: Already installed detection
test_already_installed_detection() {
    echo "Testing already installed detection..."
    
    # If emacs-r-devkit is installed, should detect it
    if [[ -f "$HOME/.spacemacs" ]] && grep -q "emacs-r-devkit" "$HOME/.spacemacs" 2>/dev/null; then
        local output
        local exit_code
        output=$("$PROJECT_ROOT/scripts/health-check.sh" --pre-flight 2>&1 || exit_code=$?)
        
        assert_output_contains "Already Installed" "$output" "Detects already installed"
        assert_exit_code 0 "${exit_code:-0}" "Already installed exits with 0"
    else
        echo "  Skipped (not installed)"
    fi
}

# Test 5: Install.sh has skip-checks flag
test_install_skip_checks() {
    echo "Testing install.sh skip-checks flag..."
    
    local output
    output=$("$PROJECT_ROOT/scripts/install.sh" --help 2>&1 || true)
    
    assert_output_contains "--skip-checks" "$output" "Install.sh has --skip-checks flag"
}

# Test 6: Install.sh mentions pre-flight checks
test_install_preflight_mention() {
    echo "Testing install.sh mentions pre-flight..."
    
    local output
    output=$("$PROJECT_ROOT/scripts/install.sh" --help 2>&1 || true)
    
    assert_output_contains "Pre-flight" "$output" "Install.sh help mentions pre-flight checks"
}

# Test 7: Health check script is executable
test_health_check_executable() {
    echo "Testing health-check.sh is executable..."
    
    ((TESTS_RUN++))
    
    if [[ -x "$PROJECT_ROOT/scripts/health-check.sh" ]]; then
        echo -e "${GREEN}✓${NC} health-check.sh is executable"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}✗${NC} health-check.sh is not executable"
        ((TESTS_FAILED++))
    fi
}

# Test 8: Install script is executable
test_install_executable() {
    echo "Testing install.sh is executable..."
    
    ((TESTS_RUN++))
    
    if [[ -x "$PROJECT_ROOT/scripts/install.sh" ]]; then
        echo -e "${GREEN}✓${NC} install.sh is executable"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}✗${NC} install.sh is not executable"
        ((TESTS_FAILED++))
    fi
}

# Test 9: Pre-flight mode provides clear options when already installed
test_already_installed_options() {
    echo "Testing already installed provides clear options..."
    
    if [[ -f "$HOME/.spacemacs" ]] && grep -q "emacs-r-devkit" "$HOME/.spacemacs" 2>/dev/null; then
        local output
        output=$("$PROJECT_ROOT/scripts/health-check.sh" --pre-flight 2>&1 || true)
        
        # Should show 4 options
        assert_output_contains "Check health status" "$output" "Shows option 1: Check health"
        assert_output_contains "Update to latest" "$output" "Shows option 2: Update"
        assert_output_contains "Repair issues" "$output" "Shows option 3: Repair"
        assert_output_contains "Force reinstall" "$output" "Shows option 4: Reinstall"
    else
        echo "  Skipped (not installed)"
    fi
}

# Test 10: Pre-flight checks for Homebrew
test_preflight_homebrew_check() {
    echo "Testing pre-flight Homebrew check..."
    
    local output
    output=$("$PROJECT_ROOT/scripts/health-check.sh" --pre-flight 2>&1 || true)
    
    # Should check for Homebrew
    assert_output_contains "Homebrew" "$output" "Pre-flight checks for Homebrew"
}

# Run all tests
main() {
    echo "========================================"
    echo "  Pre-Flight Check Tests"
    echo "========================================"
    echo ""
    
    test_preflight_flag
    test_autofix_flag
    test_preflight_system_checks
    test_already_installed_detection
    test_install_skip_checks
    test_install_preflight_mention
    test_health_check_executable
    test_install_executable
    test_already_installed_options
    test_preflight_homebrew_check
    
    echo ""
    echo "========================================"
    echo "  Test Results"
    echo "========================================"
    echo "Tests run: $TESTS_RUN"
    echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
    if [[ $TESTS_FAILED -gt 0 ]]; then
        echo -e "${RED}Failed: $TESTS_FAILED${NC}"
        exit 1
    else
        echo "All tests passed!"
        exit 0
    fi
}

main "$@"
