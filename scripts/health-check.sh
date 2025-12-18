#!/usr/bin/env bash
# health-check.sh
# Comprehensive health check for emacs-r-devkit installation
#
# Exit Codes:
#   0 = HEALTHY - Everything working perfectly
#   1 = NEEDS_UPDATE - Minor issues, can patch
#   2 = NEEDS_REPAIR - Significant issues
#   3 = NEEDS_REINSTALL - Critical issues
#   4 = NOT_INSTALLED - Fresh system
#
# Usage:
#   ./scripts/health-check.sh           # Human-readable output
#   ./scripts/health-check.sh --json    # JSON output
#   ./scripts/health-check.sh --quiet   # Exit code only
#   ./scripts/health-check.sh --verbose # Detailed output

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Symbols
CHECK="✓"
CROSS="✗"
WARN="⚠"
INFO="ℹ"

# Configuration
MIN_EMACS_VERSION="27.1"
MIN_R_VERSION="4.0"
REQUIRED_R_PACKAGES=("devtools" "usethis" "roxygen2" "testthat" "lintr" "styler" "languageserver")
REQUIRED_EMACS_PACKAGES=("ess" "lsp-mode" "company" "flycheck" "magit")

# Global state
ISSUES=()
WARNINGS=()
HEALTH_LEVEL=0  # Start optimistic
OUTPUT_MODE="normal"  # normal, json, quiet, verbose

# Parse arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --json)
                OUTPUT_MODE="json"
                shift
                ;;
            --quiet)
                OUTPUT_MODE="quiet"
                shift
                ;;
            --verbose)
                OUTPUT_MODE="verbose"
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                echo "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
    done
}

show_help() {
    cat << EOF
Health Check for emacs-r-devkit

Usage: $0 [OPTIONS]

Options:
    --json      Output results in JSON format
    --quiet     Only return exit code (no output)
    --verbose   Show detailed information
    -h, --help  Show this help message

Exit Codes:
    0 = HEALTHY - Everything working perfectly
    1 = NEEDS_UPDATE - Minor issues, can patch
    2 = NEEDS_REPAIR - Significant issues
    3 = NEEDS_REINSTALL - Critical issues
    4 = NOT_INSTALLED - Fresh system
EOF
}

# Output functions
log_info() {
    [[ "$OUTPUT_MODE" == "quiet" ]] && return
    echo -e "${BLUE}${INFO}${NC} $1"
}

log_success() {
    [[ "$OUTPUT_MODE" == "quiet" ]] && return
    echo -e "${GREEN}${CHECK}${NC} $1"
}

log_warning() {
    [[ "$OUTPUT_MODE" == "quiet" ]] && return
    echo -e "${YELLOW}${WARN}${NC} $1"
    WARNINGS+=("$1")
}

log_error() {
    [[ "$OUTPUT_MODE" == "quiet" ]] && return
    echo -e "${RED}${CROSS}${NC} $1"
    ISSUES+=("$1")
}

log_verbose() {
    [[ "$OUTPUT_MODE" != "verbose" ]] && return
    echo -e "  ${BLUE}→${NC} $1"
}

# Version comparison
version_ge() {
    # Returns 0 if $1 >= $2
    printf '%s\n%s\n' "$2" "$1" | sort -V -C
}

# Check functions
check_emacs() {
    log_info "Checking Emacs installation..."
    
    if ! command -v emacs &> /dev/null; then
        log_error "Emacs not found in PATH"
        HEALTH_LEVEL=$((HEALTH_LEVEL > 4 ? HEALTH_LEVEL : 4))
        return 1
    fi
    
    local emacs_version
    emacs_version=$(emacs --version | head -n1 | grep -oE '[0-9]+\.[0-9]+' | head -n1)
    log_verbose "Emacs version: $emacs_version"
    
    if ! version_ge "$emacs_version" "$MIN_EMACS_VERSION"; then
        log_error "Emacs version $emacs_version < $MIN_EMACS_VERSION"
        HEALTH_LEVEL=$((HEALTH_LEVEL > 3 ? HEALTH_LEVEL : 3))
        return 1
    fi
    
    log_success "Emacs $emacs_version installed"
    
    # Check for native compilation
    if emacs --batch --eval '(message "%s" (if (fboundp '"'"'native-comp-available-p) "yes" "no"))' 2>&1 | grep -q "yes"; then
        log_verbose "Native compilation: supported"
    else
        log_warning "Native compilation not available (performance may be reduced)"
    fi
    
    return 0
}

