# Configuration

Customize emacs-r-devkit to fit your workflow and preferences.

## Configuration File

All configuration is in `~/.emacs.d/init.el` (616 lines).

!!! tip "Live Reload"
    After editing `init.el`, reload with: `M-x eval-buffer`

## Common Customizations

### Disable Auto-Formatting

#### Globally

```elisp
;; Add to init.el
(setq emacs-r-devkit/styler-enabled nil)
```

#### Per Project

Create `.dir-locals.el` in project root:

```elisp
((ess-r-mode . ((emacs-r-devkit/styler-enabled . nil))))
```

#### Per Session

Toggle with ++ctrl+c++ ++r++ ++shift+s++

### Adjust Company Delay

```elisp
;; Faster completions (default: 0.1)
(setq company-idle-delay 0)

;; Slower completions
(setq company-idle-delay 0.5)

;; Disable automatic completions
(setq company-idle-delay nil)
```

### Disable Line Numbers

```elisp
;; Remove line numbers hook
(remove-hook 'prog-mode-hook #'display-line-numbers-mode)
```

### Change Theme

emacs-r-devkit uses `modus-vivendi` (dark) by default.

```elisp
;; Light theme
(load-theme 'modus-operandi t)

;; Other popular themes
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))
```

### Configure Flycheck

```elisp
;; Disable lintr checker
(setq-default flycheck-disabled-checkers '(r-lintr))

;; Only run on save (not while typing)
(setq flycheck-check-syntax-automatically '(save mode-enabled))

;; Adjust delay before checking (milliseconds)
(setq flycheck-idle-change-delay 2.0)
```

### LSP Performance

```elisp
;; Increase file watch threshold for large projects
(setq lsp-file-watch-threshold 10000)

;; Disable LSP for specific projects
;; Add to .dir-locals.el:
((ess-r-mode . ((lsp-mode . nil))))
```

## Advanced Customizations

### Custom Keybindings

```elisp
;; Add to ESS mode hook
(add-hook 'ess-r-mode-hook
  (lambda ()
    ;; Custom keybinding example
    (define-key ess-r-mode-map (kbd "C-c m") 'my-function)

    ;; Remap existing
    (define-key ess-r-mode-map (kbd "C-c C-r") 'ess-eval-region)))
```

### Custom Roxygen Template

```elisp
;; Modify emacs-r-devkit/insert-roxygen-skeleton function
;; in init.el around line 229-279

;; Example: Add custom fields
(defun emacs-r-devkit/insert-roxygen-skeleton ()
  ;; ... existing code ...
  (insert "#' @author Your Name\n")
  (insert "#' @date " (format-time-string "%Y-%m-%d") "\n")
  ;; ... rest of template ...
)
```

### Styler Options

Customize styler behavior by editing `~/.emacs.d/bin/r-styler-check.R`:

```r
# Current default:
styled <- styler::style_text(code_lines)

# Custom options:
styled <- styler::style_text(
  code_lines,
  strict = FALSE,           # Less strict
  indent_by = 4,            # 4-space indent
  scope = "line_breaks"     # Only fix line breaks
)
```

### Font Configuration

```elisp
;; Set font and size
(set-frame-font "Monaco 14" nil t)

;; Or with better fallback
(when (find-font (font-spec :name "JetBrains Mono"))
  (set-frame-font "JetBrains Mono 13" nil t))
```

## Project-Specific Configuration

### Using .dir-locals.el

Create `.dir-locals.el` in project root for project-specific settings:

```elisp
;; Example: Configure for specific package
((ess-r-mode . ((emacs-r-devkit/styler-enabled . nil)
                (flycheck-disabled-checkers . (r-lintr))
                (lsp-mode . nil))))
```

Common uses:

- Disable styler for specific package
- Turn off LSP for large packages
- Project-specific indentation
- Custom compile commands

## Package Management

### Update Packages

```elisp
M-x package-refresh-contents
M-x package-upgrade-all
```

### Install Additional Packages

```elisp
M-x package-install RET package-name RET
```

Popular additions:

- `helm` - Alternative completion framework
- `ivy` - Another completion framework
- `doom-themes` - Additional themes
- `company-quickhelp` - Inline documentation
- `smartparens` - Better paren handling

