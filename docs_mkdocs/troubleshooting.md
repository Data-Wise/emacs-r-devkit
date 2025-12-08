# Troubleshooting

Solutions to common issues with emacs-r-devkit on macOS.

!!! tip "Quick Diagnosis"
    Run the dependency checker first:
    ```bash
    ./check-dependencies.sh
    ```
    This identifies most common problems automatically.

## Installation Issues

### init.el Not Found

**Symptom:** Emacs starts but emacs-r-devkit features don't work

**Solution:**

```bash
# Check if init.el exists
ls -la ~/.emacs.d/init.el

# If missing, run installer
cd ~/emacs-r-devkit
./install-init.sh

# Verify installation
ls -la ~/.emacs.d/init.el
ls -la ~/.emacs.d/bin/
```

### Conflicting Configuration

**Symptom:** Emacs won't start, shows errors about packages

**Solution:**

```bash
# Backup existing config
mv ~/.emacs.d ~/.emacs.d.backup
mv ~/.emacs ~/.emacs.backup 2>/dev/null || true

# Clean install
./install-init.sh

# Restart Emacs
open -a Emacs
```

## Startup Issues

### Slow First Launch

**Symptom:** First launch takes > 15 minutes

**Expected:** This is normal! Package installation takes 10-15 minutes.

**Solutions:**

1. Be patient - watch for `Contacting host: melpa.org`
2. Check progress: ++ctrl+h++ ++e++ (*Messages* buffer)
3. If truly stuck (>30 min):

```bash
# Kill Emacs
killall Emacs emacs

# Delete package cache
rm -rf ~/.emacs.d/elpa/

# Restart (will re-download)
open -a Emacs
```

### Package Installation Errors

**Symptom:**
```
Error: Package ... is unavailable
```

**Solution:**

```
In Emacs:
M-x package-refresh-contents RET
M-x package-install RET use-package RET
```

Or clean install:

```bash
rm -rf ~/.emacs.d/elpa/
open -a Emacs
```

## ESS (R Mode) Issues

### No Syntax Highlighting

**Symptom:** R files show as plain text, no colors

**Diagnosis:**

```
In Emacs with .R file open:
M-: (package-installed-p 'ess) RET
```

**Solutions:**

If ESS not installed:

```
M-x package-install RET ess RET
M-x ess-r-mode RET
```

If ESS installed but not activating:

```
M-x ess-r-mode RET
```

### Can't Start R Console

**Symptom:**

```
M-x R
Error: No such file or directory: R
```

**Diagnosis:**

```bash
# In terminal
which R
echo $PATH

# In Emacs
M-: (getenv "PATH") RET
M-: (executable-find "R") RET
```

**Solutions:**

macOS GUI PATH issue:

```
In Emacs:
C-c r P                # Export PATH

# Or in terminal:
~/.emacs.d/bin/export-gui-path.sh

# Then restart Emacs
```

Verify PATH includes `/usr/local/bin` or `/opt/homebrew/bin`.

## Flycheck Issues

### Flycheck Not Working

**Symptom:** No error highlighting, no `FlyC` in mode line

**Diagnosis:**

```
In Emacs:
M-x flycheck-verify-setup RET
```

**Solutions:**

Enable Flycheck:

```
M-x flycheck-mode RET
M-x global-flycheck-mode RET
```

Install lintr:

```bash
Rscript -e 'install.packages("lintr")'
```

Install styler:

```bash
Rscript -e 'install.packages("styler")'
```

### Styler Checker Fails

**Symptom:**

```
STYLER-ERROR: styler package not installed
```

**Solution:**

```bash
# Install styler
Rscript -e 'install.packages("styler")'

# Test manually
Rscript ~/.emacs.d/bin/r-styler-check.R test.R
echo $?  # Should be 0 or 1, not 2
```

## LSP Issues

### LSP Not Starting

**Symptom:** No `LSP` in mode line, `M-.` doesn't work

**Diagnosis:**

```bash
# Check languageserver installed
Rscript -e 'library(languageserver)'
```

**Solutions:**

Install languageserver:

```r
install.packages("languageserver")
```

**Important:** LSP only works in R packages!

- Must have `DESCRIPTION` file
- Standalone `.R` files won't activate LSP

Force LSP start (in R package):

```
M-x lsp RET
```

Check LSP session:

```
M-x lsp-describe-session RET
```

### LSP Is Slow

**Symptom:** Completions take forever, Emacs freezes

**Solutions:**

```
# Disconnect LSP temporarily
M-x lsp-disconnect RET

# Or disable for large files (add to init.el):
(setq lsp-file-watch-threshold 10000)
```

## Styler Auto-Format Issues

### Save Fails with Styler Error

**Symptom:**

```
Styler failed: Error in parse(...)
```

**Cause:** Syntax errors in R code

**Solutions:**

1. Disable styler temporarily:

```
C-c r S                # Toggle off
```

2. Fix syntax errors
3. Re-enable:

```
C-c r S                # Toggle on
```

### Don't Want Auto-Formatting

