# Getting Started

This guide will walk you through installing and setting up emacs-r-devkit on your macOS system.

## Prerequisites

### System Requirements

- **macOS** 12.0 or later
- **Emacs** 27.1 or later (emacs-plus recommended)
- **R** 4.0 or later
- **Homebrew** (recommended for package management)

### Install Emacs

=== "emacs-plus (Recommended)"

    ```bash
    # Install emacs-plus with native compilation
    brew tap d12frosted/emacs-plus
    brew install emacs-plus@30 --with-native-comp

    # Link to Applications
    ln -s /opt/homebrew/opt/emacs-plus@30/Emacs.app /Applications/Emacs.app
    ```

=== "Vanilla Emacs"

    ```bash
    # Install standard Emacs
    brew install emacs

    # Or download from https://emacsformacosx.com/
    ```

### Install R

```bash
# Install R via Homebrew
brew install r

# Verify installation
R --version
```

## Installation

### Step 1: Clone Repository

```bash
cd ~/
git clone https://github.com/Data-Wise/emacs-r-devkit.git
cd emacs-r-devkit
```

### Step 2: Backup Existing Configuration

!!! warning "Important"
    If you have an existing Emacs configuration, back it up first!

```bash
# Backup existing config
mv ~/.emacs.d ~/.emacs.d.backup
mv ~/.emacs ~/.emacs.backup 2>/dev/null || true
```

### Step 3: Run Installer

```bash
# Make installer executable
chmod +x install-init.sh

# Run installer
./install-init.sh
```

The installer will:

- Copy `init.el` to `~/.emacs.d/init.el`
- Copy helper scripts to `~/.emacs.d/bin/`
- Set proper permissions

### Step 4: Install R Packages

```r
# Required packages
install.packages(c(
  "devtools",
  "usethis",
  "roxygen2",
  "testthat",
  "lintr",
  "styler"
))

# Optional but recommended
install.packages(c(
  "languageserver",  # LSP support
  "s7",              # S7 OOP system
  "covr",            # Test coverage
  "pkgdown",         # Package websites
  "remotes"          # Remote package installation
))
```

### Step 5: Verify Dependencies

```bash
# Run dependency checker
./check-dependencies.sh
```

Expected output:

```
================================================
  emacs-r-devkit Dependency Checker
================================================

System Requirements:
-------------------
✓ Emacs: 30.0.92
✓ R: 4.4.2
✓ Rscript: 4.4.2

Required R Packages:
--------------------
✓ R package devtools: 2.4.5
✓ R package usethis: 3.0.0
✓ R package roxygen2: 7.3.2
✓ R package testthat: 3.2.1
✓ R package lintr: 3.1.2
✓ R package styler: 1.10.3

================================================
  Summary
================================================
✓ All dependencies satisfied!
```

## First Launch

### Start Emacs

```bash
# From terminal
emacs

# Or GUI
open -a Emacs
```

!!! info "First Launch Patience"
    The first launch takes **10-15 minutes** as Emacs downloads and compiles packages from MELPA. This is normal!

    You'll see: `Contacting host: melpa.org`

### Monitor Progress

While Emacs loads, you can monitor progress:

1. Press ++ctrl+h++ ++e++ to see the `*Messages*` buffer
2. Look for package installation messages
3. Wait for `Loading ~/.emacs.d/init.el...done`

### Verify Installation

Once loaded, check that all modes are active:

1. Open a test R file: ++ctrl+x++ ++ctrl+f++ `test-features.R`
2. Look at the mode line (bottom of window):
    - Should show: `(ESS[R] Flycheck LSP company)` or similar
3. Try the Which-Key menu: ++ctrl+c++ ++r++
    - Should show a popup with available R commands

## Testing Your Setup

### Interactive Test

```bash
# Open the test file
emacs test-features.R
```

Follow the instructions in `test-features.R` to test:

- [x] Syntax highlighting
- [x] Code completion
- [x] Flycheck integration
- [x] Roxygen insertion
- [x] LSP navigation
- [x] R console integration

### Full Checklist

For a comprehensive test, see:

- `TEST-CHECKLIST.md` - Complete verification checklist
- `test-roxygen.R` - Test roxygen skeleton generation

## First R Session

### Start R Console

1. Press ++option+x++ (that's `M-x`)
2. Type `R` and press ++enter++
3. Wait for R to start

You should see:

```
R version 4.4.2 (2024-10-31) -- "Pile of Leaves"
...
>
```

### Send Code to R

1. Open an R file: ++ctrl+x++ ++ctrl+f++ `test.R`
2. Type some R code: `x <- 1:10`
3. With cursor on that line, press ++ctrl+enter++
4. Code should execute in R console

## macOS PATH Configuration

GUI Emacs on macOS often can't find command-line tools. emacs-r-devkit handles this automatically, but you can verify:

### Check PATH

In Emacs, press ++option+shift+semicolon++ (that's `M-:`) and type:

```elisp
(getenv "PATH")
```

Should include `/usr/local/bin` or `/opt/homebrew/bin`.

### Manual PATH Export

If R is not found:

```
# In Emacs
C-c r P         # Export PATH to GUI

# Or in terminal
~/.emacs.d/bin/export-gui-path.sh
```

Then restart Emacs.

## Next Steps

Now that you're set up:

1. **Learn Keybindings** - See [Keybindings Reference](keybindings.md)
2. **Explore Features** - See [Features](features.md)
3. **Customize** - See [Configuration](configuration.md)
4. **Start Coding** - Create your first R package!

## Common First-Time Issues

!!! failure "Emacs won't start"
    Check `~/.emacs.d/init.el` exists. If not, re-run `./install-init.sh`.

!!! failure "R not found"
    Run `C-c r P` in Emacs to export PATH. See [Troubleshooting](troubleshooting.md).

!!! failure "Package errors"
    Delete `~/.emacs.d/elpa/` and restart Emacs to reinstall packages.

!!! failure "Slow startup"
    First launch is slow (10-15 min). Subsequent launches are fast (<5 seconds).

## Getting Help

- [Troubleshooting Guide](troubleshooting.md) - Solutions to common problems
- [GitHub Issues](https://github.com/Data-Wise/emacs-r-devkit/issues) - Report bugs
- Press ++ctrl+h++ ++k++ then any key to see what it does

## Tutorial Resources

For complete tutorials, see:

- `TUTORIAL.md` in the repository
- `CHEAT-SHEET.md` for quick reference
- Your `emacs-r-devkit` Claude skill

---

**Ready to code!** Open an R file and start developing with the power of Emacs.
