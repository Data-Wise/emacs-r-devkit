#!/usr/bin/env bash
#
# Run Emacs Lisp tests using ERT
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_FILE="$SCRIPT_DIR/test-spacemacs-rstats.el"

echo "🧪 Running Emacs Lisp Tests"
echo "==========================="
echo ""

# Run tests in batch mode
# We need to initialize packages so Spacemacs layers are found
emacs -batch \
  --eval "(let ((elpa-dir (expand-file-name \"~/.emacs.d/elpa/\")))
            (when (file-exists-p elpa-dir)
              (dolist (version-dir (directory-files elpa-dir t \"^[0-9]\"))
                (let ((develop-dir (expand-file-name \"develop\" version-dir)))
                  (when (file-exists-p develop-dir)
                    (let ((default-directory develop-dir))
                      (normal-top-level-add-subdirs-to-load-path)))))))" \
  -l ert \
  -l "$TEST_FILE" \
  -f ert-run-tests-batch-and-exit

echo ""
echo "✅ All Emacs Lisp tests passed!"
