# Migration Guide: Vanilla Emacs to Spacemacs

This guide helps you migrate from the vanilla Emacs configuration (`init.el`) to Spacemacs for R development.

## Why Migrate to Spacemacs?

**Spacemacs offers significant advantages for R development:**

- **Discoverability**: Press `SPC` and wait - which-key shows all available commands
- **Modal editing**: Vim-style navigation is faster and more ergonomic
- **Organized layers**: No more scattered `use-package` declarations
- **Mnemonic keybindings**: `SPC p` for project, `SPC f` for files, `SPC m` for major mode
- **Better defaults**: Sensible configurations out of the box
- **Active community**: Large ecosystem of layers and support

## Pre-Migration Checklist

Before migrating, prepare your environment:

- [ ] **Backup your current configuration**

  ```bash
  cp ~/.emacs.d/init.el ~/.emacs.d/init.el.backup
  cp -r ~/.emacs.d ~/.emacs.d.backup
  ```

- [ ] **Document your customizations**
  - Note any custom functions you've added
  - List packages you've installed beyond the defaults
  - Save any custom keybindings

- [ ] **Verify R packages are installed**

  ```r
  # Check required packages
  required <- c("devtools", "usethis", "roxygen2", "testthat", "lintr", "styler", "languageserver")
  installed <- required %in% rownames(installed.packages())
  if (!all(installed)) {
    install.packages(required[!installed])
  }
  ```

- [ ] **Close all Emacs instances**

## Installation Steps

### Step 1: Install Spacemacs

```bash
# Backup existing Emacs directory
mv ~/.emacs.d ~/.emacs.d.vanilla-backup

# Clone Spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# Use develop branch (recommended)
cd ~/.emacs.d
git checkout develop
```bash

### Step 2: Install emacs-r-devkit Configuration

```bash
# Navigate to emacs-r-devkit
cd ~/emacs-r-devkit

# Backup existing Spacemacs config (if any)
mv ~/.spacemacs ~/.spacemacs.backup 2>/dev/null || true

# Copy Spacemacs configuration
cp dotspacemacs.el ~/.spacemacs

# Copy helper scripts
mkdir -p ~/.emacs.d/bin
cp bin/* ~/.emacs.d/bin/
chmod +x ~/.emacs.d/bin/*
```bash

### Step 3: First Launch

```bash
# Start Spacemacs
emacs

# Or GUI
open -a Emacs
```text

**During first launch:**

1. Choose `vim` editing style (recommended)
2. Choose `spacemacs` distribution
3. Choose `helm` completion framework
4. Wait 10-15 minutes for layer installation

## Configuration Migration

### Mapping init.el to dotspacemacs.el

| Vanilla Emacs (`init.el`) | Spacemacs (`~/.spacemacs`) |
|---------------------------|----------------------------|
| `(use-package ess ...)` | Add `ess` to `dotspacemacs-configuration-layers` |
| `(use-package lsp-mode ...)` | Add `lsp` to layers |
| `(use-package company ...)` | Add `auto-completion` to layers |
| `(use-package flycheck ...)` | Add `syntax-checking` to layers |
| `(use-package magit ...)` | Add `git` to layers |
| `(setq custom-var value)` | Add to `dotspacemacs/user-config` |
| `(global-set-key ...)` | Use `SPC SPC` or define in `dotspacemacs/user-config` |

### Custom Functions

If you have custom functions in `init.el`, add them to `dotspacemacs/user-config`:

```elisp
(defun dotspacemacs/user-config ()
  "Configuration for user code."
  
  ;; Your custom functions here
  (defun my-custom-function ()
    "My custom function."
    (interactive)
    (message "Hello from custom function!"))
  
  ;; Custom keybindings
  (spacemacs/set-leader-keys "o c" 'my-custom-function)
)
```bash

## Keybinding Translation

### Common Emacs → Spacemacs Mappings

| Task | Vanilla Emacs | Spacemacs |
|------|---------------|-----------|
| Find file | `C-x C-f` | `SPC f f` |
| Save file | `C-x C-s` | `SPC f s` or `:w` (in Normal mode) |
| Switch buffer | `C-x b` | `SPC b b` |
| Execute command | `M-x` | `SPC SPC` or `M-x` |
| Cancel | `C-g` | `ESC` or `fd` |
| Undo | `C-/` | `u` (in Normal mode) |
| Search | `C-s` | `/` (in Normal mode) |
| Save and quit | `C-x C-c` | `SPC q q` or `:wq` |

### R-Specific Keybindings

