#!/usr/bin/env bash
# health-check.sh
# Comprehensive health check for spacemacs-rstats installation
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
OUTPUT_MODE="normal"  # normal, json, quiet, verbose, pre-flight
AUTO_FIX=false
FIXABLE_ISSUES=()

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
            --pre-flight)
                OUTPUT_MODE="pre-flight"
                shift
                ;;
            --auto-fix)
                AUTO_FIX=true
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
Health Check for spacemacs-rstats

Usage: $0 [OPTIONS]

Options:
    --json        Output results in JSON format
    --quiet       Only return exit code (no output)
    --verbose     Show detailed information
    --pre-flight  Run pre-installation checks (stops on critical issues)
    --auto-fix    Automatically fix safe issues (prompts for others)
    -h, --help    Show this help message

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

log_step() {
    [[ "$OUTPUT_MODE" == "quiet" ]] && return
    echo -e "\n${BOLD}▶ $1${NC}\n"
}

# Confirmation prompt with explanation
confirm() {
    if [[ "$AUTO_FIX" == true ]]; then
        return 0  # Auto-approve if --auto-fix
    fi
    
    local prompt="$1"
    local explanation="${2:-}"
    local response
    
    if [[ -n "$explanation" ]]; then
        echo ""
        echo -e "${BLUE}${INFO}${NC} ${explanation}"
    fi
    
    read -p "$(echo -e "${YELLOW}?${NC} $prompt [y/N]: ")" response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Check if already installed
check_already_installed() {
    if [[ "$OUTPUT_MODE" != "pre-flight" ]]; then
        return 0  # Skip this check in normal mode
    fi
    
    local is_installed=true
    
    # Check all components
    if [[ ! -d "$HOME/.emacs.d" ]]; then
        is_installed=false
    elif [[ ! -f "$HOME/.spacemacs" ]]; then
        is_installed=false
    elif ! grep -q "spacemacs-rstats" "$HOME/.spacemacs" 2>/dev/null; then
        is_installed=false
    fi
    
    if [[ "$is_installed" == true ]]; then
        echo ""
        echo "╔════════════════════════════════════════════════════════╗"
        echo "║  ${GREEN}✓${NC} spacemacs-rstats Already Installed                  ║"
        echo "╚════════════════════════════════════════════════════════╝"
        echo ""
        log_success "spacemacs-rstats is already installed on this system"
        echo ""
        echo "What would you like to do?"
        echo ""
        echo "  ${BOLD}1)${NC} Check health status"
        echo "     → Run: ${BLUE}./scripts/health-check.sh${NC}"
        echo ""
        echo "  ${BOLD}2)${NC} Update to latest version"
        echo "     → Run: ${BLUE}./scripts/patch.sh${NC}"
        echo "     → Updates config and scripts"
        echo "     → Preserves your customizations"
        echo ""
        echo "  ${BOLD}3)${NC} Repair issues"
        echo "     → Run: ${BLUE}./scripts/repair.sh${NC}"
        echo "     → Fixes common problems"
        echo ""
        echo "  ${BOLD}4)${NC} Force reinstall"
        echo "     → Run: ${BLUE}./scripts/install.sh --force${NC}"
        echo "     → Complete fresh installation"
        echo "     → Backup created automatically"
        echo ""
        exit 0
    fi
}

# Install Homebrew with explanation
install_homebrew() {
    echo ""
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║  Installing Homebrew                                   ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""
    echo "Homebrew is macOS's package manager."
    echo "It's required to install Emacs and other dependencies."
    echo ""
    echo "This will:"
    echo "  • Download and install Homebrew"
    echo "  • Install Xcode Command Line Tools (if needed)"
    echo "  • Add Homebrew to your PATH"
    echo ""
    echo "Time: ~5-10 minutes"
    echo ""
    
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add to PATH for current session
    if [[ -d "/opt/homebrew/bin" ]]; then
        export PATH="/opt/homebrew/bin:$PATH"
    fi
    
    log_success "Homebrew installed"
}

# Install Emacs with explanation
install_emacs() {
    echo ""
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║  Installing Emacs                                      ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""
    echo "Installing: ${BOLD}emacs-plus@30${NC} with native compilation"
    echo ""
    echo "This will:"
    echo "  • Build Emacs 30 from source"
    echo "  • Enable native compilation (2-3x faster)"
    echo "  • Add macOS-specific enhancements"
    echo "  • Create Emacs.app in /Applications"
    echo ""
    echo "Time: ~10-15 minutes"
    echo "Disk space: ~500MB"
    echo ""
    
    if confirm "Install emacs-plus@30?"; then
        log_info "Installing emacs-plus@30..."
        brew tap d12frosted/emacs-plus
        brew install emacs-plus@30 --with-native-comp
        
        # Link to Applications
        if [[ -d "/opt/homebrew/opt/emacs-plus@30/Emacs.app" ]]; then
            ln -sf "/opt/homebrew/opt/emacs-plus@30/Emacs.app" "/Applications/Emacs.app"
        elif [[ -d "/usr/local/opt/emacs-plus@30/Emacs.app" ]]; then
            ln -sf "/usr/local/opt/emacs-plus@30/Emacs.app" "/Applications/Emacs.app"
        fi
        
        log_success "Emacs installed"
        return 0
    else
        log_error "Emacs installation declined"
        return 1
    fi
}

# Cleanup old Emacs with explanation
cleanup_old_emacs() {
    echo ""
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║  Cleaning Up Old Emacs Installations                   ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""
    echo "Multiple Emacs installations detected."
    echo ""
    echo "This will:"
    echo "  • Keep: emacs-plus@30 (recommended)"
    echo "  • Remove: other Emacs versions"
    echo "  • Prevent conflicts"
    echo ""
    
    # List what will be removed
    local to_remove=()
    for formula in emacs emacs-plus@29 emacs-plus; do
        if brew list "$formula" &>/dev/null 2>&1; then
            to_remove+=("$formula")
        fi
    done
    
    if [[ ${#to_remove[@]} -gt 0 ]]; then
        echo "Will remove:"
        for formula in "${to_remove[@]}"; do
            echo "  • $formula"
        done
        echo ""
        
        if confirm "Remove old Emacs versions?"; then
            for formula in "${to_remove[@]}"; do
                log_info "Uninstalling $formula..."
                brew uninstall "$formula" 2>/dev/null || true
            done
            log_success "Cleaned up old Emacs installations"
            return 0
        fi
    fi
    
    return 1
}

# Pre-flight check function
run_preflight_checks() {
    echo ""
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║  ${BOLD}Pre-Flight Checks${NC}                                     ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""
    
    # Check if already installed
    check_already_installed
    
    log_step "Checking System Requirements"
    
    # macOS version
    local macos_version
    macos_version=$(sw_vers -productVersion | cut -d. -f1)
    if [[ $macos_version -lt 12 ]]; then
        log_error "macOS 12.0+ required (found: $(sw_vers -productVersion))"
        echo ""
        echo "${RED}✗${NC} Cannot install on macOS $(sw_vers -productVersion)"
        echo "  Please upgrade to macOS 12.0 or later"
        echo ""
        return 1
    fi
    log_success "macOS $(sw_vers -productVersion)"
    
    # Disk space
    local free_space
    free_space=$(df -g / | tail -1 | awk '{print $4}')
    if [[ $free_space -lt 5 ]]; then
        log_error "Insufficient disk space (${free_space}GB free, need 5GB+)"
        echo ""
        echo "${RED}✗${NC} Only ${free_space}GB available"
        echo "  Please free up disk space before installing"
        echo ""
        return 1
    fi
    log_success "Disk space: ${free_space}GB available"
    
    # Network connectivity
    log_info "Checking network connectivity..."
    if ! curl -s --connect-timeout 5 https://github.com &>/dev/null; then
        log_error "Cannot reach GitHub"
        echo ""
        echo "${RED}✗${NC} No internet connection"
        echo "  Check your network and try again"
        echo ""
        return 1
    fi
    log_success "Network connectivity OK"
    
    log_step "Checking Dependencies"
    
    # Check/Install Homebrew
    if ! command -v brew &>/dev/null; then
        log_warning "Homebrew not found"
        if install_homebrew; then
            log_success "Homebrew installed"
        else
            log_error "Homebrew installation failed"
            return 1
        fi
    else
        log_success "Homebrew installed"
    fi
    
    # Check/Install Emacs
    if ! command -v emacs &>/dev/null; then
        log_warning "Emacs not found"
        if install_emacs; then
            log_success "Emacs installed"
        else
            log_error "Emacs installation failed"
            return 1
        fi
    else
        # Check for multiple installations
        local emacs_count
        emacs_count=$(which -a emacs 2>/dev/null | wc -l | tr -d ' ')
        
        if [[ $emacs_count -gt 1 ]]; then
            log_warning "Multiple Emacs installations detected"
            cleanup_old_emacs || true
        fi
        
        log_success "Emacs installed"
    fi
    
    # Check R
    if ! command -v R &>/dev/null; then
        log_warning "R not found"
        echo ""
        echo "${YELLOW}⚠${NC} R is not installed"
        echo ""
        echo "Install R via Homebrew:"
        echo "  ${BLUE}brew install r${NC}"
        echo ""
        if ! confirm "Continue without R?"; then
            return 1
        fi
    else
        log_success "R installed"
    fi
    
    echo ""
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║  ${GREEN}✓${NC} Pre-Flight Checks Passed                           ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""
    echo "${GREEN}✓${NC} System is ready for installation!"
    echo ""
    
    return 0
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
    if grep -q "spacemacs-rstats" "$HOME/.spacemacs" 2>/dev/null; then
        log_verbose "Configuration contains spacemacs-rstats customizations"
    else
        log_warning "Configuration may not be from spacemacs-rstats"
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
    
    # Handle pre-flight mode
    if [[ "$OUTPUT_MODE" == "pre-flight" ]]; then
        run_preflight_checks
        exit $?
    fi
    
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
