#!/usr/bin/env bash
# check-dependencies.sh
# Verify all dependencies for spacemacs-rstats are installed
# Usage: ./check-dependencies.sh

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Track status
ALL_OK=true
WARNINGS=0
ERRORS=0

echo "================================================"
echo "  spacemacs-rstats Dependency Checker"
echo "================================================"
echo ""

# ============================================
# Helper Functions
# ============================================

check_command() {
    local cmd="$1"
    local name="$2"
    local required="$3"  # "required" or "optional"
    local install_hint="$4"

    if command -v "$cmd" >/dev/null 2>&1; then
        local version
        version=$(eval "$5" 2>/dev/null || echo "unknown")
        echo -e "${GREEN}✓${NC} $name: ${BLUE}$version${NC}"
        return 0
    else
        if [ "$required" = "required" ]; then
            echo -e "${RED}✗${NC} $name: ${RED}NOT FOUND${NC}"
            echo -e "   ${YELLOW}Install:${NC} $install_hint"
            ERRORS=$((ERRORS + 1))
            ALL_OK=false
            return 1
        else
            echo -e "${YELLOW}⚠${NC} $name: ${YELLOW}NOT FOUND (optional)${NC}"
            echo -e "   ${YELLOW}Install:${NC} $install_hint"
            WARNINGS=$((WARNINGS + 1))
            return 1
        fi
    fi
}

check_r_package() {
    local pkg="$1"
    local required="$2"  # "required" or "optional"

    if Rscript -e "if (!requireNamespace('$pkg', quietly = TRUE)) quit(status = 1)" >/dev/null 2>&1; then
        local version
        version=$(Rscript -e "cat(as.character(packageVersion('$pkg')))" 2>/dev/null || echo "unknown")
        echo -e "${GREEN}✓${NC} R package $pkg: ${BLUE}$version${NC}"
        return 0
    else
        if [ "$required" = "required" ]; then
            echo -e "${RED}✗${NC} R package $pkg: ${RED}NOT INSTALLED${NC}"
            echo -e "   ${YELLOW}Install:${NC} Rscript -e 'install.packages(\"$pkg\")'"
            ERRORS=$((ERRORS + 1))
            ALL_OK=false
            return 1
        else
            echo -e "${YELLOW}⚠${NC} R package $pkg: ${YELLOW}NOT INSTALLED (optional)${NC}"
            echo -e "   ${YELLOW}Install:${NC} Rscript -e 'install.packages(\"$pkg\")'"
            WARNINGS=$((WARNINGS + 1))
            return 1
        fi
    fi
}

# ============================================
# Check System Requirements
# ============================================

echo "System Requirements:"
echo "-------------------"

# Emacs
check_command "emacs" "Emacs" "required" \
    "brew install emacs-plus" \
    "emacs --version | head -1"

# R
check_command "R" "R" "required" \
    "brew install r" \
    "R --version | head -1 | cut -d' ' -f3"

# Rscript
check_command "Rscript" "Rscript" "required" \
    "brew install r" \
    "Rscript --version 2>&1 | head -1"

echo ""

# ============================================
# Check Optional System Tools
# ============================================

echo "Optional Tools:"
echo "---------------"

# Quarto
check_command "quarto" "Quarto" "optional" \
    "brew install quarto" \
    "quarto --version"

# Git
check_command "git" "Git" "optional" \
    "brew install git" \
    "git --version | cut -d' ' -f3"

echo ""

# ============================================
# Check Required R Packages
# ============================================

echo "Required R Packages:"
echo "--------------------"

if ! command -v Rscript >/dev/null 2>&1; then
    echo -e "${RED}✗${NC} Cannot check R packages (Rscript not found)"
    ERRORS=$((ERRORS + 1))
    ALL_OK=false
else
    check_r_package "devtools" "required"
    check_r_package "usethis" "required"
    check_r_package "roxygen2" "required"
    check_r_package "testthat" "required"
    check_r_package "lintr" "required"
    check_r_package "styler" "required"
fi

echo ""

# ============================================
# Check Optional R Packages
# ============================================

echo "Optional R Packages:"
echo "--------------------"

if command -v Rscript >/dev/null 2>&1; then
    check_r_package "languageserver" "optional"
    check_r_package "s7" "optional"
    check_r_package "covr" "optional"
    check_r_package "pkgdown" "optional"
    check_r_package "remotes" "optional"
fi

echo ""

# ============================================
# Check Emacs Configuration
# ============================================

echo "Emacs Configuration:"
echo "--------------------"

if [ -f "$HOME/.emacs.d/init.el" ]; then
    INIT_SIZE=$(wc -l < "$HOME/.emacs.d/init.el")
    if [ "$INIT_SIZE" -gt 100 ]; then
        echo -e "${GREEN}✓${NC} init.el exists (${BLUE}${INIT_SIZE} lines${NC})"
    else
        echo -e "${YELLOW}⚠${NC} init.el exists but seems small (${INIT_SIZE} lines)"
        echo -e "   ${YELLOW}Expected:${NC} ~600 lines for full spacemacs-rstats config"
        WARNINGS=$((WARNINGS + 1))
    fi
