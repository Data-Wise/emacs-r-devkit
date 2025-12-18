#!/usr/bin/env bash
# patch.sh
# Update existing spacemacs-rstats installation with minimal disruption
#
# Usage:
#   ./scripts/patch.sh                  # Update everything
#   ./scripts/patch.sh --config-only    # Update .spacemacs only
#   ./scripts/patch.sh --scripts-only   # Update helper scripts only
#   ./scripts/patch.sh --dry-run        # Show what would be updated

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
DRY_RUN=false
CONFIG_ONLY=false
SCRIPTS_ONLY=false

# Parse arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --config-only)
                CONFIG_ONLY=true
                shift
                ;;
            --scripts-only)
                SCRIPTS_ONLY=true
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
Patch Tool for spacemacs-rstats

Usage: $0 [OPTIONS]

Options:
    --config-only    Update .spacemacs only
    --scripts-only   Update helper scripts only
    --dry-run        Show what would be updated without updating
    -h, --help       Show this help message

Description:
    This tool updates your existing installation with the latest
    configuration and scripts while preserving your customizations
    where possible.

Examples:
    $0                    # Update everything
    $0 --config-only      # Update config only
    $0 --dry-run          # Preview changes
EOF
}

# Output functions
log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

log_dry_run() {
    echo -e "${YELLOW}[DRY RUN]${NC} Would: $1"
}

log_step() {
    echo -e "\n${BOLD}▶ $1${NC}\n"
}

# Check if file needs update
needs_update() {
    local source="$1"
    local target="$2"
    
    if [[ ! -f "$target" ]]; then
        return 0  # Target doesn't exist, needs update
    fi
    
    if ! diff -q "$source" "$target" &>/dev/null; then
        return 0  # Files differ, needs update
    fi
    
    return 1  # Files are the same
}

# Update configuration
update_config() {
    log_step "Updating configuration..."
    
    local source="$PROJECT_ROOT/config/dotspacemacs.el"
    local target="$HOME/.spacemacs"
    
    if [[ ! -f "$source" ]]; then
        log_error "Source config not found: $source"
        return 1
    fi
    
    if needs_update "$source" "$target"; then
        # Backup current config
        if [[ -f "$target" ]]; then
            local backup="$target.pre-patch.$(date +%Y%m%d%H%M%S)"
            
            if [[ "$DRY_RUN" == true ]]; then
                log_dry_run "Backup $target → $backup"
            else
                cp "$target" "$backup"
                log_info "Backed up to $backup"
            fi
        fi
        
        # Smart merge: Try to preserve user customizations
        if [[ -f "$target" ]] && grep -q "dotspacemacs-additional-packages" "$target" 2>/dev/null; then
            log_info "Detected custom packages, attempting smart merge..."
            
            # Extract user's additional packages
            local user_packages
            user_packages=$(grep -A 20 "dotspacemacs-additional-packages" "$target" | grep -v "dotspacemacs-additional-packages" | grep "(" || echo "")
            
            if [[ -n "$user_packages" ]]; then
                log_warning "Found custom packages - manual merge may be needed"
                log_info "Check backup file for your customizations"
            fi
        fi
        
        # Update config
        if [[ "$DRY_RUN" == true ]]; then
            log_dry_run "Update $target from $source"
        else
            cp "$source" "$target"
            log_success "Updated .spacemacs"
        fi
    else
        log_info "Configuration is up to date"
    fi
}

# Update helper scripts
update_scripts() {
    log_step "Updating helper scripts..."
    
    local source_dir="$PROJECT_ROOT/bin"
    local target_dir="$HOME/.emacs.d/bin"
    
    if [[ ! -d "$source_dir" ]]; then
        log_error "Source scripts directory not found: $source_dir"
        return 1
    fi
    
    # Create target directory if needed
    if [[ ! -d "$target_dir" ]]; then
        if [[ "$DRY_RUN" == true ]]; then
            log_dry_run "Create directory $target_dir"
        else
            mkdir -p "$target_dir"
            log_info "Created $target_dir"
        fi
    fi
    
    # Update each script
    local updated=0
    for script in "$source_dir"/*; do
        local script_name=$(basename "$script")
        local target_script="$target_dir/$script_name"
        
        if needs_update "$script" "$target_script"; then
            if [[ "$DRY_RUN" == true ]]; then
                log_dry_run "Update $script_name"
            else
                cp "$script" "$target_script"
                chmod +x "$target_script"
                log_success "Updated $script_name"
                ((updated++))
            fi
        else
            log_info "$script_name is up to date"
        fi
    done
    
    if [[ $updated -gt 0 ]]; then
        log_success "Updated $updated script(s)"
    elif [[ "$DRY_RUN" == false ]]; then
        log_info "All scripts are up to date"
    fi
}

# Update R packages (install missing only)
update_r_packages() {
    log_step "Checking R packages..."
    
    if ! command -v Rscript &> /dev/null; then
        log_warning "R not found, skipping R package check"
        return 0
    fi
    
    local required_packages=("devtools" "usethis" "roxygen2" "testthat" "lintr" "styler" "languageserver")
    local missing_packages=()
    
    for pkg in "${required_packages[@]}"; do
        if ! Rscript -e "if (!require('$pkg', quietly=TRUE)) quit(status=1)" &>/dev/null; then
            missing_packages+=("$pkg")
        fi
    done
    
    if [[ ${#missing_packages[@]} -gt 0 ]]; then
        log_info "Missing R packages: ${missing_packages[*]}"
        
        if [[ "$DRY_RUN" == true ]]; then
            log_dry_run "Install R packages: ${missing_packages[*]}"
        else
            log_info "Installing missing packages..."
            Rscript -e "install.packages(c('${missing_packages[*]}'), repos='https://cloud.r-project.org')" && {
                log_success "Installed missing R packages"
            } || {
                log_warning "Some R packages failed to install"
            }
        fi
    else
        log_success "All R packages are installed"
    fi
}

# Show summary
show_summary() {
    echo ""
    echo "════════════════════════════════════════════════════════"
    echo "  ${BOLD}Patch Summary${NC}"
    echo "════════════════════════════════════════════════════════"
    echo ""
    
    if [[ "$DRY_RUN" == true ]]; then
        echo "Dry run complete. No changes were made."
        echo ""
        echo "To apply changes, run without --dry-run"
    else
        echo "Patch complete!"
        echo ""
        echo "Next steps:"
        echo "  1. Restart Emacs to apply changes"
        echo "  2. Run: ${BLUE}./scripts/health-check.sh${NC}"
    fi
    
    echo ""
    echo "════════════════════════════════════════════════════════"
}

# Main execution
main() {
    parse_args "$@"
    
    # Show header
    echo ""
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║  ${BOLD}spacemacs-rstats Patch Tool${NC}                             ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""
    
    if [[ "$DRY_RUN" == true ]]; then
        log_warning "DRY RUN MODE - No changes will be made"
        echo ""
    fi
    
    # Execute updates based on options
    if [[ "$SCRIPTS_ONLY" == true ]]; then
        update_scripts
    elif [[ "$CONFIG_ONLY" == true ]]; then
        update_config
    else
        # Update everything
        update_config
        update_scripts
        update_r_packages
    fi
    
    # Show summary
    show_summary
    
    echo ""
    log_success "Patch process complete!"
    echo ""
}

main "$@"
