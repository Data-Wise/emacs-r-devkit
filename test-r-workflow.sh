#!/bin/bash
# R Development Workflow Test Checklist
# Created: 2025-12-10
# Purpose: Interactive checklist to verify R development features in emacs-plus@30

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  R Development Workflow Test Checklist                        ║"
echo "║  emacs-plus@30 with emacs-r-devkit configuration              ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "This is an INTERACTIVE checklist. Follow the prompts and test"
echo "each feature manually in Emacs."
echo ""
echo "Press ENTER to continue..."
read

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Test results
PASSED=0
FAILED=0

test_prompt() {
    local test_num=$1
    local test_name="$2"
    local instructions="$3"
    local keybinding="$4"

    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "${BLUE}Test $test_num: $test_name${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "$instructions"
    if [ -n "$keybinding" ]; then
        echo -e "${YELLOW}Keybinding: $keybinding${NC}"
    fi
    echo ""
    echo -n "Did this test PASS? (y/n): "
    read response

    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}✅ PASS${NC}"
        ((PASSED++))
    else
        echo -e "${RED}❌ FAIL${NC}"
        ((FAILED++))
    fi
}

echo "═══════════════════════════════════════════════════════════════════"
echo " SETUP: Open Emacs and an R file"
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "1. Open Emacs from /Applications/Emacs.app"
echo "2. Wait for it to fully load (first launch: 5-10 min for packages)"
echo "3. Open an R file, for example:"
echo "   ~/R-packages/active/<package>/R/functions.R"
echo "   or create a test file: ~/test.R"
echo ""
echo "Press ENTER when you have an R file open in Emacs..."
read

# Test 1: Emacs Launch
test_prompt "1" \
    "Emacs Launches Successfully" \
    "Verify Emacs opened without errors.
Check the *Messages* buffer (C-h e) for any errors." \
    "C-h e (open *Messages*)"

# Test 2: Init.el Loads
test_prompt "2" \
    "Configuration Loads Without Errors" \
    "Check *Messages* buffer for successful package loading.
Look for messages about ESS, company, flycheck, LSP, etc." \
    "C-h e (check messages)"

# Test 3: R REPL
test_prompt "3" \
    "Start R REPL" \
    "Start an R session.
An R console should appear in a split window." \
    "M-x R (then press ENTER)"

# Test 4: Send Code to REPL
test_prompt "4" \
    "Send Code to REPL" \
    "In your R file, write a line like: x <- 1:10
Place cursor on that line and send it to R.
The R console should show the command executed." \
    "C-RET (or C-c C-n)"

# Test 5: Roxygen Insertion
test_prompt "5" \
    "Insert Roxygen Documentation" \
    "Create a simple function:
  my_function <- function(x, y) {
    x + y
  }

Place cursor inside the function and insert roxygen skeleton.
It should generate:
  #' Title
  #' @param x
  #' @param y
  #' @return
  #' @export" \
    "C-c r r"

# Test 6: LSP Features
test_prompt "6" \
    "LSP Go-to-Definition" \
    "If you have installed R packages, try jumping to a function definition.
For example, type 'mean' and try go-to-definition.
This should jump to the function source (or documentation)." \
    "M-. (or C-c l g g in LSP mode)"

# Test 7: Company Completion
test_prompt "7" \
    "Code Completion (Company)" \
    "Start typing a function name like 'reado' and wait a moment.
A completion popup should appear suggesting 'readOnly', 'readRDS', etc.
Use TAB or ENTER to accept a completion." \
    "TAB or C-n/C-p to navigate"

# Test 8: Flycheck Linting
test_prompt "8" \
    "Flycheck Shows Errors" \
    "Write some invalid R code, like:
  x <- 1:10
  y <-    # incomplete assignment

Flycheck should show a red squiggly line or error indicator.
Check the error list." \
    "C-c ! l (list flycheck errors)"

# Test 9: Usethis Integration
test_prompt "9" \
    "usethis Integration (Optional)" \
    "Try creating an R file using usethis.
This will only work if you're in an R package directory.
If not in a package, you can skip this test (press 'n').
It should run usethis::use_r(\"filename\") in the R console." \
    "C-c r u (then enter filename)"

# Test 10: Magit Git Integration
test_prompt "10" \
    "Magit Git Interface" \
    "Open magit status in your project (must be a git repo).
A buffer should appear showing git status with staged/unstaged changes.
You can navigate with n/p and stage with 's'." \
    "C-x g (or M-x magit-status)"

# Summary
echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo " TEST SUMMARY"
echo "═══════════════════════════════════════════════════════════════════"
echo ""

TOTAL=$((PASSED + FAILED))
PASS_RATE=$((PASSED * 100 / TOTAL))

echo "Tests Passed: $PASSED / $TOTAL ($PASS_RATE%)"
echo "Tests Failed: $FAILED / $TOTAL"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  🎉 EXCELLENT! All R development features working!  🎉   ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "Your emacs-plus@30 installation is fully functional!"
    echo "All R package development features are working correctly."
    echo ""
elif [ $PASSED -ge 7 ]; then
    echo -e "${YELLOW}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║  ⚠️  GOOD! Most features working, minor issues         ║${NC}"
    echo -e "${YELLOW}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "Core R development features are working."
    echo "Some advanced features may need troubleshooting."
    echo ""
else
    echo -e "${RED}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║  ❌ ISSUES DETECTED - Review failed tests               ║${NC}"
    echo -e "${RED}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "Several core features are not working."
    echo "Please check:"
    echo "  1. R packages installed (lintr, styler, languageserver)"
    echo "  2. init.el loaded correctly"
    echo "  3. MELPA packages installed"
    echo ""
fi

echo "Next steps:"
if [ $FAILED -eq 0 ]; then
    echo "  ✅ Start using Emacs for R development!"
    echo "  ✅ Reference: ~/projects/dev-tools/emacs-r-devkit/guides/CHEAT-SHEET.md"
else
    echo "  📖 Check: ~/projects/dev-tools/emacs-r-devkit/guides/TROUBLESHOOTING.md"
    echo "  📧 Review error messages in *Messages* buffer (C-h e)"
fi
echo ""