| Task | Vanilla Emacs | Spacemacs |
|------|---------------|-----------|
| Start R | `M-x R` | `SPC SPC R` or `, s i` |
| Send line to R | `C-RET` | `, s l` or `C-RET` |
| Send region to R | `C-RET` | `, s r` or `C-RET` |
| Insert roxygen | `C-c r r` | `, h i` |
| Load package | `C-c C-w l` | `, s b` |
| Run tests | `M-x ess-r-devtools-test-package` | `, t p` |

!!! tip "Discover More Keybindings"
    In any R file, press `, ?` or `SPC m ?` to see all available R commands via which-key.

## Post-Migration Verification

### Test R Workflow

1. **Open an R file**

   ```
   SPC f f → navigate to test.R
   ```

2. **Check mode line**
   - Should show: `(ESS[R] Flycheck LSP company)`

3. **Test code completion**
   - Type `lib` and wait - should see completions
   - Or press `C-n` / `C-p` to navigate completions

4. **Test LSP**
   - Hover over a function: `SPC m g g` (go to definition)
   - Return: `SPC m g b` (go back)

5. **Test Flycheck**
   - Introduce a syntax error
   - Should see red underline
   - Press `SPC e l` to list errors

6. **Test R console**
   - Start R: `SPC SPC R`
   - Send code: `, s l` (send line)

### Verify Layers

Press `SPC h L` to see installed layers. Should include:

- `auto-completion`
- `ess`
- `git`
- `lsp`
- `syntax-checking`

## Troubleshooting Common Issues

### "I'm stuck in Insert mode!"

**Solution:** Press `ESC` or type `fd` quickly to return to Normal mode.

### "My keybindings don't work!"

**Solution:** Make sure you're in the correct mode:

- File navigation: Normal mode
- Typing code: Insert mode (press `i`)
- Major mode commands: Normal mode, then `, ...`

### "LSP isn't working!"

**Solution:**

1. Ensure `languageserver` R package is installed
2. Restart LSP: `SPC m l r r`
3. Check `*lsp-log*` buffer: `SPC b b` then search for `lsp-log`

### "I want my old keybindings back!"

**Solution:** You can use Emacs editing style instead of Vim:

1. Edit `~/.spacemacs`
2. Change `dotspacemacs-editing-style 'vim` to `'emacs`
3. Restart Spacemacs

Or add custom keybindings in `dotspacemacs/user-config`:

```elisp
(global-set-key (kbd "C-x C-f") 'helm-find-files)
```bash

### "Spacemacs is slow!"

**Solution:**

- First launch is slow (layer installation)
- Subsequent launches should be <5 seconds
- If still slow, check `*Messages*` buffer for errors
- Consider using `dotspacemacs-enable-lazy-installation 'unused`

## Learning Resources

### Essential Reading

1. **[Spacemacs Learning](spacemacs-learning.md)** - Complete curriculum
2. **[Spacemacs Documentation](https://www.spacemacs.org/doc/DOCUMENTATION.html)** - Official docs
3. **[Evil Mode Guide](https://github.com/emacs-evil/evil)** - Vim emulation

### Practice Exercises

**Day 1-3: Modal Editing Basics**

- Practice switching modes (`i`, `ESC`, `v`)
- Learn basic navigation (`h`, `j`, `k`, `l`)
- Practice editing (`d`, `y`, `p`, `c`)

**Day 4-7: Spacemacs Keybindings**

- File operations (`SPC f ...`)
- Buffer management (`SPC b ...`)
- Project navigation (`SPC p ...`)

**Week 2: R Development**

- R console workflow (`, s ...`)
- LSP navigation (`, g ...`)
- Testing (`, t ...`)

### Quick Reference

Keep these handy:

- **[Keybindings Reference](keybindings.md)** - Complete keybinding list
- **[Spacemacs Cheat Sheet](https://github.com/Data-Wise/emacs-r-devkit/blob/main/guides/spacemacs-learning/03-CHEAT-SHEETS.md)** - Quick reference

## Rollback Plan

If you need to return to vanilla Emacs:

```bash
# Stop Spacemacs
# Then restore backup
rm -rf ~/.emacs.d
mv ~/.emacs.d.vanilla-backup ~/.emacs.d

# Restore init.el
cp ~/.emacs.d/init.el.backup ~/.emacs.d/init.el

# Restart Emacs
emacs
```bash

## Next Steps

Now that you've migrated:

1. **Complete the learning curriculum** - [Spacemacs Learning](spacemacs-learning.md)
2. **Customize your config** - [Configuration](configuration.md)
3. **Explore advanced features** - [Features](features.md)
4. **Join the community** - [Spacemacs Gitter](https://gitter.im/syl20bnr/spacemacs)

---

**Welcome to Spacemacs!** You're now part of a vibrant community of Emacs and Vim enthusiasts.
