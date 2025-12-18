# Troubleshooting Guide - spacemacs-rstats

Quick solutions to common issues with spacemacs-rstats on macOS.

## Quick Diagnosis

**Run the dependency checker first:**
```bash
./check-dependencies.sh
```

This will identify most common problems automatically.

---

## Installation Issues

### Problem: `install-init.sh` fails

**Symptoms:**
- Script errors out
- Files not copied

**Solutions:**
```bash
# Check if .emacs.d directory exists
ls -la ~/.emacs.d/

# If it doesn't exist, create it
mkdir -p ~/.emacs.d/bin

# Run installer again
./install-init.sh

# Verify installation
ls -la ~/.emacs.d/init.el
ls -la ~/.emacs.d/bin/
```

### Problem: Existing Emacs configuration conflicts

**Symptoms:**
- Emacs won't start after installation
- Error messages about packages

**Solutions:**
```bash
# Backup and remove existing config
mv ~/.emacs.d ~/.emacs.d.backup
mv ~/.emacs ~/.emacs.backup 2>/dev/null

# Reinstall
./install-init.sh

# Restart Emacs
open -a Emacs
```

---

## Emacs Startup Issues

### Problem: Emacs takes forever to start

**Symptoms:**
- First launch takes > 15 minutes
- Stuck on "Contacting host: melpa.org"

**Solutions:**
1. **Be patient on first launch** - Package installation takes 10-15 minutes
2. **Check network connection** - MELPA requires internet
3. **Monitor progress:**
   ```
   Check *Messages* buffer in Emacs: C-h e
   ```
4. **If truly stuck:**
   ```bash
   # Kill Emacs
   killall Emacs emacs

   # Delete package cache
   rm -rf ~/.emacs.d/elpa/

   # Restart Emacs
   open -a Emacs
   ```

### Problem: Emacs won't start - package errors

**Symptoms:**
```
Error: Package ... is unavailable
```

**Solutions:**
```
In Emacs:
M-x package-refresh-contents
M-x package-install use-package
```

Or clean install:
```bash
rm -rf ~/.emacs.d/elpa/
open -a Emacs  # Will reinstall packages
```

---

## ESS (R Mode) Issues

### Problem: R files show as plain text (no syntax highlighting)

**Symptoms:**
- No colors in .R files
- Mode line shows `(Fundamental)` or `(Text)`

**Diagnosis:**
```
In Emacs with R file open:
M-: (package-installed-p 'ess) RET
```

**Solutions:**

**If ESS not installed:**
```
M-x package-install RET ess RET
M-x ess-r-mode
```

**If ESS installed but not activating:**
```
M-x ess-r-mode                    # Manually activate
```

Then check `.R` file association:
```
M-: (assoc "\\.R\\'" auto-mode-alist) RET
```

Should show: `("\\.R\\'" . ess-r-mode)`

**Force ESS for .R files:**
Add to init.el temporarily:
```elisp
(add-to-list 'auto-mode-alist '("\\.R\\'" . ess-r-mode))
```

### Problem: Can't start R console

**Symptoms:**
```
M-x R
Error: No such file or directory: R
```

**Diagnosis:**
```bash
# In terminal:
which R
echo $PATH

# In Emacs:
M-: (getenv "PATH") RET
M-: (executable-find "R") RET
```

**Solutions:**

**macOS GUI Emacs PATH issue:**
```
In Emacs:
C-c r P                           # Export PATH
# Or restart Emacs
```

**Verify PATH in Emacs:**
```
M-: (getenv "PATH") RET
```

Should include `/usr/local/bin` or `/opt/homebrew/bin`.

**Manual fix:**
```bash
~/.emacs.d/bin/export-gui-path.sh
# Then restart Emacs
```

---

## Flycheck Issues

### Problem: Flycheck not working

**Symptoms:**
- No `FlyC` in mode line
- No error highlighting

**Diagnosis:**
```
In Emacs:
M-x flycheck-verify-setup
```

**Solutions:**

**If Flycheck not active:**
```
M-x flycheck-mode               # Toggle on
M-x global-flycheck-mode        # Enable globally
```

**If lintr not found:**
```bash
Rscript -e 'install.packages("lintr")'
```

**If styler checker fails:**
```bash
# Verify script exists
ls -la ~/.emacs.d/bin/r-styler-check.R

# Test manually
Rscript ~/.emacs.d/bin/r-styler-check.R test.R
```

### Problem: Styler checker always fails