**Solutions:**

Disable globally (add to init.el):

```elisp
(setq emacs-r-devkit/styler-enabled nil)
```

Disable for specific project (`.dir-locals.el`):

```elisp
((ess-r-mode . ((emacs-r-devkit/styler-enabled . nil))))
```

Toggle per session:

```
C-c r S
```

## Company (Completion) Issues

### No Completions

**Symptom:** Type code, nothing happens

**Diagnosis:**

```
M-: company-mode RET
```

**Solutions:**

```
M-x global-company-mode RET
```

Adjust delay (add to init.el):

```elisp
(setq company-idle-delay 0)  # Immediate
```

## Keybinding Issues

### M- Keys Don't Work

**Symptom:** `M-f` doesn't move forward, `M-.` doesn't work

**Diagnosis:**

```
C-h k M-f
```

Should say `M-f runs ...`

**Solutions:**

On macOS: `M-` = **Option (⌥)**, NOT Command!

Try `Option-f` instead of `Command-f`.

Verify configuration:

```
M-: mac-option-modifier RET
```

Should show: `meta`

If wrong, restart Emacs.

### C-c r Doesn't Work

**Symptom:** `C-c r r` does nothing

**Diagnosis:**

```
C-h k C-c r
```

**Solutions:**

Check which-key:

```
M-x which-key-mode RET
```

Verify functions loaded:

```
M-: (fboundp 'emacs-r-devkit/insert-roxygen-skeleton) RET
```

Should return `t`. If `nil`:

```
M-x eval-buffer RET  # In init.el
```

## macOS Specific Issues

### GUI Emacs Can't Find R

**Symptom:** `M-x R` → "R not found" (but terminal finds R fine)

**Diagnosis:**

```bash
# Terminal
which R
echo $PATH

# Emacs
M-: (getenv "PATH") RET
M-: (executable-find "R") RET
```

**Solutions:**

Export PATH:

```
In Emacs: C-c r P

Or terminal:
~/.emacs.d/bin/export-gui-path.sh
```

Verify exec-path-from-shell:

```
M-: (package-installed-p 'exec-path-from-shell) RET
```

Manual PATH fix (add to init.el):

```elisp
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin:/opt/homebrew/bin"))
(setq exec-path (append exec-path '("/usr/local/bin" "/opt/homebrew/bin")))
```

## Performance Issues

### Emacs Is Slow

**Symptoms:** Typing lags, Flycheck slows down, LSP freezes

**Solutions:**

Disable Flycheck temporarily:

```
M-x flycheck-mode RET
```

Disable LSP:

```
M-x lsp-disconnect RET
```

Reduce company delay:

```elisp
(setq company-idle-delay 0.2)
```

Check what's slow:

```
M-x profiler-start RET
# Work for a bit
M-x profiler-report RET
```

## Getting Help

### Check Messages

```
C-h e                    # *Messages* buffer
C-h w                    # *Warnings* (if exists)
```

### Describe Functions

```
C-h f function-name      # Function docs
C-h v variable-name      # Variable value
C-h k C-c r              # What does this key do?
```

### Debug Mode

Add to top of init.el:

```elisp
(setq debug-on-error t)
```

### Test in Clean Emacs

```bash
emacs -Q                 # Start without config

# Then manually load:
M-x load-file RET ~/.emacs.d/init.el RET
```

## Emergency Recovery

### Emacs Won't Start

```bash
# Move config aside
mv ~/.emacs.d ~/.emacs.d.broken

# Start fresh Emacs
emacs -Q

# If that works, reinstall:
cd ~/emacs-r-devkit
./install-init.sh
```

### Corrupted Packages

```bash
# Remove and reinstall
rm -rf ~/.emacs.d/elpa/
open -a Emacs
```

### Complete Reset

```bash
# Nuclear option
rm -rf ~/.emacs.d/
cd ~/emacs-r-devkit
./install-init.sh
open -a Emacs
```

## Common Error Messages

| Error | Meaning | Solution |
|-------|---------|----------|
| `Package ... is unavailable` | MELPA unreachable | `M-x package-refresh-contents` |
| `No such file or directory: R` | PATH issue | `C-c r P` to export PATH |
| `LSP :: not in project` | Not in R package | LSP needs `DESCRIPTION` file |
| `STYLER-ERROR` | styler missing | `Rscript -e 'install.packages("styler")'` |
| `Buffer is read-only` | Special buffer | Switch to different buffer |

## Additional Resources

- [Configuration Guide](configuration.md) - Customization options
- [GitHub Issues](https://github.com/Data-Wise/emacs-r-devkit/issues) - Report bugs
- `TUTORIAL.md` - Complete user guide
- `CHEAT-SHEET.md` - Quick reference

## Still Having Issues?

1. Run dependency checker: `./check-dependencies.sh`
2. Check Emacs version: `M-x emacs-version` (need 27+)
3. Review error messages carefully
4. Try minimal config (disable features one by one)
5. Report issue on GitHub with error details

---

**Last updated:** 2025-12-07
