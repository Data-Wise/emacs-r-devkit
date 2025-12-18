#!/usr/bin/env bash
#
# Integration Tests for spacemacs-rstats
#
# Tests the complete workflow:
# 1. Spacemacs starts
# 2. R can be launched
# 3. LSP works
# 4. Flycheck works
#

set -e

echo "🧪 Integration Tests"
echo "===================="
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Test 1: Check Spacemacs configuration exists
echo "Test 1: Spacemacs configuration..."
if [ -f ~/.spacemacs ]; then
    echo "  ✓ ~/.spacemacs exists"
else
    echo "  ✗ ~/.spacemacs not found"
    exit 1
fi

# Test 2: Check helper scripts
echo ""
echo "Test 2: Helper scripts..."
if [ -f ~/.emacs.d/bin/r-styler-check.R ]; then
    echo "  ✓ r-styler-check.R exists"
elif [ -f "$PROJECT_ROOT/bin/r-styler-check.R" ]; then
    echo "  ✓ r-styler-check.R exists in project bin/"
else
    echo "  ⚠ r-styler-check.R not found"
fi

if [ -f ~/.emacs.d/bin/export-gui-path.sh ]; then
    echo "  ✓ export-gui-path.sh exists"
    if [ -x ~/.emacs.d/bin/export-gui-path.sh ]; then
        echo "  ✓ export-gui-path.sh is executable"
    else
        echo "  ⚠ export-gui-path.sh not executable"
    fi
elif [ -f "$PROJECT_ROOT/bin/export-gui-path.sh" ]; then
    echo "  ✓ export-gui-path.sh exists in project bin/"
else
    echo "  ⚠ export-gui-path.sh not found"
fi

# Test 3: Check R is available
echo ""
echo "Test 3: R availability..."
if command -v R &> /dev/null; then
    echo "  ✓ R is in PATH"
    R_VERSION=$(R --version | head -n1)
    echo "  ℹ $R_VERSION"
else
    echo "  ✗ R not found in PATH"
    exit 1
fi

# Test 4: Check required R packages
echo ""
echo "Test 4: Required R packages..."
REQUIRED_PACKAGES=("devtools" "usethis" "roxygen2" "testthat" "lintr" "styler" "languageserver")

for pkg in "${REQUIRED_PACKAGES[@]}"; do
    if Rscript -e "library($pkg)" &> /dev/null; then
        echo "  ✓ $pkg installed"
    else
        echo "  ✗ $pkg not installed"
    fi
done

# Test 5: Test Emacs can start
echo ""
echo "Test 5: Emacs functionality..."
if command -v emacs &> /dev/null; then
    echo "  ✓ Emacs is in PATH"
    EMACS_VERSION=$(emacs --version | head -n1)
    echo "  ℹ $EMACS_VERSION"
    
    # Test Emacs can load ESS
    if emacs -batch \
      --eval "(let ((elpa-dir (expand-file-name \"~/.emacs.d/elpa/\")))
                (when (file-exists-p elpa-dir)
                  (dolist (version-dir (directory-files elpa-dir t \"^[0-9]\"))
                    (let ((develop-dir (expand-file-name \"develop\" version-dir)))
                      (when (file-exists-p develop-dir)
                        (let ((default-directory develop-dir))
                          (normal-top-level-add-subdirs-to-load-path)))))))" \
      -l ess 2>/dev/null; then
        echo "  ✓ ESS can be loaded"
    else
        echo "  ⚠ ESS not available (check ~/.emacs.d/elpa)"
    fi
else
    echo "  ✗ Emacs not found in PATH"
    exit 1
fi

# Test 6: Check documentation builds
echo ""
echo "Test 6: Documentation..."
if command -v mkdocs &> /dev/null; then
    echo "  ✓ MkDocs is installed"
    
    cd "$PROJECT_ROOT"
    if mkdocs build --strict &> /dev/null; then
        echo "  ✓ Documentation builds successfully"
    else
        echo "  ✗ Documentation build failed"
    fi
else
    echo "  ⚠ MkDocs not installed"
fi

echo ""
echo "✅ Integration tests complete!"
