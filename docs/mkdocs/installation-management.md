# Installation Management

The emacs-r-devkit includes a comprehensive installation management system that handles all aspects of installation, updates, repairs, and removal.

## System Overview

The installation management system consists of 5 scripts with **automatic pre-flight checks**:

| Script | Purpose | Use When |
|--------|---------|----------|
| `install.sh` | Smart installer with pre-flight | Fresh install or major updates |
| `health-check.sh` | System diagnostics + pre-flight | Checking installation health |
| `patch.sh` | Update existing | Minor updates to config/scripts |
| `repair.sh` | Fix issues | Troubleshooting problems |
| `uninstall.sh` | Clean removal | Removing installation |

> **New in Phase 4.5:** Pre-flight checks run automatically before installation to ensure your system is ready!

## Pre-Flight Checks ✨ NEW

Before installing, the system automatically checks:

- ✅ macOS version (12.0+)
- ✅ Disk space (5GB+ available)
- ✅ Network connectivity
- ✅ Already installed detection
- ✅ Conflicting Emacs versions

**Auto-Fix Capabilities:**

- Installs Homebrew if missing
- Installs Emacs if needed
- Offers to clean up old Emacs versions
- Provides detailed explanations for each action

## Quick Reference

### Check System Health

```bash
./scripts/health-check.sh           # Human-readable output
./scripts/health-check.sh --json    # JSON output
./scripts/health-check.sh --quiet   # Exit code only
```

**Health Levels:**

- 0 = HEALTHY - Everything working
- 1 = NEEDS_UPDATE - Minor issues
- 2 = NEEDS_REPAIR - Significant issues
- 3 = NEEDS_REINSTALL - Critical issues
- 4 = NOT_INSTALLED - Fresh system

### Install or Update

```bash
./scripts/install.sh                # Smart install (recommended)
./scripts/install.sh --force        # Force reinstall
./scripts/install.sh --update-only  # Only update, don't reinstall
./scripts/install.sh --yes          # Skip prompts
```

The smart installer automatically:

1. Runs health check
2. Determines best action
3. Installs/updates as needed
4. Verifies installation

### Update Existing Installation

```bash
./scripts/patch.sh                  # Update everything
./scripts/patch.sh --config-only    # Update .spacemacs only
./scripts/patch.sh --scripts-only   # Update helper scripts only
./scripts/patch.sh --dry-run        # Preview changes
```

Patch script:

- Backs up before updating
- Preserves customizations
- Only updates changed files
- Installs missing R packages

### Repair Issues

```bash
./scripts/repair.sh                 # Interactive menu
./scripts/repair.sh --all           # Attempt all repairs
./scripts/repair.sh --fix-lsp       # Fix LSP issues
./scripts/repair.sh --fix-branch    # Fix Spacemacs branch
./scripts/repair.sh --fix-packages  # Fix Emacs packages
```

Available repairs:

- Spacemacs branch (switch to develop)
- Emacs packages (delete/reinstall)
- LSP issues (clear cache, reinstall languageserver)
- Configuration (restore template)
- Helper scripts (reinstall)

### Uninstall

```bash
./scripts/uninstall.sh              # Interactive menu
./scripts/uninstall.sh --level=1    # Config only
./scripts/uninstall.sh --level=2    # Spacemacs
./scripts/uninstall.sh --level=3    # Full removal
./scripts/uninstall.sh --dry-run    # Preview removal
```

**Uninstall Levels:**

**Level 1: Config Only** (Safe)

- Remove ~/.spacemacs
- Remove helper scripts
- Keep Spacemacs & Emacs

**Level 2: Spacemacs**

- Level 1 +
- Remove ~/.emacs.d
- Keep Emacs

**Level 3: Full Removal**

- Level 2 +
- Uninstall Emacs (Homebrew)
- Complete clean slate

## Common Workflows

### Fresh Installation

```bash
git clone https://github.com/Data-Wise/emacs-r-devkit.git
cd emacs-r-devkit
./scripts/install.sh
```

### Update After Git Pull

```bash
git pull
./scripts/install.sh  # Smart installer detects NEEDS_UPDATE
# Or
./scripts/patch.sh    # Direct update
```

### Troubleshooting

```bash
# 1. Check what's wrong
./scripts/health-check.sh

# 2. Attempt repair
./scripts/repair.sh

# 3. If repair fails, reinstall
./scripts/install.sh --force
```

### Switching Configurations

```bash
# Backup current setup
./scripts/uninstall.sh --level=1

# Install new configuration
./scripts/install.sh
```

## Health Check Details

The health check verifies:

### Emacs

- ✓ Installed and in PATH
- ✓ Version >= 27.1
- ✓ Native compilation support

### Spacemacs

- ✓ ~/.emacs.d exists
- ✓ Is Spacemacs (not vanilla Emacs)
- ✓ Branch is 'develop'
- ✓ Core files intact

### Configuration

- ✓ ~/.spacemacs exists
- ✓ Contains emacs-r-devkit customizations
- ✓ Required layers enabled (ess, lsp, etc.)

### Helper Scripts

- ✓ ~/.emacs.d/bin/export-gui-path.sh
- ✓ ~/.emacs.d/bin/r-styler-check.R
- ✓ Scripts are executable

### R Environment

- ✓ R installed and in PATH
- ✓ Version >= 4.0
- ✓ Required packages:
  - devtools, usethis, roxygen2
  - testthat, lintr, styler
  - languageserver (for LSP)

### Emacs Packages

- ✓ ESS installed
- ✓ LSP mode installed
- ✓ Company mode installed
- ✓ Flycheck installed
- ✓ Magit installed

## Troubleshooting

### "Health check shows NEEDS_REPAIR"

```bash
# Try repair first
./scripts/repair.sh

# If that doesn't work
./scripts/install.sh --force
```

### "LSP not working"

```bash
./scripts/repair.sh --fix-lsp
```

### "Wrong Spacemacs branch"

```bash
./scripts/repair.sh --fix-branch
```

### "Packages won't install"

```bash
./scripts/repair.sh --fix-packages
```

### "Want to start fresh"

```bash
./scripts/uninstall.sh --level=2  # Remove Spacemacs
./scripts/install.sh              # Fresh install
```

## Advanced Usage

### Non-Interactive Installation

```bash
# For automation/CI
./scripts/install.sh --yes
```

### Preview Changes

```bash
# See what would be updated
./scripts/patch.sh --dry-run

# See what would be removed
./scripts/uninstall.sh --dry-run --level=2
```

### JSON Output for Automation

```bash
# Get health status as JSON
./scripts/health-check.sh --json

# Example output:
# {
#   "status": "NEEDS_UPDATE",
#   "level": 1,
#   "issues": ["Helper scripts missing"],
#   "warnings": ["Configuration may not be from emacs-r-devkit"],
#   "recommendations": ["Run: ./scripts/patch.sh to update configuration"]
# }
```

## Safety Features

All scripts include safety features:

- **Automatic Backups**: Created before any destructive action
- **Confirmation Prompts**: For destructive operations
- **Dry-Run Mode**: Preview changes without applying
- **Exit Codes**: For automation and scripting
- **Detailed Logging**: Color-coded output with symbols

## See Also

- [Getting Started Guide](getting-started.md) - Detailed installation walkthrough
- [Troubleshooting](troubleshooting.md) - Common issues and solutions
- [Configuration](configuration.md) - Customization options
