#!/usr/bin/env bash
# repair.sh
# Repair specific issues with spacemacs-rstats installation
#
# Usage:
#   ./scripts/repair.sh                    # Interactive mode
#   ./scripts/repair.sh --fix-branch       # Fix Spacemacs branch only
#   ./scripts/repair.sh --fix-packages     # Fix Emacs packages
#   ./scripts/repair.sh --fix-lsp          # Fix LSP issues
#   ./scripts/repair.sh --all              # Attempt all repairs

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
FIX_ALL=false
FIX_BRANCH=false
FIX_PACKAGES=false
FIX_LSP=false
FIX_CONFIG=false
FIX_SCRIPTS=false

# Parse arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --all)
                FIX_ALL=true
                shift
                ;;
            --fix-branch)
                FIX_BRANCH=true
                shift
                ;;
            --fix-packages)
                FIX_PACKAGES=true
                shift
                ;;
            --fix-lsp)
                FIX_LSP=true
                shift
                ;;
            --fix-config)
                FIX_CONFIG=true
                shift
                ;;
            --fix-scripts)
                FIX_SCRIPTS=true
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
Repair Tool for spacemacs-rstats

Usage: $0 [OPTIONS]

Options:
    --all            Attempt all repairs
    --fix-branch     Fix Spacemacs branch (switch to develop)
    --fix-packages   Fix corrupted Emacs packages
    --fix-lsp        Fix LSP issues
    --fix-config     Fix configuration issues
    --fix-scripts    Fix helper scripts
    -h, --help       Show this help message

Description:
    This tool attempts to repair specific issues without requiring
    a full reinstall.

Examples:
    $0                    # Interactive mode
    $0 --all              # Attempt all repairs
    $0 --fix-lsp          # Fix LSP issues only
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

log_step() {
    echo -e "\n${BOLD}▶ $1${NC}\n"
}

