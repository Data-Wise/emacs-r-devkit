#!/usr/bin/env bash
# install.sh
# Smart installer for spacemacs-rstats
# Orchestrates installation based on system health check
#
# Usage:
#   ./scripts/install.sh                # Interactive mode
#   ./scripts/install.sh --force        # Force reinstall
#   ./scripts/install.sh --update-only  # Only update, don't reinstall
#   ./scripts/install.sh --yes          # Auto-confirm prompts

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Default values
FORCE_REINSTALL=false
UPDATE_ONLY=false
YES_TO_ALL=false
SKIP_CHECKS=false

# Progress indicator function
show_progress() {
    local current=$1
    local total=$2
    local desc=$3
    local time_est=$4
    
    echo ""
    echo "╔════════════════════════════════════════════════════════╗"
    printf "║  Step %d/%d: %-40s ║\n" "$current" "$total" "$desc"
    printf "║  ⏱️  Estimated time: %-35s ║\n" "$time_est"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""
}

# Parse arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --force)
                FORCE_REINSTALL=true
                shift
                ;;
            --update-only)
                UPDATE_ONLY=true
                shift
                ;;
            --yes|-y)
                AUTO_YES=true
                shift
                ;;
            --skip-checks)
                SKIP_CHECKS=true
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
Smart Installer for spacemacs-rstats

Usage: $0 [OPTIONS]

Options:
    --force         Force full reinstall regardless of health status
    --update-only   Only update existing installation, don't reinstall
    --skip-checks   Skip pre-flight checks (not recommended)
    --yes, -y       Skip confirmation prompts
    -h, --help      Show this help message

Description:
    This installer intelligently determines the best action based on
    your system's current state:

    - NOT_INSTALLED (4): Fresh installation
    - NEEDS_REINSTALL (3): Backup and reinstall
    - NEEDS_REPAIR (2): Offer repair or reinstall
    - NEEDS_UPDATE (1): Patch existing installation
    - HEALTHY (0): No action needed
    
    Pre-flight checks run automatically to ensure your system is ready.

Examples:
    $0                    # Smart install (recommended)
    $0 --force            # Force complete reinstall
    $0 --update-only      # Only update config
    $0 --yes              # Non-interactive mode
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

# Run health check
run_health_check() {
    log_step "Running health check..."
    
    if [[ ! -x "$SCRIPT_DIR/health-check.sh" ]]; then
        log_error "health-check.sh not found or not executable"
        exit 1
    fi
    
    # Run health check and capture exit code
    local health_level
    "$SCRIPT_DIR/health-check.sh" --quiet || health_level=$?
    
    echo "$health_level"
}

# Install Emacs if needed
install_emacs() {
    log_step "Installing Emacs..."
    
    if command -v emacs &> /dev/null; then
        log_info "Emacs already installed"
        return 0
    fi
    
    if ! command -v brew &> /dev/null; then
        log_error "Homebrew not found. Please install Homebrew first:"
        echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi
    
    log_info "Installing Emacs via Homebrew..."
    
    if confirm "Install emacs-plus@30 with native compilation?"; then
        brew tap d12frosted/emacs-plus
        brew install emacs-plus@30 --with-native-comp
        
        # Link to Applications
        if [[ -d "/opt/homebrew/opt/emacs-plus@30/Emacs.app" ]]; then
            ln -sf "/opt/homebrew/opt/emacs-plus@30/Emacs.app" "/Applications/Emacs.app"
            log_success "Linked Emacs.app to /Applications"
        fi
        
        log_success "Emacs installed"
    else
        log_warning "Skipping Emacs installation. You'll need to install it manually."
        return 1
    fi
}

# Install Spacemacs
install_spacemacs() {
    log_step "Installing Spacemacs..."
    
    if [[ -d "$HOME/.emacs.d" ]]; then
        log_warning "~/.emacs.d already exists"
        
        if confirm "Backup and replace with Spacemacs?"; then
            local backup_dir="$HOME/.emacs.d.backup.$(date +%Y%m%d%H%M%S)"
            mv "$HOME/.emacs.d" "$backup_dir"
            log_success "Backed up to $backup_dir"
        else
            log_error "Cannot install Spacemacs with existing ~/.emacs.d"
            return 1
        fi
    fi
    
    log_info "Cloning Spacemacs (develop branch)..."
    git clone -b develop https://github.com/syl20bnr/spacemacs "$HOME/.emacs.d"
    
    log_success "Spacemacs installed"
}