check_spacemacs() {
    log_info "Checking Spacemacs installation..."
    
    if [[ ! -d "$HOME/.emacs.d" ]]; then
        log_error "~/.emacs.d not found"
        HEALTH_LEVEL=$((HEALTH_LEVEL > 4 ? HEALTH_LEVEL : 4))
        return 1
    fi
    
    # Check if it's Spacemacs
    if [[ ! -f "$HOME/.emacs.d/init.el" ]] || ! grep -q "spacemacs" "$HOME/.emacs.d/init.el"; then
        log_error "~/.emacs.d exists but is not Spacemacs"
        HEALTH_LEVEL=$((HEALTH_LEVEL > 3 ? HEALTH_LEVEL : 3))
        return 1
    fi
    
    log_success "Spacemacs directory found"
    
    # Check branch
    if [[ -d "$HOME/.emacs.d/.git" ]]; then
        local branch
        branch=$(cd "$HOME/.emacs.d" && git branch --show-current 2>/dev/null || echo "unknown")
        log_verbose "Spacemacs branch: $branch"
        
        if [[ "$branch" != "develop" ]]; then
            log_warning "Spacemacs branch is '$branch', recommend 'develop'"
            HEALTH_LEVEL=$((HEALTH_LEVEL > 2 ? HEALTH_LEVEL : 2))
        fi
    fi
    
    return 0
}

check_configuration() {
    log_info "Checking configuration..."
    
    if [[ ! -f "$HOME/.spacemacs" ]]; then
        log_error "~/.spacemacs not found"
        HEALTH_LEVEL=$((HEALTH_LEVEL > 3 ? HEALTH_LEVEL : 3))
        return 1
    fi
    
    log_success "~/.spacemacs found"
    
    # Check for our customizations (look for specific markers)
    if grep -q "emacs-r-devkit" "$HOME/.spacemacs" 2>/dev/null; then
        log_verbose "Configuration contains emacs-r-devkit customizations"
    else
        log_warning "Configuration may not be from emacs-r-devkit"
        HEALTH_LEVEL=$((HEALTH_LEVEL > 1 ? HEALTH_LEVEL : 1))
    fi
    
    # Check for required layers
    local required_layers=("ess" "auto-completion" "syntax-checking")
    for layer in "${required_layers[@]}"; do
        if grep -q "$layer" "$HOME/.spacemacs" 2>/dev/null; then
            log_verbose "Layer '$layer' enabled"
        else
            log_warning "Layer '$layer' may not be enabled"
            HEALTH_LEVEL=$((HEALTH_LEVEL > 1 ? HEALTH_LEVEL : 1))
        fi
    done
    
    return 0
}

check_helper_scripts() {
    log_info "Checking helper scripts..."
    
    local scripts_ok=true
    local helper_dir="$HOME/.emacs.d/bin"
    
    if [[ ! -d "$helper_dir" ]]; then
        log_warning "Helper scripts directory not found: $helper_dir"
        HEALTH_LEVEL=$((HEALTH_LEVEL > 1 ? HEALTH_LEVEL : 1))
        return 1
    fi
    
    # Check export-gui-path.sh
    if [[ -f "$helper_dir/export-gui-path.sh" ]]; then
        if [[ -x "$helper_dir/export-gui-path.sh" ]]; then
            log_success "export-gui-path.sh found and executable"
        else
            log_warning "export-gui-path.sh not executable"
            HEALTH_LEVEL=$((HEALTH_LEVEL > 1 ? HEALTH_LEVEL : 1))
            scripts_ok=false
        fi
    else
        log_warning "export-gui-path.sh not found"
        HEALTH_LEVEL=$((HEALTH_LEVEL > 1 ? HEALTH_LEVEL : 1))
        scripts_ok=false
    fi
    
    # Check r-styler-check.R
    if [[ -f "$helper_dir/r-styler-check.R" ]]; then
        if [[ -x "$helper_dir/r-styler-check.R" ]]; then
            log_success "r-styler-check.R found and executable"
        else
            log_warning "r-styler-check.R not executable"
            HEALTH_LEVEL=$((HEALTH_LEVEL > 1 ? HEALTH_LEVEL : 1))
            scripts_ok=false
        fi
    else
        log_warning "r-styler-check.R not found"
        HEALTH_LEVEL=$((HEALTH_LEVEL > 1 ? HEALTH_LEVEL : 1))
        scripts_ok=false
    fi
    
    return 0
}

