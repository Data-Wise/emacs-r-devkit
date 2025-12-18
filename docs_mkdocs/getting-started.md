# Getting Started

This guide will walk you through installing and setting up emacs-r-devkit with Spacemacs on your macOS system.

## What is Spacemacs?

**Spacemacs** is a community-driven Emacs distribution that combines the best of Emacs and Vim. It provides:

- **Modal editing** (Vim-style) for efficient navigation and editing
- **Discoverable keybindings** via which-key (press `SPC` and wait)
- **Organized layers** instead of scattered package configurations
- **Mnemonic keybindings** (`SPC p` for project, `SPC f` for files, etc.)

For R development, Spacemacs offers a superior experience with its ESS layer and LSP integration.

## Prerequisites

### System Requirements

- **macOS** 12.0 or later
- **Emacs** 27.1 or later (emacs-plus@30 recommended)
- **R** 4.0 or later
- **Git** 2.0+
- **Homebrew** (recommended for package management)

### Install Emacs

```bash
# Install emacs-plus with native compilation (recommended)
brew tap d12frosted/emacs-plus
brew install emacs-plus@30 --with-native-comp

# Link to Applications
ln -s /opt/homebrew/opt/emacs-plus@30/Emacs.app /Applications/Emacs.app
```text

!!! tip "Why emacs-plus?"
    Native compilation significantly improves performance, especially for LSP and large R files.

### Install R

```bash
# Install R via Homebrew
brew install r

# Verify installation
R --version
```bash

## Installation

### Step 1: Install Spacemacs

```bash
# Clone Spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# Use develop branch (recommended for latest features)
cd ~/.emacs.d
git checkout develop
```bash

### Step 2: Clone emacs-r-devkit

```bash
cd ~/
git clone https://github.com/Data-Wise/emacs-r-devkit.git
cd emacs-r-devkit
```bash

### Step 3: Backup Existing Configuration

!!! warning "Important"
    If you have an existing Spacemacs or Emacs configuration, back it up first!

```bash
# Backup existing Spacemacs config
mv ~/.spacemacs ~/.spacemacs.backup 2>/dev/null || true
mv ~/.spacemacs.d ~/.spacemacs.d.backup 2>/dev/null || true

# Backup vanilla Emacs config (if migrating)
mv ~/.emacs ~/.emacs.backup 2>/dev/null || true
```bash

### Step 4: Install Configuration

```bash
# Copy Spacemacs configuration
cp dotspacemacs.el ~/.spacemacs

# Copy helper scripts
mkdir -p ~/.emacs.d/bin
cp bin/* ~/.emacs.d/bin/
chmod +x ~/.emacs.d/bin/*
```text

The configuration includes:

- **ESS layer** with LSP backend for R
- **Auto-completion** with company-mode
- **Syntax checking** with flycheck
- **Git integration** with magit
- **Project management** with projectile
- **Org-mode** for literate programming

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
```bash

### Step 5: Verify Dependencies

```bash
# Run dependency checker
./check-dependencies.sh
```text

Expected output:

```text
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
```bash

## First Launch

### Start Spacemacs

```bash
# From terminal
emacs

