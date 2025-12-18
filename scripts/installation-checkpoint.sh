#!/usr/bin/env bash
# installation-checkpoint.sh
# Monitor Spacemacs installation progress
# Usage: ./installation-checkpoint.sh

set -uo pipefail

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║  ${BOLD}spacemacs-rstats Installation Checkpoint${NC}             ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

# Track progress
TOTAL_CHECKS=10
PASSED=0
FAILED=0

check_item() {
    local desc="$1"
    local test_cmd="$2"
    
    printf "%-50s " "$desc"
    
    if eval "$test_cmd" &> /dev/null; then
        echo -e "${GREEN}✓${NC}"
        ((PASSED++))
    else
        echo -e "${RED}✗${NC}"
        ((FAILED++))
    fi
    
    # Always return 0 to prevent script exit with set -e
    return 0
}

echo "Checking installation components..."
echo ""

# 1. Homebrew
check_item "Homebrew installed" "command -v brew"

# 2. Emacs
check_item "Emacs installed" "command -v emacs"

# 3. Emacs version
if command -v emacs &> /dev/null; then
    VERSION=$(emacs --version | head -1 | grep -oE '[0-9]+' | head -1)
    if [[ $VERSION -ge 27 ]]; then
        check_item "Emacs version >= 27" "true"
    else
        echo -e "Emacs version >= 27                                ${RED}✗${NC} (Found: $VERSION)"
        ((FAILED++))
    fi
else
    echo -e "Emacs version >= 27                                ${RED}✗${NC} (Emacs not found)"
    ((FAILED++))
fi

# 4. Spacemacs
check_item "Spacemacs installed" "[[ -d ~/.emacs.d ]]"

# 5. Spacemacs develop branch
if [[ -d ~/.emacs.d/.git ]]; then
    check_item "Spacemacs develop branch" "cd ~/.emacs.d && git branch | grep -q develop"
else
    echo -e "Spacemacs develop branch                           ${RED}✗${NC} (Not a git repo)"
    ((FAILED++))
fi

# 6. Configuration
check_item "Configuration installed" "[[ -f ~/.spacemacs ]]"

# 7. R
check_item "R installed" "command -v R"

# 8. R packages
if command -v Rscript &> /dev/null; then
    check_item "R package: devtools" "Rscript -e 'library(devtools)' 2>/dev/null"
    check_item "R package: languageserver" "Rscript -e 'library(languageserver)' 2>/dev/null"
else
    echo -e "R package: devtools                                ${RED}✗${NC} (R not found)"
    echo -e "R package: languageserver                          ${RED}✗${NC} (R not found)"
    ((FAILED+=2))
fi

# 10. Helper scripts
check_item "Helper scripts installed" "[[ -d ~/.emacs.d/bin ]]"

echo ""
echo "════════════════════════════════════════════════════════"
echo ""

# Calculate percentage
PERCENTAGE=$((PASSED * 100 / TOTAL_CHECKS))

echo -e "${BOLD}Progress:${NC} $PASSED/$TOTAL_CHECKS checks passed (${PERCENTAGE}%)"
echo ""

# Progress bar
BAR_LENGTH=50
FILLED=$((PASSED * BAR_LENGTH / TOTAL_CHECKS))
EMPTY=$((BAR_LENGTH - FILLED))

printf "["
printf "${GREEN}%${FILLED}s${NC}" | tr ' ' '='
printf "%${EMPTY}s" | tr ' ' '-'
printf "]\n"

echo ""

# Status and recommendations
if [[ $PASSED -eq $TOTAL_CHECKS ]]; then
    echo -e "${GREEN}✓ Installation complete!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Launch Emacs: ${BLUE}emacs${NC} or ${BLUE}open -a Emacs${NC}"
    echo "  2. First launch takes 10-15 min (package installation)"
    echo "  3. Verify: ${BLUE}./scripts/health-check.sh${NC}"
elif [[ $PASSED -ge 7 ]]; then
    echo -e "${YELLOW}⚠ Installation mostly complete${NC}"
    echo ""
    echo "Missing components:"
    [[ $FAILED -gt 0 ]] && echo "  - Check failed items above"
    echo ""
    echo "To fix:"
    echo "  ${BLUE}./scripts/repair.sh${NC}"
elif [[ $PASSED -ge 4 ]]; then
    echo -e "${YELLOW}⚠ Installation in progress${NC}"
    echo ""
    echo "Continue installation:"
    echo "  ${BLUE}./scripts/install.sh${NC}"
else
    echo -e "${RED}✗ Installation not started or incomplete${NC}"
    echo ""
    echo "Start installation:"
    echo "  ${BLUE}./scripts/install.sh${NC}"
fi

echo ""
echo "════════════════════════════════════════════════════════"
echo ""

# Save checkpoint
CHECKPOINT_FILE=".installation-checkpoint-$(date +%Y%m%d-%H%M%S).log"
{
    echo "spacemacs-rstats Installation Checkpoint"
    echo "Date: $(date)"
    echo "Progress: $PASSED/$TOTAL_CHECKS ($PERCENTAGE%)"
    echo ""
    echo "Passed: $PASSED"
    echo "Failed: $FAILED"
} > "$CHECKPOINT_FILE"

echo "Checkpoint saved: ${BLUE}$CHECKPOINT_FILE${NC}"
echo ""

exit 0
