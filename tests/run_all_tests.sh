#!/usr/bin/env bash
#
# Master Test Runner for spacemacs-rstats
#
# Runs all test suites in order:
# 1. Documentation tests
# 2. Emacs Lisp tests
# 3. R package tests
# 4. Integration tests
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "╔════════════════════════════════════════════════════════╗"
echo "║  spacemacs-rstats Test Suite                            ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

FAILED=0

# Test Suite A: Documentation
echo "═══ Test Suite A: Documentation ═══"
if "$SCRIPT_DIR/run_doc_tests.sh"; then
    echo "✅ Documentation tests PASSED"
else
    echo "❌ Documentation tests FAILED"
    FAILED=$((FAILED + 1))
fi
echo ""

# Test Suite B: Emacs Lisp
echo "═══ Test Suite B: Emacs Lisp ═══"
if "$SCRIPT_DIR/run_elisp_tests.sh"; then
    echo "✅ Emacs Lisp tests PASSED"
else
    echo "❌ Emacs Lisp tests FAILED"
    FAILED=$((FAILED + 1))
fi
echo ""

# Test Suite C: R Packages
echo "═══ Test Suite C: R Packages ═══"
if Rscript -e "testthat::test_file('$SCRIPT_DIR/test_r_packages.R')"; then
    echo "✅ R package tests PASSED"
else
    echo "❌ R package tests FAILED"
    FAILED=$((FAILED + 1))
fi
echo ""

# Test Suite D: Integration
echo "═══ Test Suite D: Integration ═══"
if "$SCRIPT_DIR/test_integration.sh"; then
    echo "✅ Integration tests PASSED"
else
    echo "❌ Integration tests FAILED"
    FAILED=$((FAILED + 1))
fi
echo ""

# Summary
echo "╔════════════════════════════════════════════════════════╗"
if [ $FAILED -eq 0 ]; then
    echo "║  ✅ ALL TESTS PASSED                                   ║"
    echo "╚════════════════════════════════════════════════════════╝"
    exit 0
else
    echo "║  ❌ $FAILED TEST SUITE(S) FAILED                          ║"
    echo "╚════════════════════════════════════════════════════════╝"
    exit 1
fi