# Or GUI
open -a Emacs
```text

!!! info "First Launch Patience"
    The first launch takes **10-15 minutes** as Spacemacs installs layers and downloads packages from MELPA. This is normal!

    You'll see the Spacemacs logo and installation progress.

### Initial Setup

On first launch, Spacemacs will ask:

1. **What is your preferred editing style?**
   - Choose `vim` for modal editing (recommended)
   - This gives you Normal, Insert, and Visual modes

2. **What distribution of spacemacs would you like to start with?**
   - Choose `spacemacs` (full distribution)

3. **What type of completion framework do you want?**
   - Choose `helm` (default, recommended)

### Monitor Progress

While Spacemacs loads, you can monitor progress:

1. Watch the installation messages in the `*Messages*` buffer
2. Look for layer installation progress
3. Wait for the Spacemacs home buffer to appear

### Verify Installation

Once loaded, check that all layers are active:

1. Open a test R file: `SPC f f` then navigate to `tests/test-features.R`
2. Look at the mode line (bottom of window):
    - Should show: `(ESS[R] Flycheck LSP company)` or similar
3. Try the Which-Key menu: `SPC m`
    - Should show a popup with R major mode commands
4. Check your editing mode:
    - Bottom left should show `<N>` for Normal mode
    - Press `i` to enter Insert mode (`<I>`)
    - Press `ESC` to return to Normal mode

!!! tip "Modal Editing Basics"
    - **Normal mode** (`<N>`): Navigate and manipulate text (default)
    - **Insert mode** (`<I>`): Type text (press `i` to enter)
    - **Visual mode** (`<V>`): Select text (press `v` to enter)
    - Press `ESC` or `fd` quickly to return to Normal mode

## Testing Your Setup

### Interactive Test

```bash
# Open the test file
emacs test-features.R
```text

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

In Spacemacs:

1. Press `SPC SPC` (that's `SPC` twice)
2. Type `R` and press `ENTER`
3. Wait for R to start

Or use the traditional method:

1. Press `M-x` (Option+x on macOS)
2. Type `R` and press `ENTER`

You should see:

```text
R version 4.4.2 (2024-10-31) -- "Pile of Leaves"
...
>
```bash

### Send Code to R

**Method 1: Using Spacemacs Major Mode Leader**

1. Open an R file: `SPC f f` then navigate to `test.R`
2. Type some R code: `x <- 1:10`
3. With cursor on that line, press `, s l` (comma, then s, then l)
4. Code should execute in R console

**Method 2: Using Traditional Keybinding**

1. With cursor on a line of R code
2. Press `C-RET` (Control+Return)
3. Code executes in R console

!!! tip "Spacemacs R Keybindings"
    In R files, press `, ?` or `SPC m ?` to see all available R commands via which-key.

## macOS PATH Configuration

GUI Emacs on macOS often can't find command-line tools. Spacemacs handles this automatically via `exec-path-from-shell`, but you can verify:

### Check PATH

In Spacemacs:

1. Press `SPC SPC` then type `eval-expression` (or `M-:`)
2. Type: `(getenv "PATH")`
3. Press `ENTER`

Should include `/usr/local/bin` or `/opt/homebrew/bin`.

### Manual PATH Export

If R is not found, you can manually export the PATH:

```bash
# In terminal
~/.emacs.d/bin/export-gui-path.sh
```text

Then restart Spacemacs.

## Next Steps

Now that you're set up:

1. **Learn Spacemacs** - See [Spacemacs Learning](spacemacs-learning.md)
2. **Learn Keybindings** - See [Keybindings Reference](keybindings.md)
3. **Explore Features** - See [Features](features.md)
4. **Customize** - See [Configuration](configuration.md)
5. **Migrating from vanilla Emacs?** - See [Migration Guide](migration-guide.md)

## Common First-Time Issues

!!! failure "Spacemacs won't start"
    Check `~/.spacemacs` exists. If not, re-run the installation steps.

!!! failure "R not found"
    Ensure R is installed and in your PATH. Run `~/.emacs.d/bin/export-gui-path.sh` and restart. See [Troubleshooting](troubleshooting.md).

!!! failure "Layer installation errors"
    Delete `~/.emacs.d/elpa/` and restart Spacemacs to reinstall layers.

!!! failure "Slow startup"
    First launch is slow (10-15 min) while layers install. Subsequent launches are fast (<5 seconds).

!!! failure "Can't exit Insert mode"
    Press `ESC` or type `fd` quickly to return to Normal mode.

## Getting Help

- [Spacemacs Learning](spacemacs-learning.md) - Complete learning curriculum
- [Troubleshooting Guide](troubleshooting.md) - Solutions to common problems
- [GitHub Issues](https://github.com/Data-Wise/emacs-r-devkit/issues) - Report bugs
- Press `SPC h d` in Spacemacs to access help documentation
- Press `SPC ?` to see all available keybindings

---

**Ready to code!** Open an R file and start developing with the power of Spacemacs.