# Confirmation prompt
confirm() {
    local prompt="$1"
    local response
    
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

# Fix Spacemacs branch
fix_branch() {
    log_step "Fixing Spacemacs branch..."
    
    if [[ ! -d "$HOME/.emacs.d/.git" ]]; then
        log_error "~/.emacs.d is not a git repository"
        return 1
    fi
    
    cd "$HOME/.emacs.d"
    
    local current_branch
    current_branch=$(git branch --show-current 2>/dev/null || echo "unknown")
    
    log_info "Current branch: $current_branch"
    
    if [[ "$current_branch" == "develop" ]]; then
        log_success "Already on develop branch"
        
        # Update to latest
        if confirm "Update to latest develop?"; then
            git pull origin develop
            log_success "Updated to latest develop"
        fi
    else
        log_warning "Not on develop branch"
        
        if confirm "Switch to develop branch?"; then
            git checkout develop
            git pull origin develop
            log_success "Switched to develop branch"
        fi
    fi
    
    cd - > /dev/null
}

# Fix corrupted packages
fix_packages() {
    log_step "Fixing Emacs packages..."
    
    if [[ ! -d "$HOME/.emacs.d/elpa" ]]; then
        log_info "No packages directory found (will be created on next Emacs launch)"
        return 0
    fi
    
    log_warning "This will delete all installed packages"
    log_info "They will be reinstalled when you next launch Emacs"
    
    if confirm "Delete and reinstall packages?"; then
        rm -rf "$HOME/.emacs.d/elpa"
        log_success "Deleted package directory"
        log_info "Packages will reinstall on next Emacs launch"
    fi
}

# Fix LSP issues
fix_lsp() {
    log_step "Fixing LSP issues..."
    
    # Reinstall languageserver
    if command -v Rscript &> /dev/null; then
        log_info "Reinstalling R languageserver package..."
        Rscript -e 'install.packages("languageserver", repos="https://cloud.r-project.org")' && {
            log_success "Reinstalled languageserver"
        } || {
            log_error "Failed to install languageserver"
        }
    else
        log_warning "R not found, cannot install languageserver"
    fi
    
    # Clear LSP cache
    if [[ -d "$HOME/.emacs.d/.cache/lsp" ]]; then
        log_info "Clearing LSP cache..."
        rm -rf "$HOME/.emacs.d/.cache/lsp"
        log_success "Cleared LSP cache"
    fi
    
    # Clear LSP session files
    if [[ -d "$HOME/.emacs.d/.lsp-session-v1" ]]; then
        rm -rf "$HOME/.emacs.d/.lsp-session-v1"
        log_success "Cleared LSP session files"
    fi
}

# Fix configuration
fix_config() {
    log_step "Fixing configuration..."
    
    if [[ ! -f "$PROJECT_ROOT/config/dotspacemacs.el" ]]; then
        log_error "config/dotspacemacs.el not found"
        return 1
    fi
    
    # Backup current config
    if [[ -f "$HOME/.spacemacs" ]]; then
        local backup="$HOME/.spacemacs.broken.$(date +%Y%m%d%H%M%S)"
        cp "$HOME/.spacemacs" "$backup"
        log_info "Backed up current config to $backup"
    fi
    
    # Install our template
    cp "$PROJECT_ROOT/config/dotspacemacs.el" "$HOME/.spacemacs"
    log_success "Installed fresh configuration"
    
    log_warning "Your custom settings may have been lost"
    log_info "Check backup if you need to restore customizations"
}

# Fix helper scripts
fix_scripts() {
    log_step "Fixing helper scripts..."
    
    if [[ ! -d "$PROJECT_ROOT/bin" ]]; then
        log_error "bin/ directory not found"
        return 1
    fi
    
    # Reinstall helper scripts
    mkdir -p "$HOME/.emacs.d/bin"
    cp "$PROJECT_ROOT/bin"/* "$HOME/.emacs.d/bin/"
    chmod +x "$HOME/.emacs.d/bin"/*
    
    log_success "Reinstalled helper scripts"
}

# Show interactive menu
show_menu() {
    cat << EOF

╔════════════════════════════════════════════════════════╗
║  ${BOLD}spacemacs-rstats Repair Tool${NC}                            ║
╚════════════════════════════════════════════════════════╝

What would you like to repair?

  ${BOLD}1)${NC} Spacemacs branch (switch to develop)
  ${BOLD}2)${NC} Emacs packages (delete and reinstall)
  ${BOLD}3)${NC} LSP issues (reinstall languageserver, clear cache)
  ${BOLD}4)${NC} Configuration (restore template)
  ${BOLD}5)${NC} Helper scripts (reinstall)
  ${BOLD}6)${NC} All of the above
  ${BOLD}7)${NC} Cancel

EOF

    local choice
    read -p "Choice [1-7]: " choice
    
    case $choice in
        1) FIX_BRANCH=true ;;
        2) FIX_PACKAGES=true ;;
        3) FIX_LSP=true ;;
        4) FIX_CONFIG=true ;;
        5) FIX_SCRIPTS=true ;;
        6) FIX_ALL=true ;;
        7)
            echo "Cancelled."
            exit 0
            ;;
        *)
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
}

# Main execution
main() {
    parse_args "$@"
    
    # Show header
    echo ""
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║  ${BOLD}Repair Tool${NC}                                           ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""
    
    # If no specific repair requested, show menu
    if [[ "$FIX_ALL" == false && "$FIX_BRANCH" == false && "$FIX_PACKAGES" == false && \
          "$FIX_LSP" == false && "$FIX_CONFIG" == false && "$FIX_SCRIPTS" == false ]]; then
        show_menu
    fi
    
    # Execute repairs
    if [[ "$FIX_ALL" == true || "$FIX_BRANCH" == true ]]; then
        fix_branch
    fi
    
    if [[ "$FIX_ALL" == true || "$FIX_PACKAGES" == true ]]; then
        fix_packages
    fi
    
    if [[ "$FIX_ALL" == true || "$FIX_LSP" == true ]]; then
        fix_lsp
    fi
    
    if [[ "$FIX_ALL" == true || "$FIX_CONFIG" == true ]]; then
        fix_config
    fi
    
    if [[ "$FIX_ALL" == true || "$FIX_SCRIPTS" == true ]]; then
        fix_scripts
    fi
    
    # Show summary
    echo ""
    echo "════════════════════════════════════════════════════════"
    echo "  ${BOLD}Repair Complete${NC}"
    echo "════════════════════════════════════════════════════════"
    echo ""
    echo "Next steps:"
    echo "  1. Restart Emacs"
    echo "  2. Run: ${BLUE}./scripts/health-check.sh${NC}"
    echo ""
    log_success "Repair complete!"
    echo ""
}

main "$@"
