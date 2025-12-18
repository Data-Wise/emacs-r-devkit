# Configuration

Customize emacs-r-devkit Spacemacs environment for your R development workflow.

## Configuration File

All Spacemacs configuration is in `~/.spacemacs` (generated on first launch).

!!! tip "Live Reload"
    After editing `~/.spacemacs`, reload with: `SPC f e R` (reload configuration)

## Understanding Spacemacs Configuration

The `~/.spacemacs` file has three main sections:

### 1. `dotspacemacs/layers`

Define which Spacemacs layers to load:

```elisp
dotspacemacs-configuration-layers
'(
  auto-completion
  ess                    ; R support
  git
  lsp
  syntax-checking
  ;; Add more layers here
)
```

### 2. `dotspacemacs/init`

Set Spacemacs settings (theme, fonts, etc.):

```elisp
dotspacemacs-themes '(spacemacs-dark spacemacs-light)
dotspacemacs-default-font '("Source Code Pro" :size 13)
```

### 3. `dotspacemacs/user-config`

Your custom configuration and keybindings:

```elisp
(defun dotspacemacs/user-config ()
  "Configuration for user code."
  ;; Your customizations here
)
```

## Common Customizations

### Change Theme

```elisp
;; In dotspacemacs/init
dotspacemacs-themes '(doom-one spacemacs-dark spacemacs-light)

;; Then install doom-themes layer
;; In dotspacemacs/layers, add:
dotspacemacs-additional-packages '(doom-themes)
```

### Adjust Completion Delay

```elisp
;; In dotspacemacs/user-config
(setq company-idle-delay 0.2)  ; Faster (default: 0.2)
(setq company-idle-delay 0.5)  ; Slower
(setq company-idle-delay nil)  ; Manual only
```

### Disable Auto-Formatting

#### Globally

```elisp
;; In dotspacemacs/user-config
(setq emacs-r-devkit/styler-enabled nil)
```

#### Per Project

Create `.dir-locals.el` in project root:

```elisp
((ess-r-mode . ((emacs-r-devkit/styler-enabled . nil))))
```

### Configure Font

```elisp
;; In dotspacemacs/init
dotspacemacs-default-font '("JetBrains Mono"
                            :size 14
                            :weight normal
                            :width normal)
```

Popular fonts for coding:

- JetBrains Mono
- Fira Code
- Source Code Pro
- Monaco (macOS default)

### Line Numbers

```elisp
;; In dotspacemacs/init
dotspacemacs-line-numbers t           ; Enable
dotspacemacs-line-numbers 'relative   ; Relative numbers
dotspacemacs-line-numbers nil         ; Disable
```

## Layer Configuration

### ESS Layer Options

```elisp
;; In dotspacemacs/layers
(ess :variables
     ess-r-backend 'lsp              ; Use LSP (default)
     ess-r-backend 'ess              ; Use ESS only
     ess-assign-key nil)             ; Disable _ -> <- conversion
```

### LSP Layer Options

```elisp
;; In dotspacemacs/layers
(lsp :variables
     lsp-ui-doc-enable t             ; Show documentation popup
     lsp-ui-sideline-enable t        ; Show info in sideline
     lsp-lens-enable nil)            ; Disable code lens
```

### Auto-Completion Layer

```elisp
;; In dotspacemacs/layers
(auto-completion :variables
                 auto-completion-enable-help-tooltip t
                 auto-completion-enable-snippets-in-popup t
                 auto-completion-enable-sort-by-usage t)
```

## R-Specific Configuration

### Default R Options

```elisp
;; In dotspacemacs/user-config
(setq inferior-R-args "--no-save --no-restore --quiet")
```

### Use Radian Instead of R

```elisp
;; In dotspacemacs/user-config
(setq inferior-R-program-name "radian")
```

### R Startup File

Create `~/.Rprofile`:

