# Spacemacs Reference Guide

This guide compiles essential information for configuring and using Spacemacs, specifically tailored for an R developer migrating from a vanilla Emacs setup.

## 1. Configuration Philosophy

Spacemacs uses a modular configuration system based on **layers**.

- **Config File:** `~/.spacemacs` (Open with `SPC f e d`)
- **Reload Config:** `SPC f e R`

### Key Functions in `.spacemacs`

1.  **`dotspacemacs/layers`**:
    *   Where you enable/disable layers.
    *   Example: adding `ess`, `git`, `org`.
2.  **`dotspacemacs/user-init`**:
    *   Runs *before* layers are loaded. Use for variables that must be set early.
3.  **`dotspacemacs/user-config`**:
    *   Runs *after* layers are loaded.
    *   Place your custom keybindings (`define-key`), package configurations (`use-package`), and hook setups here.

### Best Practices
*   **Use Layers:** Don't just dump code in `user-config`. If a feature exists as a layer, use it.
*   **Private Layers:** for complex personal configurations, create a private layer in `~/.emacs.d/private/`.
*   **`use-package`:** Use `use-package` for any additional packages you install, to ensure lazy loading and clean configuration.

---

## 2. Keybindings & The Leader Key System

Spacemacs is famous for its mnemonic leader key system.

- **Leader Key:** `SPC` (Spacebar)
- **Major Mode Leader:** `,` (Comma) - equivalent to `SPC m`

### Essential Navigation (Vim Style)

| Key | Action |
| :--- | :--- |
| `h` `j` `k` `l` | Left, Down, Up, Right |
| `w` / `b` | Forward/Backward word |
| `0` / `$` | Start/End of line |
| `gg` / `G` | Start/End of buffer |
| `/` | Search in buffer |
| `v` | Visual mode (selection) |
| `y` | Yank (copy) |
| `p` | Paste |
| `u` | Undo |
| `C-r` | Redo |

### Essential Leader Commands (`SPC`)

| Prefix | Category | Examples |
| :--- | :--- | :--- |
| `SPC f` | **F**iles | `f f` (find file), `f s` (save), `f r` (recent) |
| `SPC b` | **B**uffers | `b b` (switch buffer), `b d` (kill buffer) |
| `SPC w` | **W**indows | `w /` (split vertical), `w -` (split horizontal), `w d` (delete) |
| `SPC p` | **P**rojects | `p f` (find file in project), `p p` (switch project) |
| `SPC g` | **G**it | `g s` (Magit status) |
| `SPC s` | **S**earch | `s p` (search in project - grep/ag/rg) |
| `SPC h` | **H**elp | `h d k` (describe key), `h d f` (describe function) |
| `SPC SPC` | M-x | Execute any command |

---

## 3. R Development (ESS Layer)

The `ess` layer provides a powerful environment for R.

### Configuration (`.spacemacs`)

Add `ess` to `dotspacemacs-configuration-layers`:

```elisp
(ess :variables
     ess-r-backend 'lsp  ; Enable LSP for advanced features
     ess-use-flymake nil ; Disable flymake in favor of flycheck
     )
```

**Prerequisites:**
*   Install `lintr` in R: `install.packages("lintr")`
*   Install `languageserver` in R: `install.packages("languageserver")`

### Keybindings (`SPC m` or `,`)

| Key | Action |
| :--- | :--- |
| `, '` | Start/Switch to R REPL |
| `, s s` | Switch between script and REPL |
| `, b` | Send buffer to REPL |
| `, f` | Send function to REPL |
| `, l` | Send line to REPL |
| `, r` | Send region to REPL |
| `, h a` | Help apropos |
| `, E /` | Set working directory |

---

## 4. Essential Productivity Layers

Add these to your `dotspacemacs-configuration-layers` list:

1.  **`git`**:
    *   Brings `magit` to the forefront.
    *   `SPC g s` for status is a daily driver.
2.  **`org`**:
    *   The ultimate note-taking and planning tool.
    *   `SPC o c` for capture, `SPC o a` for agenda.
3.  **`projectile`**:
    *   Project management. Spacemacs installs this by default, but learn `SPC p` bindings.
4.  **`lsp`**:
    *   Language Server Protocol. Essential for modern code intelligence (completion, definitions, errors) in R, Python, etc.
5.  **`markdown`**:
    *   For editing READMEs and docs.
6.  **`yaml`**:
    *   For `_quarto.yml` and config files.

---

## 5. Migration Tips for Vanilla Users

1.  **Don't fight Evil (Vim) mode:** Give it 2 weeks. The efficiency gains are real.
2.  **Use `SPC ?`:** If you forget a keybinding, search for it.
3.  **Which-Key is your friend:** Press `SPC` and wait. A menu will appear showing valid next keys.
4.  **Porting Config:**
    *   Move your custom functions to `dotspacemacs/user-config`.
    *   Wrap them in `(with-eval-after-load 'package ...)` blocks if they depend on specific packages.
