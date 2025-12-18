#!/usr/bin/env bash
# Enhanced health-check.sh with pre-flight and auto-fix capabilities

# Add after the log functions, before check functions:

# Confirmation prompt
confirm() {
    if [[ "$AUTO_FIX" == true ]]; then
        return 0  # Auto-approve if --auto-fix
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

# Auto-fix functions
install_homebrew() {
    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add to PATH for current session
    if [[ -d "/opt/homebrew/bin" ]]; then
        export PATH="/opt/homebrew/bin:$PATH"
    fi
}

cleanup_old_emacs() {
    log_info "Cleaning up old Emacs installations..."
    
    # Keep only emacs-plus@30
    for formula in emacs emacs-plus@29 emacs-plus; do
        if brew list "$formula" &>/dev/null 2>&1; then
            log_info "Uninstalling $formula..."
            brew uninstall "$formula" 2>/dev/null || true
        fi
    done
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
        echo "Options:"
        echo "  • Run ${BLUE}./scripts/health-check.sh${NC} to verify health"
        echo "  • Run ${BLUE}./scripts/patch.sh${NC} to update"
        echo "  • Run ${BLUE}./scripts/install.sh --force${NC} to reinstall"
        echo ""
        exit 0
    fi
}

# Enhanced Emacs check with auto-fix
check_emacs_with_fix() {
    log_info "Checking Emacs installation..."
    
    if ! command -v emacs &> /dev/null; then
        log_error "Emacs not found in PATH"
        FIXABLE_ISSUES+=("install_emacs")
        
        if [[ "$OUTPUT_MODE" == "pre-flight" ]]; then
            if confirm "Install emacs-plus@30 via Homebrew?"; then
                if ! command -v brew &>/dev/null; then
                    if confirm "Homebrew not found. Install Homebrew first?"; then
                        install_homebrew
                    else
                        log_error "Cannot install Emacs without Homebrew"
                        return 1
                    fi
                fi
                
                log_info "Installing emacs-plus@30 (this may take 10-15 minutes)..."
                brew tap d12frosted/emacs-plus
                brew install emacs-plus@30 --with-native-comp
                
                # Link to Applications
                if [[ -d "/opt/homebrew/opt/emacs-plus@30/Emacs.app" ]]; then
                    ln -sf "/opt/homebrew/opt/emacs-plus@30/Emacs.app" "/Applications/Emacs.app"
                fi
                
                log_success "Emacs installed"
            else
                log_error "Emacs installation declined"
                return 1
            fi
        else
            HEALTH_LEVEL=$((HEALTH_LEVEL > 4 ? HEALTH_LEVEL : 4))
            return 1
        fi
    fi
    
    # Check for multiple installations
    local emacs_count
    emacs_count=$(which -a emacs 2>/dev/null | wc -l | tr -d ' ')
    
    if [[ $emacs_count -gt 1 ]]; then
        log_warning "Multiple Emacs installations detected"
        FIXABLE_ISSUES+=("cleanup_emacs")
        
        if [[ "$OUTPUT_MODE" == "pre-flight" ]]; then
            if confirm "Remove conflicting Emacs versions?"; then
                cleanup_old_emacs
                log_success "Cleaned up old Emacs installations"
            fi
        fi
    fi
    
    # Rest of emacs checks...
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
    if emacs --batch --eval '(message "%s" (if (and (fboundp '"'"'native-comp-available-p) (native-comp-available-p)) "yes" "no"))' 2>&1 | grep -q "yes"; then
        log_verbose "Native compilation: available"
    else
        log_warning "Native compilation not available (performance may be reduced)"
    fi
    
    return 0
}

# Pre-flight specific checks
run_preflight_checks() {
    log_step "Running pre-flight checks..."
    echo ""
    
    # Check if already installed
    check_already_installed
    
    # Check system requirements
    log_info "Checking system requirements..."
    
    # macOS version
    local macos_version
    macos_version=$(sw_vers -productVersion | cut -d. -f1)
    if [[ $macos_version -lt 12 ]]; then
        log_error "macOS 12.0+ required (found: $(sw_vers -productVersion))"
        log_info "Please upgrade macOS before installing"
        return 1
    fi
    log_success "macOS $(sw_vers -productVersion)"
    
    # Disk space
    local free_space
    free_space=$(df -g / | tail -1 | awk '{print $4}')
    if [[ $free_space -lt 5 ]]; then
        log_error "Insufficient disk space (${free_space}GB free, need 5GB+)"
        log_info "Please free up disk space before installing"
        return 1
    fi
    log_success "Disk space: ${free_space}GB available"
    
    # Network connectivity
    log_info "Checking network connectivity..."
    if ! curl -s --connect-timeout 5 https://github.com &>/dev/null; then
        log_error "Cannot reach GitHub"
        log_info "Check your internet connection"
        return 1
    fi
    log_success "Network connectivity OK"
    
    # Run enhanced checks with auto-fix
    check_emacs_with_fix || return 1
    
    echo ""
    log_success "Pre-flight checks passed! Ready to install."
    echo ""
    
    return 0
}

# Modify main() to handle pre-flight mode
main() {
    parse_args "$@"
    
    if [[ "$OUTPUT_MODE" == "pre-flight" ]]; then
        run_preflight_checks
        exit $?
    fi
    
    # ... rest of existing main() code ...
}