check_r_environment() {
    log_info "Checking R environment..."
    
    if ! command -v R &> /dev/null; then
        log_error "R not found in PATH"
        HEALTH_LEVEL=$((HEALTH_LEVEL > 3 ? HEALTH_LEVEL : 3))
        return 1
    fi
    
    local r_version
    r_version=$(R --version | head -n1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -n1)
    log_verbose "R version: $r_version"
    
    if ! version_ge "$r_version" "$MIN_R_VERSION"; then
        log_error "R version $r_version < $MIN_R_VERSION"
        HEALTH_LEVEL=$((HEALTH_LEVEL > 3 ? HEALTH_LEVEL : 3))
        return 1
    fi
    
    log_success "R $r_version installed"
    
    # Check R packages
    log_verbose "Checking R packages..."
    local missing_packages=()
    
    for pkg in "${REQUIRED_R_PACKAGES[@]}"; do
        if Rscript -e "if (!require('$pkg', quietly=TRUE)) quit(status=1)" &>/dev/null; then
            log_verbose "R package '$pkg' installed"
        else
            log_warning "R package '$pkg' not installed"
            missing_packages+=("$pkg")
            HEALTH_LEVEL=$((HEALTH_LEVEL > 1 ? HEALTH_LEVEL : 1))
        fi
    done
    
    if [[ ${#missing_packages[@]} -gt 0 ]]; then
        log_warning "Missing R packages: ${missing_packages[*]}"
    fi
    
    return 0
}

check_emacs_packages() {
    log_info "Checking Emacs packages..."
    
    local elpa_dir="$HOME/.emacs.d/elpa"
    
    if [[ ! -d "$elpa_dir" ]]; then
        log_warning "Emacs packages directory not found (may not have run Spacemacs yet)"
        HEALTH_LEVEL=$((HEALTH_LEVEL > 2 ? HEALTH_LEVEL : 2))
        return 1
    fi
    
    # Check for required packages
    for pkg in "${REQUIRED_EMACS_PACKAGES[@]}"; do
        if ls "$elpa_dir"/${pkg}-* &>/dev/null; then
            log_verbose "Emacs package '$pkg' installed"
        else
            log_warning "Emacs package '$pkg' not found"
            HEALTH_LEVEL=$((HEALTH_LEVEL > 2 ? HEALTH_LEVEL : 2))
        fi
    done
    
    return 0
}

# Calculate final health status
calculate_health_status() {
    local status_name
    case $HEALTH_LEVEL in
        0) status_name="HEALTHY" ;;
        1) status_name="NEEDS_UPDATE" ;;
        2) status_name="NEEDS_REPAIR" ;;
        3) status_name="NEEDS_REINSTALL" ;;
        4) status_name="NOT_INSTALLED" ;;
        *) status_name="UNKNOWN" ;;
    esac
    
    echo "$status_name"
}

# Generate recommendations
generate_recommendations() {
    local recommendations=()
    
    case $HEALTH_LEVEL in
        0)
            recommendations+=("System is healthy! No action needed.")
            ;;
        1)
            recommendations+=("Run: ./scripts/patch.sh to update configuration")
            recommendations+=("Install missing R packages if needed")
            ;;
        2)
            recommendations+=("Run: ./scripts/repair.sh to fix issues")
            recommendations+=("Or run: ./scripts/install.sh for guided repair")
            ;;
        3)
            recommendations+=("Run: ./scripts/install.sh for full reinstall")
            recommendations+=("Backup will be created automatically")
            ;;
        4)
            recommendations+=("Run: ./scripts/install.sh for fresh installation")
            ;;
    esac
    
    printf '%s\n' "${recommendations[@]}"
}

# Output results
output_results() {
    local status_name
    status_name=$(calculate_health_status)
    
    if [[ "$OUTPUT_MODE" == "json" ]]; then
        # JSON output
        cat << EOF
{
  "status": "$status_name",
  "level": $HEALTH_LEVEL,
  "issues": [$(printf '"%s",' "${ISSUES[@]}" | sed 's/,$//')],
  "warnings": [$(printf '"%s",' "${WARNINGS[@]}" | sed 's/,$//')],
  "recommendations": [$(generate_recommendations | sed 's/^/"/;s/$/",/' | tr '\n' ' ' | sed 's/, $//')  ]
}
EOF
    elif [[ "$OUTPUT_MODE" != "quiet" ]]; then
        # Human-readable output
        echo ""
        echo "════════════════════════════════════════════════════════"
        echo "  Health Check Results"
        echo "════════════════════════════════════════════════════════"
        echo ""
        echo "Status: $status_name (Level $HEALTH_LEVEL)"
        echo ""
        
        if [[ ${#ISSUES[@]} -gt 0 ]]; then
            echo "Issues Found:"
            printf '  %s\n' "${ISSUES[@]}"
            echo ""
        fi
        
        if [[ ${#WARNINGS[@]} -gt 0 ]]; then
            echo "Warnings:"
            printf '  %s\n' "${WARNINGS[@]}"
            echo ""
        fi
        
        echo "Recommendations:"
        generate_recommendations | sed 's/^/  /'
        echo ""
        echo "════════════════════════════════════════════════════════"
    fi
}

# Main execution
main() {
    parse_args "$@"
    
    [[ "$OUTPUT_MODE" != "quiet" ]] && echo "Running health check..."
    [[ "$OUTPUT_MODE" != "quiet" ]] && echo ""
    
    # Run all checks
    check_emacs
    check_spacemacs
    check_configuration
    check_helper_scripts
    check_r_environment
    check_emacs_packages
    
    # Output results
    output_results
    
    # Exit with health level
    exit "$HEALTH_LEVEL"
}

main "$@"