**Symptoms:**
```
Flycheck error: STYLER-ERROR: styler package not installed
```

**Solutions:**
```bash
Rscript -e 'install.packages("styler")'
```

**Test manually:**
```bash
Rscript ~/.emacs.d/bin/r-styler-check.R yourfile.R
echo $?  # Should be 0 or 1, not 2
```

---

## LSP Issues

### Problem: LSP not starting

**Symptoms:**
- No `LSP` in mode line
- `M-.` doesn't work
- Message: "LSP :: file.R not in project or it is blocklisted"

**Diagnosis:**
```bash
# Check if languageserver is installed
Rscript -e 'library(languageserver)'
```

**Solutions:**

**Install languageserver:**
```r
install.packages("languageserver")
```

**LSP only works in R packages:**
- Must have `DESCRIPTION` file
- Must be in package directory
- Standalone .R files won't activate LSP

**Force LSP to start:**
```
In Emacs (in R package):
M-x lsp
```

**Check LSP server:**
```
M-x lsp-describe-session
```

### Problem: LSP is slow

**Symptoms:**
- Completions take forever
- Emacs freezes

**Solutions:**
```
Disable LSP temporarily:
M-x lsp-disconnect

Or disable LSP for large files:
Add to init.el:
(setq lsp-file-watch-threshold 10000)
```

---

## Styler Auto-Format Issues

### Problem: Save fails with styler error

**Symptoms:**
```
Styler failed: Error in parse(...)
```

**Solutions:**

**Fix syntax errors first:**
1. Disable styler temporarily:
   ```
   C-c r S                        # Toggle off
   ```
2. Fix syntax errors in R code
3. Re-enable:
   ```
   C-c r S                        # Toggle on
   ```

**Bypass styler for one save:**
```
C-c r S                           # Disable
C-x C-s                           # Save
C-c r S                           # Re-enable
```

### Problem: Styler changes too much

**Symptoms:**
- Styler reformats more than expected
- Want to disable auto-styling

**Solutions:**

**Disable globally:**
```elisp
# Add to init.el:
(setq spacemacs-rstats/styler-enabled nil)
```

**Disable for specific project:**
Create `.dir-locals.el` in project root:
```elisp
((ess-r-mode . ((spacemacs-rstats/styler-enabled . nil))))
```

**Toggle per session:**
```
C-c r S                           # Toggle on/off
```

---

## Company (Completion) Issues

### Problem: No completions appearing

**Symptoms:**
- Type code, nothing happens
- No popup with suggestions

**Diagnosis:**
```
In Emacs:
M-: company-mode RET
```

**Solutions:**

**Enable company:**
```
M-x global-company-mode
```

**Check company is active:**
Look for `company` in mode line.

**Force completion:**
```
M-x company-complete
```

**Adjust delay:**
```elisp
# Add to init.el:
(setq company-idle-delay 0)      # Immediate completion
```

---

## Keybinding Issues

### Problem: `M-` keybindings don't work

**Symptoms:**
- `M-f` doesn't move forward
- `M-.` doesn't go to definition

**Diagnosis:**
Check which key is Meta:
```
In Emacs:
C-h k M-f
```

Should say `M-f runs ...`

**Solutions:**

**On macOS:**
- `M-` = **Option (⌥)**, not Command!
- Try: `Option-f` instead of `Command-f`

**Verify configuration:**
```
M-: mac-option-modifier RET
```

Should show: `meta`

**If wrong:**
Restart Emacs (init.el sets this on startup).

### Problem: `C-c r` doesn't work

**Symptoms:**
- `C-c r r` does nothing
- No which-key popup

**Diagnosis:**
```
In Emacs:
C-h k C-c r
```

**Solutions:**

**Check which-key:**
```
M-x which-key-mode                # Toggle on
```

**Verify keybindings loaded:**
```
M-: (fboundp 'spacemacs-rstats/insert-roxygen-skeleton) RET
```

Should return: `t`

**If `nil`, functions not loaded:**
```
M-x eval-buffer                   # In init.el
```

---

## macOS Specific Issues

### Problem: GUI Emacs can't find R/Quarto

**Symptoms:**
- `M-x R` → "R not found"
- Terminal finds R fine
- GUI Emacs doesn't

**Diagnosis:**
```bash
# Terminal:
which R
echo $PATH

# Emacs:
M-: (getenv "PATH") RET
M-: (executable-find "R") RET
```

**Solutions:**