else
    echo -e "${RED}✗${NC} init.el: ${RED}NOT FOUND${NC}"
    echo -e "   ${YELLOW}Install:${NC} ./install-init.sh"
    ERRORS=$((ERRORS + 1))
    ALL_OK=false
fi

if [ -f "$HOME/.emacs.d/bin/r-styler-check.R" ]; then
    echo -e "${GREEN}✓${NC} r-styler-check.R exists"
else
    echo -e "${RED}✗${NC} r-styler-check.R: ${RED}NOT FOUND${NC}"
    echo -e "   ${YELLOW}Install:${NC} ./install-init.sh"
    ERRORS=$((ERRORS + 1))
    ALL_OK=false
fi

if [ -f "$HOME/.emacs.d/bin/export-gui-path.sh" ]; then
    echo -e "${GREEN}✓${NC} export-gui-path.sh exists"
else
    echo -e "${YELLOW}⚠${NC} export-gui-path.sh: ${YELLOW}NOT FOUND${NC}"
    echo -e "   ${YELLOW}Install:${NC} ./install-init.sh"
    WARNINGS=$((WARNINGS + 1))
fi

echo ""

# ============================================
# Check macOS Specific
# ============================================

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "macOS Specific:"
    echo "---------------"

    # Check if Homebrew is installed
    if command -v brew >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} Homebrew installed"
    else
        echo -e "${YELLOW}⚠${NC} Homebrew: ${YELLOW}NOT FOUND${NC}"
        echo -e "   ${YELLOW}Install:${NC} /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        WARNINGS=$((WARNINGS + 1))
    fi

    # Check PATH is exported to launchctl
    LAUNCHCTL_PATH=$(launchctl getenv PATH 2>/dev/null || echo "")
    if echo "$LAUNCHCTL_PATH" | grep -q "/usr/local/bin\|/opt/homebrew/bin"; then
        echo -e "${GREEN}✓${NC} PATH exported to launchctl (GUI apps will find R)"
    else
        echo -e "${YELLOW}⚠${NC} PATH not exported to launchctl"
        echo -e "   ${YELLOW}Fix:${NC} Run ~/.emacs.d/bin/export-gui-path.sh"
        echo -e "   ${YELLOW}Or:${NC} In Emacs: C-c r P"
        WARNINGS=$((WARNINGS + 1))
    fi

    echo ""
fi

# ============================================
# Performance Suggestions
# ============================================

echo "Performance Suggestions:"
echo "------------------------"

# Check if using emacs-plus
if command -v emacs >/dev/null 2>&1; then
    EMACS_PATH=$(which emacs)
    if echo "$EMACS_PATH" | grep -q "emacs-plus"; then
        echo -e "${GREEN}✓${NC} Using emacs-plus (optimized for macOS)"
    else
        echo -e "${YELLOW}ℹ${NC} Consider using emacs-plus for better macOS integration"
        echo -e "   ${YELLOW}Install:${NC} brew install emacs-plus"
    fi
fi

# Check if R is from Homebrew
if command -v R >/dev/null 2>&1; then
    R_PATH=$(which R)
    if echo "$R_PATH" | grep -q "Homebrew\|homebrew"; then
        echo -e "${GREEN}✓${NC} R installed via Homebrew (recommended)"
    fi
fi

# Check if radian is installed
if command -v radian >/dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} radian installed (modern R console)"
else
    echo -e "${YELLOW}ℹ${NC} Consider installing radian for better R console experience"
    echo -e "   ${YELLOW}Install:${NC} pip install radian"
fi

echo ""

# ============================================
# Summary
# ============================================

echo "================================================"
echo "  Summary"
echo "================================================"

if [ "$ALL_OK" = true ] && [ "$WARNINGS" -eq 0 ]; then
    echo -e "${GREEN}✓ All dependencies satisfied!${NC}"
    echo ""
    echo "You're ready to use spacemacs-rstats!"
    exit 0
elif [ "$ALL_OK" = true ]; then
    echo -e "${YELLOW}⚠ All required dependencies satisfied${NC}"
    echo -e "${YELLOW}  But $WARNINGS optional dependencies missing${NC}"
    echo ""
    echo "spacemacs-rstats will work, but some features may be unavailable."
    echo "Install optional dependencies for full functionality."
    exit 0
else
    echo -e "${RED}✗ $ERRORS required dependencies missing${NC}"
    if [ "$WARNINGS" -gt 0 ]; then
        echo -e "${YELLOW}  And $WARNINGS optional dependencies missing${NC}"
    fi
    echo ""
    echo "Please install missing required dependencies before using spacemacs-rstats."
    exit 1
fi