```r
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

## Custom Keybindings

### Add Global Keybinding

```elisp
;; In dotspacemacs/user-config
(spacemacs/set-leader-keys "o c" 'my-custom-function)
;; Access with: SPC o c
```

### Add R Mode Keybinding

```elisp
;; In dotspacemacs/user-config
(spacemacs/set-leader-keys-for-major-mode 'ess-r-mode
  "x" 'my-r-function)
;; Access in R files with: , x
```

### Remap Existing Keybinding

```elisp
;; In dotspacemacs/user-config
(define-key ess-r-mode-map (kbd "C-c C-r") 'ess-eval-region)
```

## Performance Tuning

### Reduce Startup Time

```elisp
;; In dotspacemacs/init
dotspacemacs-enable-lazy-installation 'unused  ; Lazy load layers
```

### LSP Performance

```elisp
;; In dotspacemacs/user-config
(setq lsp-file-watch-threshold 10000)  ; For large projects
(setq lsp-enable-symbol-highlighting nil)  ; Disable if slow
```

### Flycheck Configuration

```elisp
;; In dotspacemacs/user-config
(setq flycheck-check-syntax-automatically '(save mode-enabled))
(setq flycheck-idle-change-delay 2.0)
```

## Project-Specific Configuration

### Using .dir-locals.el

Create `.dir-locals.el` in project root:

```elisp
((ess-r-mode . ((emacs-r-devkit/styler-enabled . nil)
                (flycheck-disabled-checkers . (r-lintr))
                (lsp-mode . nil))))
```

Common uses:

- Disable styler for specific packages
- Turn off LSP for large packages
- Project-specific indentation
- Custom R options

## Adding Layers

### Install Additional Layers

Edit `~/.spacemacs`:

```elisp
dotspacemacs-configuration-layers
'(
  ;; Existing layers
  ess
  lsp
  
  ;; Add new layers
  markdown
  yaml
  docker
  python  ; If you also use Python
)
```

Then reload: `SPC f e R`

### Popular Layers for R Development

- `markdown` - Markdown support (for README.md)
- `yaml` - YAML support (for config files)
- `org` - Org-mode (literate programming)
- `latex` - LaTeX support
- `spell-checking` - Spell checker
- `version-control` - Enhanced git features

## Customizing Roxygen Templates

```elisp
;; In dotspacemacs/user-config
(defun my-roxygen-template ()
  "Custom roxygen template."
  (interactive)
  (insert "#' Title\n")
  (insert "#'\n")
  (insert "#' @description Description\n")
  (insert "#' @param x Parameter\n")
  (insert "#' @return Return value\n")
  (insert "#' @export\n")
  (insert "#' @examples\n")
  (insert "#' # Example code\n"))

;; Bind to keybinding
(spacemacs/set-leader-keys-for-major-mode 'ess-r-mode
  "h c" 'my-roxygen-template)
```

## Environment Variables

```elisp
;; In dotspacemacs/user-config
(setenv "R_LIBS_USER" "~/R/library")
(setenv "GITHUB_PAT" "your-token")
```

## Backup and Auto-Save

### Change Backup Directory

```elisp
;; In dotspacemacs/user-config
(setq backup-directory-alist
      '((".*" . "~/.emacs.d/backups/")))
```

### Disable Backups

```elisp
;; In dotspacemacs/user-config
(setq make-backup-files nil)
```

## Debugging Configuration

### Enable Debug Mode

```elisp
;; Add to top of dotspacemacs/user-config temporarily
(setq debug-on-error t)
```

### Check Startup Time

```
SPC h d v emacs-init-time RET
```

### Profile Startup

```
M-x profiler-start RET
M-x profiler-report RET
```

## Reset Configuration

### Reset to Defaults

```bash
# Backup current config
mv ~/.spacemacs ~/.spacemacs.backup

# Restart Spacemacs - will regenerate ~/.spacemacs
emacs
```

### Reset Packages

```bash
# Remove installed packages
rm -rf ~/.emacs.d/elpa/

# Restart Spacemacs to reinstall
```

## Configuration Examples

### Minimal Setup (Low-Powered Machines)

```elisp
;; In dotspacemacs/layers
dotspacemacs-configuration-layers
'(
  ess
  syntax-checking  ; Flycheck only, no LSP
)

;; In dotspacemacs/user-config
(setq company-idle-delay nil)  ; Manual completion
(setq emacs-r-devkit/styler-enabled nil)
```

### Maximum Features (Powerful Machines)

```elisp
;; In dotspacemacs/layers
dotspacemacs-configuration-layers
'(
  (auto-completion :variables
                   auto-completion-enable-help-tooltip t)
  ess
  (lsp :variables
       lsp-ui-doc-enable t
       lsp-ui-sideline-enable t)
  syntax-checking
  git
  version-control
)

;; In dotspacemacs/user-config
(setq company-idle-delay 0)
(setq lsp-file-watch-threshold 50000)
```

## Getting Help

### Check Configuration Values

```
SPC h d v variable-name RET    ; Describe variable
SPC h d f function-name RET    ; Describe function
```

### Reload Configuration

```
SPC f e R    ; Reload configuration
SPC f e d    ; Open ~/.spacemacs
```

### Test Configuration

```bash
# Start with minimal config
emacs -Q

# Load Spacemacs manually
M-x load-file RET ~/.emacs.d/init.el RET
```

---

**Next:** Check the [Troubleshooting](troubleshooting.md) guide if you encounter issues.