### Pin Package Versions

```elisp
;; Add to init.el
(setq package-pinned-packages
      '((ess . "melpa-stable")))
```

## R Configuration

### Default R Options

```elisp
;; Set default R options
(setq inferior-R-args "--no-save --no-restore")

;; Use radian instead of R
(setq inferior-R-program-name "radian")
```

### R Startup File

Create `~/.Rprofile` for R-specific settings:

```r
# Load commonly used packages
options(
  repos = c(CRAN = "https://cloud.r-project.org/"),
  browserNLdisabled = TRUE,
  deparse.max.lines = 2
)

if (interactive()) {
  suppressMessages(require(devtools))
  suppressMessages(require(usethis))
}
```

## Performance Tuning

### Reduce Startup Time

```elisp
;; Defer package loading
(use-package package-name
  :defer t  ; Load when needed
  :commands (command1 command2))

;; Increase GC threshold during startup
(setq gc-cons-threshold (* 50 1000 1000))
```

### Reduce Memory Usage

```elisp
;; Lower GC threshold (default is high for performance)
(setq gc-cons-threshold (* 20 1000 1000))

;; Disable features you don't use
(setq lsp-enable-symbol-highlighting nil)
(setq lsp-ui-doc-enable nil)
```

## Backup Configuration

### Change Backup Directory

```elisp
;; Already configured in init.el, but can customize:
(setq backup-directory-alist
      '((".*" . "~/.emacs.d/backups/")))

;; Or disable backups entirely
(setq make-backup-files nil)
```

### Auto-Save Configuration

```elisp
;; Already configured, but can adjust:
(setq auto-save-file-name-transforms
      '((".*" "~/.emacs.d/auto-saves/" t)))

;; Adjust auto-save interval (default: 300 characters)
(setq auto-save-interval 200)
```

## Debugging Configuration

### Enable Debug Mode

```elisp
;; Add to top of init.el temporarily
(setq debug-on-error t)

;; See full error traces
```

### Profile Startup

```elisp
M-x emacs-init-time       # Total startup time
M-x profiler-start        # Start profiling
M-x profiler-report       # See results
```

## Environment Variables

### Set Environment Variables

```elisp
;; Add to init.el
(setenv "R_LIBS_USER" "~/R/library")
(setenv "GITHUB_PAT" "your-token")

;; Or load from file
(when (file-exists-p "~/.emacs.d/env.el")
  (load "~/.emacs.d/env.el"))
```

## Integration with External Tools

### Configure External Tools

```elisp
;; Quarto
(setq quarto-program "/opt/homebrew/bin/quarto")

;; Custom R checker
(setq flycheck-r-lintr-linters
      "with_defaults(line_length_linter(120))")
```

## Reset to Defaults

### Full Reset

```bash
# Backup current config
mv ~/.emacs.d ~/.emacs.d.backup

# Reinstall
cd ~/emacs-r-devkit
./install-init.sh
```

### Partial Reset

```bash
# Just reset packages
rm -rf ~/.emacs.d/elpa/

# Restart Emacs to reinstall
```

## Configuration Examples

### Minimal Setup

For low-powered machines:

```elisp
;; Disable heavy features
(setq emacs-r-devkit/styler-enabled nil)
(setq lsp-mode nil)
(setq company-idle-delay nil)  ; Manual completion only

;; Keep essential features
;; - ESS
;; - Flycheck with lintr only
;; - Basic completion
```

### Maximum Features

For powerful machines:

```elisp
;; Enable all features at max
(setq company-idle-delay 0)
(setq flycheck-idle-change-delay 0.5)
(setq lsp-file-watch-threshold 50000)

;; Add extra packages
(use-package company-quickhelp
  :ensure t
  :config
  (company-quickhelp-mode))
```

## Getting Help

### Check Current Values

```elisp
M-: variable-name RET           # Check variable value
C-h v variable-name RET         # Describe variable
C-h f function-name RET         # Describe function
```

### Test Configuration

```bash
# Test with fresh config
emacs -Q

# Load init.el manually
M-x load-file RET ~/.emacs.d/init.el RET
```

---

**Next:** Check the [Troubleshooting](troubleshooting.md) guide if you encounter issues.
