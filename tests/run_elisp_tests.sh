#!/usr/bin/env bash
#
# Run Emacs Lisp tests using ERT
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_FILE="$SCRIPT_DIR/test-emacs-r-devkit.el"

echo "🧪 Running Emacs Lisp Tests"
echo "==========================="
echo ""

# Run tests in batch mode
emacs -batch \
  -l ert \
  -l "$TEST_FILE" \
  -f ert-run-tests-batch-and-exit

echo ""
echo "✅ All Emacs Lisp tests passed!"
