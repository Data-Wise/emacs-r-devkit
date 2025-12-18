# Troubleshooting

> **TL;DR:** Run `./scripts/health-check.sh` to diagnose issues.  
> Common fixes: `./scripts/repair.sh` (interactive menu)

Solutions to common issues with spacemacs-rstats Spacemacs environment on macOS.

## Installation Issues

### Configuration Not Found

**Symptom:** Spacemacs starts but spacemacs-rstats features don't work

**Solution:**

```bash
# Check if .spacemacs exists
ls -la ~/.spacemacs

# If missing, copy from spacemacs-rstats
cd ~/spacemacs-rstats
cp dotspacemacs.el ~/.spacemacs

# Verify helper scripts
ls -la ~/.emacs.d/bin/
```bash

### Conflicting Configuration

**Symptom:** Emacs won't start, shows errors about packages

**Solution:**

```bash
# Backup existing config
mv ~/.spacemacs ~/.spacemacs.backup

# Copy fresh config
cd ~/spacemacs-rstats
cp dotspacemacs.el ~/.spacemacs

# Restart Spacemacs
open -a Emacs
```bash

## Startup Issues

### Slow First Launch

**Symptom:** First launch takes > 15 minutes

**Expected:** This is normal! Spacemacs layer installation takes 10-15 minutes.

**Solutions:**

1. Be patient - watch for layer installation progress
2. Check progress: `SPC h d v` then type `*Messages*`
3. If truly stuck (>30 min):

```bash
# Kill Emacs
killall Emacs emacs

# Delete package cache
rm -rf ~/.emacs.d/elpa/

# Restart (will re-download)
open -a Emacs
```bash

### Package Installation Errors

**Symptom:**

```yaml
Error: Package ... is unavailable
```text

**Solution:**

```text
In Emacs:
M-x package-refresh-contents RET
M-x package-install RET use-package RET
```text

Or clean install:

```bash
rm -rf ~/.emacs.d/elpa/
open -a Emacs
```bash

## Spacemacs-Specific Issues

### Stuck in Insert Mode

**Symptom:** Can't execute commands, everything types text

**Solution:**

Press `ESC` or type `fd` quickly to return to Normal mode.

**Prevention:** Learn the modes:

- **Normal mode** (`<N>`) - For navigation and commands
- **Insert mode** (`<I>`) - For typing text
- **Visual mode** (`<V>`) - For selecting text

### Leader Key Not Working

**Symptom:** `SPC` just types a space

**Diagnosis:**

You're in Insert mode!

**Solution:**

1. Press `ESC` to return to Normal mode
2. Then press `SPC` - should show which-key menu

### Modal Editing Confusion

**Symptom:** Commands don't work as expected

**Solution:**

Check your mode indicator in the status line:

- `<N>` = Normal mode (for commands)
- `<I>` = Insert mode (for typing)
- `<V>` = Visual mode (for selecting)

**Quick reference:**

- `i` = Enter Insert mode
- `ESC` or `fd` = Return to Normal mode
- `v` = Enter Visual mode

### Layer Not Loading

**Symptom:** ESS or LSP features not working

**Diagnosis:**

```text
SPC h L    # List installed layers
```text

**Solution:**

Edit `~/.spacemacs` and verify layers:

```elisp
dotspacemacs-configuration-layers
'(
  auto-completion
  ess
  lsp
  syntax-checking
  git
)
```text

Then reload: `SPC f e R`

## ESS (R Mode) Issues

### No Syntax Highlighting

**Symptom:** R files show as plain text, no colors

**Diagnosis:**

```text
In Spacemacs with .R file open:
SPC h d v package-installed-p RET
Type: ess
```text

**Solutions:**

If ESS not installed:

```text
M-x package-install RET ess RET
M-x ess-r-mode RET
```text

If ESS installed but not activating:

```text
SPC SPC ess-r-mode RET
```bash

### Can't Start R Console

**Symptom:**

```text
SPC SPC R
Error: No such file or directory: R
```text

**Diagnosis:**

```bash
# In terminal
which R
echo $PATH

# In Spacemacs
SPC h d v getenv RET
Type: PATH
SPC h d v executable-find RET
Type: R
```text