# Install our configuration
install_config() {
    log_step "Installing spacemacs-rstats configuration..."
    
    # Backup existing .spacemacs if it exists
    if [[ -f "$HOME/.spacemacs" ]]; then
        local backup="$HOME/.spacemacs.backup.$(date +%Y%m%d%H%M%S)"
        cp "$HOME/.spacemacs" "$backup"
        log_info "Backed up existing .spacemacs to $backup"
    fi
    
    # Copy our dotspacemacs.el to ~/.spacemacs
    if [[ -f "$PROJECT_ROOT/config/dotspacemacs.el" ]]; then
        cp "$PROJECT_ROOT/config/dotspacemacs.el" "$HOME/.spacemacs"
        log_success "Installed .spacemacs"
    else
        log_error "config/dotspacemacs.el not found"
        return 1
    fi
    
    # Install helper scripts
    mkdir -p "$HOME/.emacs.d/bin"
    
    if [[ -d "$PROJECT_ROOT/bin" ]]; then
        cp "$PROJECT_ROOT/bin"/* "$HOME/.emacs.d/bin/"
        chmod +x "$HOME/.emacs.d/bin"/*
        log_success "Installed helper scripts"
    else
        log_warning "bin/ directory not found, skipping helper scripts"
    fi
}

# Fresh installation
fresh_install() {
    log_step "Performing fresh installation..."
    
    echo ""
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║  ${BOLD}Fresh Installation${NC}                                    ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""
    
    # Step 1: Check/Install Emacs
    show_progress 1 4 "Installing Emacs..." "5 minutes ☕"
    install_emacs || {
        log_error "Emacs installation failed"
        return 1
    }
    
    # Step 2: Install Spacemacs
    show_progress 2 4 "Installing Spacemacs..." "2 minutes"
    install_spacemacs || {
        log_error "Spacemacs installation failed"
        return 1
    }
    
    # Step 3: Install configuration
    show_progress 3 4 "Configuring for R development..." "1 minute"
    install_config || {
        log_error "Configuration installation failed"
        return 1
    }
    
    # Step 4: Install R packages
    show_progress 4 4 "Installing R packages..." "3 minutes"
    if command -v Rscript &> /dev/null; then
        Rscript -e 'install.packages(c("devtools", "usethis", "roxygen2", "testthat", "lintr", "styler", "languageserver"), repos="https://cloud.r-project.org")' || {
            log_warning "Some R packages failed to install. You can install them later."
        }
        log_success "R packages installed"
    else
        log_warning "R not found. Install R and run: install.packages(c('devtools', 'usethis', 'roxygen2', 'testthat', 'lintr', 'styler', 'languageserver'))"
    fi
    
    log_success "Fresh installation complete!"
    show_next_steps
}

# Reinstall (backup and fresh install)
reinstall() {
    log_step "Performing reinstall..."
    
    echo ""
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║  ${BOLD}Reinstall${NC}                                             ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""
    
    log_warning "This will backup and replace your Spacemacs installation"
    
    if ! confirm "Proceed with reinstall?"; then
        log_info "Cancelled"
        return 1
    fi
    
    # Backup current installation
    if [[ -d "$HOME/.emacs.d" ]]; then
        local backup_dir="$HOME/.emacs.d.backup.$(date +%Y%m%d%H%M%S)"
        mv "$HOME/.emacs.d" "$backup_dir"
        log_success "Backed up ~/.emacs.d to $backup_dir"
    fi
    
    if [[ -f "$HOME/.spacemacs" ]]; then
        local backup="$HOME/.spacemacs.backup.$(date +%Y%m%d%H%M%S)"
        mv "$HOME/.spacemacs" "$backup"
        log_success "Backed up .spacemacs to $backup"
    fi
    
    # Fresh install
    fresh_install
}

# Update existing installation
update_install() {
    log_step "Updating installation..."
    
    echo ""
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║  ${BOLD}Update${NC}                                                ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""
    
    # Check if patch script exists
    if [[ -x "$SCRIPT_DIR/patch.sh" ]]; then
        log_info "Running patch script..."
        "$SCRIPT_DIR/patch.sh" || {
            log_warning "Patch script failed. Falling back to manual update."
        }
    else
        # Manual update
        log_info "Updating configuration..."
        install_config
    fi
    
    log_success "Update complete!"
    show_next_steps
}

# Repair installation
repair_install() {
    log_step "Repairing installation..."
    
    echo ""
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║  ${BOLD}Repair${NC}                                                ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""
    
    echo "Issues found with your installation."
    echo ""
    echo "Options:"
    echo "  1) Attempt repair"
    echo "  2) Full reinstall"
    echo "  3) Cancel"
    echo ""
    
    local choice
    read -p "Choice [1-3]: " choice
    
    case $choice in
        1)
            if [[ -x "$SCRIPT_DIR/repair.sh" ]]; then
                "$SCRIPT_DIR/repair.sh"
            else
                log_warning "repair.sh not found. Updating configuration instead..."
                install_config
            fi
            ;;
        2)
            reinstall
            ;;
        3)
            log_info "Cancelled"
            return 1
            ;;
        *)
            log_error "Invalid choice"
            return 1
            ;;
    esac
}

# Show next steps
show_next_steps() {
    echo ""
    echo "════════════════════════════════════════════════════════"
    echo "  ${BOLD}Next Steps${NC}"
    echo "════════════════════════════════════════════════════════"
    echo ""
    echo "1. Launch Emacs:"
    echo "   ${BLUE}emacs${NC}  or  ${BLUE}open -a Emacs${NC}"
    echo ""
    echo "2. First launch will take 10-15 minutes to install packages"
    echo ""
    echo "3. Verify installation:"
    echo "   ${BLUE}./scripts/health-check.sh${NC}"
    echo ""
    echo "4. Learn Spacemacs:"
    echo "   ${BLUE}https://data-wise.github.io/spacemacs-rstats/spacemacs-learning/${NC}"
    echo ""
    echo "════════════════════════════════════════════════════════"
}

# Main execution
main() {
    parse_args "$@"
    
    # Show header
    echo ""
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║  ${BOLD}spacemacs-rstats Smart Installer${NC}                        ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""
    
    # Run pre-flight checks (unless skipped or force reinstall)
    if [[ "$SKIP_CHECKS" != true && "$FORCE_REINSTALL" != true ]]; then
        log_info "Running pre-flight checks..."
        echo ""
        
        if ! "$SCRIPT_DIR/health-check.sh" --pre-flight; then
            echo ""
            log_error "Pre-flight checks failed"
            echo ""
            echo "Fix the issues above, then try again."
            echo "Or run with ${BLUE}--skip-checks${NC} to bypass (not recommended)"
            echo ""
            exit 1
        fi
    fi
    
    # Force reinstall if requested
    if [[ "$FORCE_REINSTALL" == true ]]; then
        log_info "Force reinstall requested"
        reinstall
        exit 0
    fi
    
    # Run health check
    local health_level
    health_level=$(run_health_check)
    
    log_info "Health status: Level $health_level"
    echo ""
    
    # Decision tree based on health level
    case $health_level in
        0)
            # HEALTHY
            log_success "System is healthy!"
            log_info "No installation needed."
            echo ""
            log_info "Run ${BLUE}./scripts/health-check.sh${NC} for details"
            ;;
        1)
            # NEEDS_UPDATE
            log_info "System needs update"
            
            if [[ "$UPDATE_ONLY" == true ]] || confirm "Update existing installation?"; then
                update_install
            else
                log_info "Cancelled"
            fi
            ;;
        2)
            # NEEDS_REPAIR
            log_warning "System needs repair"
            repair_install
            ;;
        3)
            # NEEDS_REINSTALL
            log_warning "System needs reinstall"
            reinstall
            ;;
        4)
            # NOT_INSTALLED
            log_info "Fresh system detected"
            fresh_install
            ;;
        *)
            log_error "Unknown health level: $health_level"
            exit 1
            ;;
    esac
    
    echo ""
    log_success "Installation process complete!"
    echo ""
}

main "$@"
