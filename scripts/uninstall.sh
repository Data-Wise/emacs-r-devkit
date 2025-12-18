#!/usr/bin/env bash
# uninstall.sh
# Multi-level uninstaller for spacemacs-rstats
#
# Uninstall Levels:
#   1 = Config Only - Remove our configuration, keep Spacemacs & Emacs
#   2 = Spacemacs - Remove Spacemacs, keep Emacs
#   3 = Full Removal - Remove everything (Spacemacs + Emacs)
#
# Usage:
#   ./scripts/uninstall.sh              # Interactive mode
#   ./scripts/uninstall.sh --level=1    # Config only
#   ./scripts/uninstall.sh --level=2    # Spacemacs
#   ./scripts/uninstall.sh --level=3    # Full removal
#   ./scripts/uninstall.sh --dry-run    # Show what would be removed
#   ./scripts/uninstall.sh --yes        # Skip confirmations

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Configuration
TIMESTAMP=$(date +%Y%m%d%H%M%S)
BACKUP_DIR="$HOME/.spacemacs-rstats-backups"
DRY_RUN=false
AUTO_YES=false
UNINSTALL_LEVEL=0  # 0 = not set, will prompt

# Parse arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --level=*)
                UNINSTALL_LEVEL="${1#*=}"
                shift
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --yes|-y)
                AUTO_YES=true
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
Uninstaller for spacemacs-rstats

Usage: $0 [OPTIONS]

Options:
    --level=N   Uninstall level (1-3)
                  1 = Config only (keep Spacemacs & Emacs)
                  2 = Spacemacs (keep Emacs)
                  3 = Full removal (Spacemacs + Emacs)
    --dry-run   Show what would be removed without removing
    --yes, -y   Skip confirmation prompts
    -h, --help  Show this help message