**Solutions:**

macOS GUI PATH issue (Spacemacs uses `exec-path-from-shell`):

```text
In Spacemacs:
SPC f e R              # Reload configuration

# Then restart Spacemacs
```text

Verify PATH includes `/usr/local/bin` or `/opt/homebrew/bin`.

## Flycheck Issues

### Flycheck Not Working

**Symptom:** No error highlighting, no `FlyC` in mode line

**Diagnosis:**

```text
In Spacemacs:
SPC h d v flycheck-verify-setup RET
```text

**Solutions:**

Enable Flycheck:

```text
SPC SPC flycheck-mode RET
SPC SPC global-flycheck-mode RET
```text

Install lintr:

```bash
Rscript -e 'install.packages("lintr")'
```text

Install styler:

```bash
Rscript -e 'install.packages("styler")'
```bash

### Styler Checker Fails

**Symptom:**

```yaml
STYLER-ERROR: styler package not installed
```text

**Solution:**

```bash
# Install styler
Rscript -e 'install.packages("styler")'

# Test manually
Rscript ~/.emacs.d/bin/r-styler-check.R test.R
echo $?  # Should be 0 or 1, not 2
```bash

## LSP Issues

### LSP Not Starting

**Symptom:** No `LSP` in mode line, `, g g` doesn't work

**Diagnosis:**

```bash
# Check languageserver installed
Rscript -e 'library(languageserver)'
```text

**Solutions:**

Install languageserver:

```r
install.packages("languageserver")
```text

**Important:** LSP only works in R packages!

- Must have `DESCRIPTION` file
- Standalone `.R` files won't activate LSP

Force LSP start (in R package):

```text
SPC SPC lsp RET
```text

Check LSP session:

```text
SPC h d v lsp-describe-session RET
```bash

### LSP Is Slow

**Symptom:** Completions take forever, Emacs freezes

**Solutions:**

```bash
# Disconnect LSP temporarily
SPC SPC lsp-disconnect RET

# Or disable for large files (add to ~/.spacemacs user-config):
(setq lsp-file-watch-threshold 10000)
```bash

## Styler Auto-Format Issues

### Save Fails with Styler Error

**Symptom:**

```text
Styler failed: Error in parse(...)
```text

**Cause:** Syntax errors in R code

**Solutions:**

1. Disable styler temporarily:

```text
, =                    # Toggle formatting
```text

2. Fix syntax errors
3. Re-enable:

```text
, =                    # Toggle on
```bash

### Don't Want Auto-Formatting

**Solutions:**

Disable globally (add to ~/.spacemacs user-config):

```elisp
(setq spacemacs-rstats/styler-enabled nil)
```text

Disable for specific project (`.dir-locals.el`):

```elisp
((ess-r-mode . ((spacemacs-rstats/styler-enabled . nil))))
```text

Toggle per session:

```text
, =
```bash

## Company (Completion) Issues

### No Completions

**Symptom:** Type code, nothing happens

**Diagnosis:**

```text
SPC h d v company-mode RET
```text

**Solutions:**

```text
SPC SPC global-company-mode RET
```text

Adjust delay (add to ~/.spacemacs user-config):

```elisp
(setq company-idle-delay 0)  # Immediate
```bash

## Keybinding Issues

### M- Keys Don't Work

**Symptom:** `SPC` doesn't work, `,` doesn't work

**Diagnosis:**

You're in Insert mode! Press `ESC` first.

**In Normal mode:**

```text
SPC h d k SPC
```text

Should say `SPC runs spacemacs-cmds`

**Solutions:**

Make sure you're in Normal mode (press `ESC`).

For traditional Emacs keybindings, you can still use Option (⌥) as Meta:

- `M-x` = `Option-x` (or use `SPC SPC`)
- `M-.` = `Option-.` (or use `, g g`)

### Major Mode Leader Not Working

**Symptom:** `,` does nothing in R files

**Diagnosis:**

1. Make sure you're in Normal mode (press `ESC`)
2. Make sure you're in an R file (`.R` extension)
3. Check which-key:

```text
SPC h d v which-key-mode RET
```text

**Solutions:**

Verify ESS mode is active:

```text
SPC h d v major-mode RET
```text