**Export PATH:**
```
In Emacs:
C-c r P

Or in terminal:
~/.emacs.d/bin/export-gui-path.sh
```

**Verify exec-path-from-shell:**
```
In Emacs:
M-: (package-installed-p 'exec-path-from-shell) RET
```

Should return: `t`

**Manual PATH fix:**
Add to init.el:
```elisp
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin:/opt/homebrew/bin"))
(setq exec-path (append exec-path '("/usr/local/bin" "/opt/homebrew/bin")))
```

### Problem: Emacs won't open files from Finder

**Symptoms:**
- Double-click .R file → nothing
- Or opens in different app

**Solutions:**
```bash
# Set Emacs as default for .R files
# Right-click .R file → Get Info → Open with: Emacs → Change All
```

---

## Performance Issues

### Problem: Emacs is slow

**Symptoms:**
- Typing lags
- Flycheck slows everything down
- LSP freezes Emacs

**Solutions:**

**Disable Flycheck temporarily:**
```
M-x flycheck-mode                 # Toggle off
```

**Disable LSP for large files:**
```
M-x lsp-disconnect
```

**Reduce company delay:**
```elisp
(setq company-idle-delay 0.2)     # Default: 0.1
```

**Disable line numbers:**
```
M-x display-line-numbers-mode     # Toggle off
```

**Check what's slow:**
```
M-x profiler-start
# Work for a bit
M-x profiler-report
```

---

## Getting Help

### Check Messages Buffer
```
C-h e                             # Show *Messages* buffer
```

### Check Warnings
```
C-h w                             # Show *Warnings* (if exists)
```

### Describe Function
```
C-h f function-name               # Show function documentation
```

### Describe Variable
```
C-h v variable-name               # Show variable value
```

### Describe Key
```
C-h k C-c r                       # What does this key do?
```

### Debug Mode
```elisp
# Add to top of init.el:
(setq debug-on-error t)
```

### Test in Clean Emacs
```bash
emacs -Q                          # Start without config
# Then manually load:
M-x load-file RET ~/.emacs.d/init.el RET
```

---

## Emergency Recovery

### Emacs won't start at all

```bash
# Move config aside
mv ~/.emacs.d ~/.emacs.d.broken

# Start fresh Emacs
emacs -Q

# If that works, your config is the problem
# Reinstall:
cd /path/to/spacemacs-rstats
./install-init.sh
```

### Corrupted package directory

```bash
# Remove and reinstall packages
rm -rf ~/.emacs.d/elpa/
open -a Emacs  # Will download all packages fresh
```

### Reset to defaults

```bash
# Complete reset
rm -rf ~/.emacs.d/
./install-init.sh
open -a Emacs
```

---

## Still Having Issues?

1. **Run dependency checker:**
   ```bash
   ./check-dependencies.sh
   ```

2. **Check the Claude skill:**
   - Your `spacemacs-rstats` skill has detailed info

3. **Review TUTORIAL.md:**
   - Might have missed a setup step

4. **Test with minimal config:**
   ```bash
   emacs -Q
   M-x package-initialize
   M-x load-file RET ~/.emacs.d/init.el RET
   ```

5. **Check Emacs version:**
   ```
   M-x emacs-version
   ```
   Requires Emacs 27+

6. **Reinstall from scratch:**
   ```bash
   rm -rf ~/.emacs.d/
   cd spacemacs-rstats
   ./install-init.sh
   ```

---

## Common Error Messages Explained

| Error | Meaning | Solution |
|-------|---------|----------|
| `Package ... is unavailable` | MELPA can't be reached | Check internet, `M-x package-refresh-contents` |
| `No such file or directory: R` | Emacs can't find R | Fix PATH with `C-c r P` |
| `LSP :: not in project` | Not in R package | LSP only works in R packages (needs DESCRIPTION) |
| `STYLER-ERROR` | styler package missing | `Rscript -e 'install.packages("styler")'` |
| `Buffer is read-only` | Trying to edit special buffer | Switch to different buffer |
| `Beginning/End of buffer` | Navigated to start/end | Normal navigation feedback |

---

## Additional Resources

- **Tutorial:** `TUTORIAL.md` - Full user guide
- **Cheat Sheet:** `CHEAT-SHEET.md` - Quick keybinding reference
- **Dependencies:** `check-dependencies.sh` - Verify installation
- **Claude Skills:** `~/.claude/skills/` - Your configuration reference

---

**Last updated:** 2025-12-07