Uninstall Levels:
    Level 1: Config Only
      - Remove ~/.spacemacs (our version)
      - Remove ~/.emacs.d/bin/* (our helper scripts)
      - Restore previous .spacemacs if backup exists
      - Keep Spacemacs and Emacs intact

    Level 2: Spacemacs
      - Level 1 actions
      - Remove ~/.emacs.d completely
      - Keep Emacs application

    Level 3: Full Removal
      - Level 2 actions
      - Uninstall Emacs (via Homebrew)
      - Remove /Applications/Emacs.app symlink
      - Complete clean slate

Examples:
    $0                    # Interactive mode
    $0 --level=1          # Remove config only
    $0 --level=3 --yes    # Full removal, no prompts
    $0 --dry-run          # Preview what would be removed
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

# Confirmation prompt
confirm() {
    if [[ "$AUTO_YES" == true ]]; then
        return 0
    fi
    
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

# Show interactive menu
show_menu() {
    cat << EOF

╔════════════════════════════════════════════════════════╗
║  ${BOLD}spacemacs-rstats Uninstaller${NC}                            ║
╚════════════════════════════════════════════════════════╝

What would you like to remove?

  ${BOLD}1)${NC} Our configuration only (keep Spacemacs & Emacs)
     - Remove ~/.spacemacs
     - Remove helper scripts
     - Restore previous config if available

  ${BOLD}2)${NC} Spacemacs (keep Emacs)
     - Everything from option 1
     - Remove ~/.emacs.d completely
     - Keep Emacs application

  ${BOLD}3)${NC} Everything (Spacemacs + Emacs)
     - Everything from option 2
     - Uninstall Emacs via Homebrew
     - Complete clean slate

  ${BOLD}4)${NC} Cancel

EOF

    local choice
    read -p "Choice [1-4]: " choice
    
    case $choice in
        1|2|3)
            UNINSTALL_LEVEL=$choice
            ;;
        4)
            echo "Cancelled."
            exit 0
            ;;
        *)
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
}

# Create backup
create_backup() {
    local source="$1"
    local name="$2"
    
    if [[ ! -e "$source" ]]; then
        return 0
    fi
    
    mkdir -p "$BACKUP_DIR"
    local backup_path="$BACKUP_DIR/${name}.backup.$TIMESTAMP"
    
    if [[ "$DRY_RUN" == true ]]; then
        log_dry_run "Backup $source → $backup_path"
    else
        if cp -a "$source" "$backup_path" 2>/dev/null; then
            log_success "Backed up: $backup_path"
        else
            log_warning "Could not backup $source"
        fi
    fi
}

# Level 1: Remove config only
uninstall_config() {
    log_info "Removing spacemacs-rstats configuration..."
    
    # Backup .spacemacs
    if [[ -f "$HOME/.spacemacs" ]]; then
        create_backup "$HOME/.spacemacs" "spacemacs"
        
        if [[ "$DRY_RUN" == true ]]; then
            log_dry_run "Remove ~/.spacemacs"
        else
            rm -f "$HOME/.spacemacs"
            log_success "Removed ~/.spacemacs"
        fi
    else
        log_info "~/.spacemacs not found (already removed)"
    fi
    
    # Remove helper scripts
    if [[ -d "$HOME/.emacs.d/bin" ]]; then
        create_backup "$HOME/.emacs.d/bin" "emacs-bin"
        
        if [[ "$DRY_RUN" == true ]]; then
            log_dry_run "Remove ~/.emacs.d/bin/*"
        else
            rm -rf "$HOME/.emacs.d/bin"
            log_success "Removed helper scripts from ~/.emacs.d/bin"
        fi
    else
        log_info "Helper scripts directory not found"
    fi
    
    # Check for previous backup to restore
    local latest_backup
    latest_backup=$(ls -t "$BACKUP_DIR"/spacemacs.backup.* 2>/dev/null | head -n2 | tail -n1 || echo "")
    
    if [[ -n "$latest_backup" && -f "$latest_backup" ]]; then
        if confirm "Restore previous .spacemacs from backup?"; then
            if [[ "$DRY_RUN" == true ]]; then
                log_dry_run "Restore $latest_backup → ~/.spacemacs"
            else
                cp "$latest_backup" "$HOME/.spacemacs"
                log_success "Restored previous .spacemacs"
            fi
        fi
    fi
    
    log_success "Configuration removal complete"
}

# Level 2: Remove Spacemacs
uninstall_spacemacs() {
    log_info "Removing Spacemacs..."
    
    # First do Level 1
    uninstall_config
    
    # Backup and remove ~/.emacs.d
    if [[ -d "$HOME/.emacs.d" ]]; then
        log_warning "This will remove your entire Spacemacs installation!"
        
        if ! confirm "Are you sure you want to remove ~/.emacs.d?"; then
            log_info "Cancelled Spacemacs removal"
            return 0
        fi
        
        create_backup "$HOME/.emacs.d" "emacs.d"
        
        if [[ "$DRY_RUN" == true ]]; then
            log_dry_run "Remove ~/.emacs.d"
        else
            rm -rf "$HOME/.emacs.d"
            log_success "Removed ~/.emacs.d"
        fi
    else
        log_info "~/.emacs.d not found (already removed)"
    fi
    
    log_success "Spacemacs removal complete"
}

# Level 3: Full removal
uninstall_full() {
    log_info "Performing full removal..."
    
    # First do Level 2
    uninstall_spacemacs
    
    # Uninstall Emacs via Homebrew
    if command -v brew &> /dev/null; then
        # Check if Emacs is installed via Homebrew
        local emacs_formula=""
        
        if brew list emacs-plus@30 &>/dev/null; then
            emacs_formula="emacs-plus@30"
        elif brew list emacs-plus &>/dev/null; then
            emacs_formula="emacs-plus"
        elif brew list emacs &>/dev/null; then
            emacs_formula="emacs"
        fi
        
        if [[ -n "$emacs_formula" ]]; then
            log_warning "This will uninstall Emacs from your system!"
            
            if ! confirm "Are you sure you want to uninstall $emacs_formula?"; then
                log_info "Cancelled Emacs removal"
                return 0
            fi
            
            if [[ "$DRY_RUN" == true ]]; then
                log_dry_run "brew uninstall $emacs_formula"
            else
                brew uninstall "$emacs_formula"
                log_success "Uninstalled $emacs_formula"
            fi
        else
            log_info "Emacs not installed via Homebrew"
        fi
    else
        log_warning "Homebrew not found, cannot uninstall Emacs"
    fi
    
    # Remove /Applications/Emacs.app symlink
    if [[ -L "/Applications/Emacs.app" ]]; then
        if [[ "$DRY_RUN" == true ]]; then
            log_dry_run "Remove /Applications/Emacs.app symlink"
        else
            rm -f "/Applications/Emacs.app"
            log_success "Removed /Applications/Emacs.app symlink"
        fi
    fi
    
    log_success "Full removal complete"
}

# Show summary
show_summary() {
    echo ""
    echo "════════════════════════════════════════════════════════"
    echo "  Uninstall Summary"
    echo "════════════════════════════════════════════════════════"
    echo ""
    
    case $UNINSTALL_LEVEL in
        1)
            echo "Level: Config Only"
            echo "Removed:"
            echo "  - ~/.spacemacs"
            echo "  - ~/.emacs.d/bin/*"
            echo ""
            echo "Kept:"
            echo "  - Spacemacs (~/.emacs.d)"
            echo "  - Emacs application"
            ;;
        2)
            echo "Level: Spacemacs"
            echo "Removed:"
            echo "  - ~/.spacemacs"
            echo "  - ~/.emacs.d (entire Spacemacs)"
            echo ""
            echo "Kept:"
            echo "  - Emacs application"
            ;;
        3)
            echo "Level: Full Removal"
            echo "Removed:"
            echo "  - ~/.spacemacs"
            echo "  - ~/.emacs.d"
            echo "  - Emacs application"
            echo ""
            echo "System is now clean"
            ;;
    esac
    
    if [[ -d "$BACKUP_DIR" ]]; then
        echo ""
        echo "Backups saved to: $BACKUP_DIR"
        echo ""
        echo "To restore from backup:"
        echo "  ls -lt $BACKUP_DIR"
        echo "  cp $BACKUP_DIR/[backup-file] ~/.spacemacs"
    fi
    
    echo ""
    echo "════════════════════════════════════════════════════════"
}

# Main execution
main() {
    parse_args "$@"
    
    # Show header
    if [[ "$DRY_RUN" == true ]]; then
        echo ""
        echo "╔════════════════════════════════════════════════════════╗"
        echo "║  ${YELLOW}DRY RUN MODE${NC} - No changes will be made              ║"
        echo "╚════════════════════════════════════════════════════════╝"
    fi
    
    # Get uninstall level if not set
    if [[ $UNINSTALL_LEVEL -eq 0 ]]; then
        show_menu
    fi
    
    # Validate level
    if [[ $UNINSTALL_LEVEL -lt 1 || $UNINSTALL_LEVEL -gt 3 ]]; then
        log_error "Invalid uninstall level: $UNINSTALL_LEVEL"
        exit 1
    fi
    
    # Show what will be done
    echo ""
    log_info "Uninstall level: $UNINSTALL_LEVEL"
    
    if [[ "$DRY_RUN" == false ]]; then
        echo ""
        log_warning "This action cannot be undone (but backups will be created)"
        
        if ! confirm "Proceed with uninstall?"; then
            echo "Cancelled."
            exit 0
        fi
    fi
    
    echo ""
    
    # Execute uninstall based on level
    case $UNINSTALL_LEVEL in
        1)
            uninstall_config
            ;;
        2)
            uninstall_spacemacs
            ;;
        3)
            uninstall_full
            ;;
    esac
    
    # Show summary
    if [[ "$DRY_RUN" == false ]]; then
        show_summary
    else
        echo ""
        log_info "Dry run complete. No changes were made."
        echo ""
        log_info "To actually uninstall, run without --dry-run"
    fi
    
    echo ""
    log_success "Uninstall complete!"
    echo ""
}

main "$@"
