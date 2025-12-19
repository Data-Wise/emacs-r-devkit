# Customizing Spacemacs Visual Appearance

**Level:** Beginner  
**Time:** 15-20 minutes  
**Goal:** Learn to customize fonts, themes, colors, and display settings

---

## 📋 Table of Contents

1. [Quick Reference](#quick-reference)
2. [Changing Themes](#changing-themes)
3. [Customizing Fonts](#customizing-fonts)
4. [Window & Frame Settings](#window--frame-settings)
5. [Mode Line Customization](#mode-line-customization)
6. [Color & Transparency](#color--transparency)
7. [Line Numbers & Visual Aids](#line-numbers--visual-aids)
8. [Advanced Customization](#advanced-customization)

---

## Quick Reference

### Essential Commands

| Action | Command | Description |
|--------|---------|-------------|
| Open config | `SPC f e d` | Edit dotfile (~/.spacemacs) |
| Reload config | `SPC f e R` | Apply changes |
| Cycle themes | `SPC T n` | Next theme in list |
| Increase font | `SPC z x` | Zoom in |
| Decrease font | `SPC z X` | Zoom out |
| Reset font | `SPC z 0` | Reset to default |

---

## Changing Themes

### Built-in Themes

Spacemacs comes with many beautiful themes pre-installed.

#### 1. Quick Theme Switching

**Try themes interactively:**

```
SPC T s
```

Type theme name (e.g., `monokai`, `solarized-dark`, `zenburn`)

**Cycle through your theme list:**

```
SPC T n    (next theme)
SPC T p    (previous theme)
```

#### 2. Set Default Themes

**Edit your config:**

```
SPC f e d
```

**Find this section** (around line 215):

```elisp
dotspacemacs-themes '(spacemacs-dark
                      spacemacs-light)
```

**Popular theme combinations:**

**Dark themes:**

```elisp
dotspacemacs-themes '(doom-one
                      monokai
                      zenburn
                      solarized-dark
                      dracula)
```

**Light themes:**

```elisp
dotspacemacs-themes '(spacemacs-light
                      solarized-light
                      leuven
                      tango)
```

**Mixed (dark + light):**

```elisp
dotspacemacs-themes '(doom-one          ; Dark for coding
                      spacemacs-light)  ; Light for reading
```

**Save and reload:** `SPC f s` then `SPC f e R`

#### 3. Installing Additional Themes

**Add to `dotspacemacs-additional-packages`** (around line 70):

```elisp
dotspacemacs-additional-packages '(doom-themes
                                   nord-theme
                                   gruvbox-theme
                                   cyberpunk-theme)
```

**Popular theme packages:**

- `doom-themes` - Modern, vibrant themes
- `nord-theme` - Arctic, bluish palette
- `gruvbox-theme` - Retro groove colors
- `solarized-theme` - Precision colors
- `dracula-theme` - Dark theme with purple accents

---

## Customizing Fonts

### 1. Change Font Family

**Edit your config:**

```
SPC f e d
```

**Find this section** (around line 236):

```elisp
dotspacemacs-default-font '("Source Code Pro"
                            :size 10.0
                            :weight normal
                            :width normal)
```

**Popular programming fonts:**

**Monospaced fonts for coding:**

```elisp
;; Fira Code (with ligatures)
dotspacemacs-default-font '("Fira Code"
                            :size 14.0
                            :weight normal
                            :width normal)

;; JetBrains Mono
dotspacemacs-default-font '("JetBrains Mono"
                            :size 13.0
                            :weight normal
                            :width normal)

;; Hack
dotspacemacs-default-font '("Hack"
                            :size 12.0
                            :weight normal
                            :width normal)

;; Menlo (macOS default)
dotspacemacs-default-font '("Menlo"
                            :size 12.0
                            :weight normal
                            :width normal)

;; Monaco (macOS classic)
dotspacemacs-default-font '("Monaco"
                            :size 12.0
                            :weight normal
                            :width normal)
```

### 2. Adjust Font Size

**Interactively (temporary):**

```
SPC z x    (increase)
SPC z X    (decrease)
SPC z 0    (reset)
```

**Permanently in config:**

```elisp
dotspacemacs-default-font '("Fira Code"
                            :size 16.0    ; <-- Change this
                            :weight normal
                            :width normal)
```

**Size guidelines:**

- **Small:** 10-12pt (for high-DPI displays)
- **Medium:** 13-14pt (comfortable default)
- **Large:** 15-18pt (easier on eyes)
- **Presentation:** 20-24pt (for sharing screen)

### 3. Font Weight & Width

**Font weight options:**

```elisp
:weight thin
:weight light
:weight normal      ; Default
:weight medium
:weight semi-bold
:weight bold
```

**Font width options:**

```elisp
:width ultra-condensed
:width condensed
:width normal       ; Default
:width semi-expanded
:width expanded
```

**Example - Bold, wide font:**

```elisp
dotspacemacs-default-font '("Fira Code"
                            :size 14.0
                            :weight semi-bold
                            :width semi-expanded)
```

### 4. Installing New Fonts

**macOS:**

```bash
# Using Homebrew
brew install --cask font-fira-code
brew install --cask font-jetbrains-mono
brew install --cask font-hack
brew install --cask font-source-code-pro

# Or download from:
# https://www.nerdfonts.com/
```

**After installing, restart Spacemacs.**

---

## Window & Frame Settings

### 1. Startup Size

**Maximize on startup:**

```elisp
dotspacemacs-maximized-at-startup t
```

**Fullscreen on startup:**

```elisp
dotspacemacs-fullscreen-at-startup t
```

**Custom size:**

```elisp
dotspacemacs-maximized-at-startup nil
dotspacemacs-fullscreen-at-startup nil

;; Then set in user-config:
(add-to-list 'default-frame-alist '(width . 120))
(add-to-list 'default-frame-alist '(height . 40))
```

### 2. Frame Title

**Customize what shows in title bar** (around line 502):

```elisp
;; Show file name
dotspacemacs-frame-title-format "%b"

;; Show file path
dotspacemacs-frame-title-format "%f"

;; Show project name
dotspacemacs-frame-title-format "%t"

;; Custom format
dotspacemacs-frame-title-format "Emacs - %b [%t]"
```

**Format codes:**

- `%b` - Buffer name
- `%f` - File path
- `%t` - Project name (projectile)
- `%I` - Invocation name (emacs)
- `%S` - System name

### 3. Fringe & Margins

**Add space on sides:**

```elisp
;; In dotspacemacs/user-config
(setq-default left-fringe-width 10)
(setq-default right-fringe-width 10)
```

---

## Mode Line Customization

### 1. Mode Line Theme

**Find this setting** (around line 225):

```elisp
dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)
```

**Available themes:**

```elisp
;; Spacemacs (default)
'(spacemacs :separator wave :separator-scale 1.5)

;; Doom mode-line (modern)
'(doom)

;; All-the-icons (with icons)
'(all-the-icons)

;; Vim powerline
'(vim-powerline)

;; Vanilla (simple)
'(vanilla)
```

**Separator styles:**

- `wave` - Wavy separator
- `arrow` - Arrow separator
- `bar` - Straight bar
- `nil` - No separator

### 2. Mode Line Position

**Bottom (default):**

```elisp
(setq mode-line-format ...)  ; Default
```

**Top (header line):**

```elisp
;; In dotspacemacs/user-config
(setq-default header-line-format mode-line-format)
(setq-default mode-line-format nil)
```

---

## Color & Transparency

### 1. Transparency

**Active window transparency** (around line 381):

```elisp
dotspacemacs-active-transparency 90    ; 0-100 (100 = opaque)
```

**Inactive window transparency:**

```elisp
dotspacemacs-inactive-transparency 90
```

**Background transparency:**

```elisp
dotspacemacs-background-transparency 90
```

**Toggle transparency interactively:**

```
SPC T T
```

### 2. Cursor Color

**Cursor matches state (default):**

```elisp
dotspacemacs-colorize-cursor-according-to-state t
```

**Custom cursor color:**

```elisp
;; In dotspacemacs/user-config
(set-cursor-color "#ff0000")  ; Red cursor
```

### 3. Highlight Current Line

**Enable:**

```elisp
;; In dotspacemacs/user-config
(global-hl-line-mode 1)
```

**Disable:**

```elisp
(global-hl-line-mode -1)
```

---

## Line Numbers & Visual Aids

### 1. Line Numbers

**Enable line numbers** (around line 431):

```elisp
;; Absolute line numbers
dotspacemacs-line-numbers t

;; Relative line numbers (Vim-style)
dotspacemacs-line-numbers 'relative

;; Visual line numbers
dotspacemacs-line-numbers 'visual

;; Disable
dotspacemacs-line-numbers nil
```

**Toggle interactively:**

```
SPC t n    (toggle line numbers)
SPC t r    (toggle relative)
```

### 2. Whitespace Visualization

**Show trailing whitespace:**

```elisp
dotspacemacs-show-trailing-whitespace t
```

**Show all whitespace:**

```
SPC t w    (toggle whitespace mode)
```

### 3. Fill Column Indicator

**Show column guide at 80 characters:**

```elisp
;; In dotspacemacs/user-config
(setq-default fill-column 80)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
```

**Toggle:**

```
SPC t f    (toggle fill column)
```

### 4. Indent Guides

**Show indentation guides:**

```elisp
;; Add to layers
dotspacemacs-configuration-layers
'(
  ...
  (colors :variables
          colors-enable-rainbow-identifiers t)
  ...
)
```

---

## Advanced Customization

### 1. Custom Color Overrides

**Override theme colors:**

```elisp
;; In dotspacemacs/user-config
(custom-set-faces
 '(font-lock-comment-face ((t (:foreground "#7F9F7F" :slant italic))))
 '(font-lock-string-face ((t (:foreground "#CC9393"))))
 '(region ((t (:background "#4F4F4F")))))
```

### 2. Smooth Scrolling

**Enable smooth scrolling:**

```elisp
dotspacemacs-smooth-scrolling t
```

**Adjust scroll margin:**

```elisp
;; In dotspacemacs/user-config
(setq scroll-margin 3)           ; Lines from top/bottom
(setq scroll-conservatively 101) ; Smooth scroll
```

### 3. Window Dividers

**Customize window borders:**

```elisp
;; In dotspacemacs/user-config
(setq window-divider-default-right-width 2)
(setq window-divider-default-bottom-width 2)
(window-divider-mode 1)
```

### 4. Beacon Mode (Cursor Flash)

**Flash cursor when scrolling:**

```elisp
;; Add to dotspacemacs-additional-packages
dotspacemacs-additional-packages '(beacon)

;; In dotspacemacs/user-config
(beacon-mode 1)
```

---

## 🎨 Example Configurations

### Configuration 1: Modern Dark Setup

```elisp
;; Themes
dotspacemacs-themes '(doom-one
                      doom-vibrant)

;; Font
dotspacemacs-default-font '("JetBrains Mono"
                            :size 14.0
                            :weight normal
                            :width normal)

;; Mode line
dotspacemacs-mode-line-theme '(doom)

;; Display
dotspacemacs-maximized-at-startup t
dotspacemacs-line-numbers 'relative
dotspacemacs-active-transparency 95

;; In user-config:
(global-hl-line-mode 1)
(beacon-mode 1)
```

### Configuration 2: Clean Light Setup

```elisp
;; Themes
dotspacemacs-themes '(spacemacs-light
                      leuven)

;; Font
dotspacemacs-default-font '("Menlo"
                            :size 13.0
                            :weight normal
                            :width normal)

;; Mode line
dotspacemacs-mode-line-theme '(spacemacs :separator wave)

;; Display
dotspacemacs-maximized-at-startup t
dotspacemacs-line-numbers t
dotspacemacs-show-trailing-whitespace t
```

### Configuration 3: Presentation Mode

```elisp
;; Large, clear fonts for demos
dotspacemacs-default-font '("Fira Code"
                            :size 20.0
                            :weight semi-bold
                            :width normal)

dotspacemacs-themes '(doom-one)
dotspacemacs-fullscreen-at-startup t
dotspacemacs-line-numbers nil
```

---

## 🔧 Troubleshooting

### Font Not Showing

**Check if font is installed:**

```elisp
;; In Emacs, evaluate:
(font-family-list)
```

**Install font and restart Spacemacs.**

### Theme Not Loading

**Ensure theme package is installed:**

```elisp
;; Add to dotspacemacs-additional-packages
dotspacemacs-additional-packages '(doom-themes)
```

**Reload:** `SPC f e R`

### Changes Not Taking Effect

1. Save config: `SPC f s`
2. Reload: `SPC f e R`
3. If still not working: `SPC q R` (restart)

---

## 📚 Next Steps

**After customizing appearance:**

1. ✅ [Modal Editing Basics](./01-modal-editing-basics.md)
2. ✅ [File Navigation](./02-file-navigation.md)
3. → [R Development Workflow](./03-r-development.md)

**Resources:**

- [Spacemacs Themes Gallery](https://themegallery.robdor.com/)
- [Programming Fonts](https://www.programmingfonts.org/)
- [Nerd Fonts](https://www.nerdfonts.com/)

---

**Pro Tip:** Start with small changes! Try one theme, one font, then gradually customize other settings. Save your favorite configurations in comments for easy switching.
