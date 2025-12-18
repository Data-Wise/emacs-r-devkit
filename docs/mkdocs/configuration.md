# Configuration

Customize spacemacs-rstats Spacemacs environment for your R development workflow.

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
```bash

### 2. `dotspacemacs/init`

Set Spacemacs settings (theme, fonts, etc.):

```elisp
dotspacemacs-themes '(spacemacs-dark spacemacs-light)
dotspacemacs-default-font '("Source Code Pro" :size 13)
```bash

### 3. `dotspacemacs/user-config`

Your custom configuration and keybindings:

```elisp
(defun dotspacemacs/user-config ()
  "Configuration for user code."
  ;; Your customizations here
)
```bash

## Common Customizations

### Change Theme

```elisp
;; In dotspacemacs/init
dotspacemacs-themes '(doom-one spacemacs-dark spacemacs-light)

;; Then install doom-themes layer
;; In dotspacemacs/layers, add:
dotspacemacs-additional-packages '(doom-themes)
```bash

### Adjust Completion Delay

```elisp
;; In dotspacemacs/user-config
(setq company-idle-delay 0.2)  ; Faster (default: 0.2)
(setq company-idle-delay 0.5)  ; Slower
(setq company-idle-delay nil)  ; Manual only
```bash

### Disable Auto-Formatting

#### Globally

```elisp
;; In dotspacemacs/user-config
(setq spacemacs-rstats/styler-enabled nil)
```bash

#### Per Project

Create `.dir-locals.el` in project root:

```elisp
((ess-r-mode . ((spacemacs-rstats/styler-enabled . nil))))
```bash

### Configure Font

```elisp
;; In dotspacemacs/init
dotspacemacs-default-font '("JetBrains Mono"
                            :size 14
                            :weight normal
                            :width normal)
```text

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
```bash

## Layer Configuration

### ESS Layer Options

```elisp
;; In dotspacemacs/layers
(ess :variables
     ess-r-backend 'lsp              ; Use LSP (default)
     ess-r-backend 'ess              ; Use ESS only
     ess-assign-key nil)             ; Disable _ -> <- conversion
```bash

### LSP Layer Options

```elisp
;; In dotspacemacs/layers
(lsp :variables
     lsp-ui-doc-enable t             ; Show documentation popup
     lsp-ui-sideline-enable t        ; Show info in sideline
     lsp-lens-enable nil)            ; Disable code lens
```bash

### Auto-Completion Layer

```elisp
;; In dotspacemacs/layers
(auto-completion :variables
                 auto-completion-enable-help-tooltip t
                 auto-completion-enable-snippets-in-popup t
                 auto-completion-enable-sort-by-usage t)
```bash

## R-Specific Configuration

### Default R Options

```elisp
;; In dotspacemacs/user-config
(setq inferior-R-args "--no-save --no-restore --quiet")
```bash

### Use Radian Instead of R

```elisp
;; In dotspacemacs/user-config
(setq inferior-R-program-name "radian")
```bash

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
```bash

## Custom Keybindings

### Add Global Keybinding

```elisp
;; In dotspacemacs/user-config
(spacemacs/set-leader-keys "o c" 'my-custom-function)
;; Access with: SPC o c
```bash

### Add R Mode Keybinding

```elisp
;; In dotspacemacs/user-config
(spacemacs/set-leader-keys-for-major-mode 'ess-r-mode
  "x" 'my-r-function)
;; Access in R files with: , x
```bash

### Remap Existing Keybinding

```elisp
;; In dotspacemacs/user-config
(define-key ess-r-mode-map (kbd "C-c C-r") 'ess-eval-region)
```bash

## Performance Tuning

### Reduce Startup Time

```elisp
;; In dotspacemacs/init
dotspacemacs-enable-lazy-installation 'unused  ; Lazy load layers
```bash

### LSP Performance

```elisp
;; In dotspacemacs/user-config
(setq lsp-file-watch-threshold 10000)  ; For large projects
(setq lsp-enable-symbol-highlighting nil)  ; Disable if slow
```bash

### Flycheck Configuration

```elisp
;; In dotspacemacs/user-config
(setq flycheck-check-syntax-automatically '(save mode-enabled))
(setq flycheck-idle-change-delay 2.0)
```bash

## Project-Specific Configuration

### Using .dir-locals.el

Create `.dir-locals.el` in project root:

```elisp
((ess-r-mode . ((spacemacs-rstats/styler-enabled . nil)
                (flycheck-disabled-checkers . (r-lintr))
                (lsp-mode . nil))))
```text

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
```text

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
```bash

## Environment Variables

```elisp
;; In dotspacemacs/user-config
(setenv "R_LIBS_USER" "~/R/library")
(setenv "GITHUB_PAT" "your-token")
```bash

## Backup and Auto-Save

### Change Backup Directory

```elisp
;; In dotspacemacs/user-config
(setq backup-directory-alist
      '((".*" . "~/.emacs.d/backups/")))
```bash

### Disable Backups

```elisp
;; In dotspacemacs/user-config
(setq make-backup-files nil)
```bash

## Debugging Configuration

### Enable Debug Mode

```elisp
;; Add to top of dotspacemacs/user-config temporarily
(setq debug-on-error t)
```bash

### Check Startup Time

```text
SPC h d v emacs-init-time RET
```bash

### Profile Startup

```text
M-x profiler-start RET
M-x profiler-report RET
```bash

## Reset Configuration

### Reset to Defaults

```bash
# Backup current config
mv ~/.spacemacs ~/.spacemacs.backup

# Restart Spacemacs - will regenerate ~/.spacemacs
emacs
```bash

### Reset Packages

```bash
# Remove installed packages
rm -rf ~/.emacs.d/elpa/

# Restart Spacemacs to reinstall
```bash

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
(setq spacemacs-rstats/styler-enabled nil)
```bash

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
```bash

## Getting Help

### Check Configuration Values

```text
SPC h d v variable-name RET    ; Describe variable
SPC h d f function-name RET    ; Describe function
```bash

### Reload Configuration

```text
SPC f e R    ; Reload configuration
SPC f e d    ; Open ~/.spacemacs
```bash

### Test Configuration

```bash
# Start with minimal config
emacs -Q

# Load Spacemacs manually
M-x load-file RET ~/.emacs.d/config/init.el RET
```text

---

**Next:** Check the [Troubleshooting](troubleshooting.md) guide if you encounter issues.
