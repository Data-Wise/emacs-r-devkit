#!/bin/bash
# Post-Installation Verification Script for emacs-plus@30
# Created: 2025-12-10
# Purpose: Verify emacs-plus@30 installation and test R development workflow

set -e

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  emacs-plus@30 Post-Installation Verification                 ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track test results
PASSED=0
FAILED=0

# Helper function for test results
test_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✅ PASS${NC}: $2"
        ((PASSED++))
    else
        echo -e "${RED}❌ FAIL${NC}: $2"
        ((FAILED++))
    fi
}

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 1: Check Installation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Test 1: Check if emacs-plus@30 is installed
echo -n "Checking if emacs-plus@30 is installed... "
if brew list emacs-plus@30 &>/dev/null; then
    test_result 0 "emacs-plus@30 is installed via Homebrew"
else
    test_result 1 "emacs-plus@30 NOT found in Homebrew"
    exit 1
fi

# Test 2: Check installation path
echo -n "Checking installation path... "
CELLAR_PATH="/opt/homebrew/Cellar/emacs-plus@30/30.2"
if [ -d "$CELLAR_PATH" ]; then
    test_result 0 "Found at $CELLAR_PATH"
else
    test_result 1 "Installation path not found"
    exit 1
fi

# Test 3: Check Emacs.app exists
echo -n "Checking Emacs.app bundle... "
if [ -d "$CELLAR_PATH/Emacs.app" ]; then
    test_result 0 "Emacs.app bundle exists"
else
    test_result 1 "Emacs.app bundle not found"
    exit 1
fi

# Test 4: Check Emacs binary
echo -n "Checking Emacs binary... "
EMACS_BIN="$CELLAR_PATH/Emacs.app/Contents/MacOS/Emacs"
if [ -x "$EMACS_BIN" ]; then
    test_result 0 "Emacs binary is executable"
else
    test_result 1 "Emacs binary not found or not executable"
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 2: Verify Version"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Test 5: Check Emacs version
echo "Checking Emacs version:"
VERSION=$("$EMACS_BIN" --version | head -1)
echo "  $VERSION"
if echo "$VERSION" | grep -q "GNU Emacs 30"; then
    test_result 0 "Correct version (Emacs 30.x)"
else
    test_result 1 "Unexpected version"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 3: Check /Applications Link"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Test 6: Check if linked to /Applications
if [ -e "/Applications/Emacs.app" ]; then
    test_result 0 "Emacs.app exists in /Applications"

    # Check if it's the right version
    APP_VERSION=$(/Applications/Emacs.app/Contents/MacOS/Emacs --version | head -1)
    if echo "$APP_VERSION" | grep -q "GNU Emacs 30"; then
        test_result 0 "Application link points to emacs-plus@30"
    else
        test_result 1 "Application link points to wrong version"
    fi
else
    echo -e "${YELLOW}⚠️  WARN${NC}: Emacs.app not linked to /Applications yet"
    echo "   Run this to create the link:"
    echo "   osascript -e 'tell application \"Finder\" to make alias file to posix file \"$CELLAR_PATH/Emacs.app\" at posix file \"/Applications\" with properties {name:\"Emacs.app\"}'"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 4: Check Configuration Files"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Test 7: Check init.el
INIT_EL="$HOME/projects/dev-tools/spacemacs-rstats/init.el"
if [ -f "$INIT_EL" ]; then
    test_result 0 "init.el found at $INIT_EL"

    # Check if it's the right one (should mention R development)
    if grep -q "R package development" "$INIT_EL"; then
        test_result 0 "init.el contains R development configuration"
    else
        test_result 1 "init.el may not be the correct file"
    fi
else
    test_result 1 "init.el not found"
fi

# Test 8: Check .emacs.d directory
if [ -d "$HOME/.emacs.d" ]; then
    test_result 0 ".emacs.d directory exists"
else
    echo -e "${YELLOW}⚠️  WARN${NC}: .emacs.d directory doesn't exist yet (will be created on first launch)"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 5: Quick Functionality Test"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Test 9: Test Emacs can start in batch mode
echo "Testing Emacs batch mode..."
if "$EMACS_BIN" --batch --eval '(message "Hello from Emacs!")' 2>&1 | grep -q "Hello from Emacs"; then
    test_result 0 "Emacs batch mode works"
else
    test_result 1 "Emacs batch mode failed"
fi

# Test 10: Test with minimal init
echo "Testing with minimal configuration..."
TEMP_INIT=$(mktemp)
cat > "$TEMP_INIT" << 'EOF'
;;; Minimal test init
(setq inhibit-startup-message t)
(message "Init loaded successfully")
EOF

if "$EMACS_BIN" --batch -l "$TEMP_INIT" 2>&1 | grep -q "Init loaded successfully"; then
    test_result 0 "Emacs can load configuration files"
else
    test_result 1 "Configuration loading failed"
fi
rm "$TEMP_INIT"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

TOTAL=$((PASSED + FAILED))
echo "Tests Passed: $PASSED / $TOTAL"
echo "Tests Failed: $FAILED / $TOTAL"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✅ All tests passed! emacs-plus@30 is ready to use.${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Launch Emacs: open /Applications/Emacs.app"
    echo "  2. Wait for packages to install (first launch takes 5-10 minutes)"
    echo "  3. Test R development workflow"
    echo ""
    exit 0
else
    echo -e "${RED}❌ Some tests failed. Please review the output above.${NC}"
    echo ""
    exit 1
fi