Should return `ess-r-mode`.

## macOS Specific Issues

### GUI Spacemacs Can't Find R

**Symptom:** `SPC SPC R` → "R not found" (but terminal finds R fine)

**Diagnosis:**

```bash
# Terminal
which R
echo $PATH

# Spacemacs
SPC h d v getenv RET (type PATH)
SPC h d v executable-find RET (type R)
```text

**Solutions:**

Spacemacs uses `exec-path-from-shell` automatically.

If still having issues, reload configuration:

```text
SPC f e R
```text

Verify exec-path-from-shell:

```text
SPC h d v package-installed-p RET
Type: exec-path-from-shell
```text

Manual PATH fix (add to ~/.spacemacs user-config):

```elisp
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin:/opt/homebrew/bin"))
(setq exec-path (append exec-path '("/usr/local/bin" "/opt/homebrew/bin")))
```bash

## Performance Issues

### Emacs Is Slow

**Symptoms:** Typing lags, Flycheck slows down, LSP freezes

**Solutions:**

Disable Flycheck temporarily:

```text
SPC SPC flycheck-mode RET
```text

Disable LSP:

```text
SPC SPC lsp-disconnect RET
```text

Reduce company delay:

```elisp
(setq company-idle-delay 0.2)
```text

Check what's slow:

```text
SPC SPC profiler-start RET
# Work for a bit
SPC SPC profiler-report RET
```bash

## Getting Help

### Check Messages

```text
SPC h d v *Messages*    # View messages
SPC b b *Warnings*      # View warnings (if exists)
```bash

### Describe Functions

```text
SPC h d f function-name      # Function docs
SPC h d v variable-name      # Variable value
SPC h d k SPC                # What does this key do?
```bash

### Debug Mode

Add to top of ~/.spacemacs user-config:

```elisp
(setq debug-on-error t)
```bash

### Test in Clean Spacemacs

```bash
emacs -Q                 # Start without config

# Then manually load Spacemacs:
SPC h d v load-file RET ~/.emacs.d/init.el RET
```bash

## Emergency Recovery

### Spacemacs Won't Start

```bash
# Move config aside
mv ~/.spacemacs ~/.spacemacs.broken

# Start fresh Spacemacs (will regenerate config)
emacs

# If that works, restore spacemacs-rstats config:
cd ~/spacemacs-rstats
cp dotspacemacs.el ~/.spacemacs
```bash

### Corrupted Packages

```bash
# Remove and reinstall
rm -rf ~/.emacs.d/elpa/
open -a Emacs
```bash

### Complete Reset

```bash
# Nuclear option
rm -rf ~/.emacs.d/
rm ~/.spacemacs

# Reinstall Spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cd ~/.emacs.d && git checkout develop

# Install spacemacs-rstats config
cd ~/spacemacs-rstats
cp dotspacemacs.el ~/.spacemacs
open -a Emacs
```bash

## Common Error Messages

| Error | Meaning | Solution |
|-------|---------|----------|
| `Package ... is unavailable` | MELPA unreachable | `SPC SPC package-refresh-contents` |
| `No such file or directory: R` | PATH issue | `SPC f e R` to reload config |
| `LSP :: not in project` | Not in R package | LSP needs `DESCRIPTION` file |
| `STYLER-ERROR` | styler missing | `Rscript -e 'install.packages("styler")'` |
| `Buffer is read-only` | Special buffer | Switch to different buffer |
| Stuck in Insert mode | Modal editing | Press `ESC` or `fd` |

## Additional Resources

- [Configuration Guide](configuration.md) - Customization options
- [GitHub Issues](https://github.com/Data-Wise/spacemacs-rstats/issues) - Report bugs
- `TUTORIAL.md` - Complete user guide
- `CHEAT-SHEET.md` - Quick reference

## Still Having Issues?

1. Run dependency checker: `./check-dependencies.sh`
2. Check Spacemacs version: `SPC h d v spacemacs-version`
3. Check Emacs version: `SPC h d v emacs-version` (need 27+)
4. Review error messages carefully
5. Try minimal config (disable layers one by one)
6. Report issue on GitHub with error details

---

**Last updated:** 2025-12-18 (Updated for Spacemacs)
