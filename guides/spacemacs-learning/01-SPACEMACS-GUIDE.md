# Spacemacs Keybindings Guide

**A comprehensive introduction to Spacemacs for spacemacs-rstats users**

---

## 🎯 What is Spacemacs?

**Spacemacs** is a community-driven Emacs distribution that combines:

- **Vim's modal editing** (Evil mode)
- **Emacs' extensibility**
- **A discoverable, mnemonic keybinding system**

**Key Philosophy:** "The best editor is neither Emacs nor Vim, it's Emacs *and* Vim!"

---

## 🔑 The SPC Leader Key Philosophy

### Why the Spacebar?

1. **Most accessible key** on the keyboard (thumb press)
2. **Reduces RSI risk** compared to Ctrl/Meta combinations
3. **Only relevant in Normal mode** (doesn't interfere with typing)
4. **Mnemonic organization** - easy to remember

### How It Works

```
SPC → Opens command menu
└─ f → File operations
   ├─ f → Find file
   ├─ s → Save file
   └─ r → Recent files
└─ b → Buffer operations
   ├─ b → Switch buffer
   └─ k → Kill buffer
└─ p → Project operations
└─ s → Search
└─ h → Help
```

---

## 📋 Core Spacemacs Keybindings

### Leader Key Prefixes (Mnemonic)

| Prefix | Category | Example Commands |
|--------|----------|------------------|
| `SPC f` | **F**iles | `SPC f f` (find file), `SPC f s` (save) |
| `SPC b` | **B**uffers | `SPC b b` (switch), `SPC b k` (kill) |
| `SPC p` | **P**rojects | `SPC p f` (find file in project) |
| `SPC s` | **S**earch | `SPC s s` (search in file) |
| `SPC h` | **H**elp | `SPC h d k` (describe key) |
| `SPC w` | **W**indows | `SPC w /` (split vertically) |
| `SPC g` | **G**it | `SPC g s` (Magit status) |
| `SPC m` | **M**ajor mode | Mode-specific commands |
| `,` | Major mode | Alternative to `SPC m` |

### Essential Commands

#### Files

- `SPC f f` - Find file
- `SPC f s` - Save file
- `SPC f r` - Recent files
- `SPC f t` - Toggle file tree (NeoTree)

#### Buffers

- `SPC b b` - Switch buffer
- `SPC b k` - Kill buffer
- `SPC TAB` - Previous buffer
- `SPC b d` - Kill other buffers

#### Windows (Frames)

- `SPC w /` - Split vertically
- `SPC w -` - Split horizontally
- `SPC w d` - Delete window
- `SPC w m` - Maximize window

#### Projects (Projectile)

- `SPC p f` - Find file in project
- `SPC p p` - Switch project
- `SPC p s` - Search in project
- `SPC p t` - Toggle between implementation and test

#### Search

- `SPC s s` - Search in buffer
- `SPC s p` - Search in project
- `/` - Search forward (in Normal mode)

#### Git (Magit)

- `SPC g s` - Magit status
- `SPC g b` - Blame
- `SPC g d` - Diff

---

## 🔀 Spacemacs vs Vanilla Emacs

### Keybinding Philosophy Comparison

| Aspect | Vanilla Emacs | Spacemacs |
|--------|---------------|-----------|
| **Primary modifier** | `C-` (Control), `M-` (Meta) | `SPC` (Spacebar) |
| **Organization** | Prefix-based (`C-x`, `C-c`) | Mnemonic categories |
| **Discoverability** | Limited | Which-key (automatic) |
| **Learning curve** | Steep | Guided |
| **Typing** | Always enabled | Modal (Normal vs Insert) |

### Common Tasks Comparison

| Task | Vanilla Emacs | Spacemacs |
|------|---------------|-----------|
| Find file | `C-x C-f` | `SPC f f` |
| Save file | `C-x C-s` | `SPC f s` |
| Switch buffer | `C-x b` | `SPC b b` |
| Search | `C-s` | `/` or `SPC s s` |
| Help | `C-h k` | `SPC h d k` |
| Execute command | `M-x` | `SPC SPC` |
| Git status | `C-x g` | `SPC g s` |

---

## 🎨 Modal Editing (Evil Mode)

Spacemacs uses **Evil mode** (Vim emulation) with modes:

### Normal Mode (Default)

- **Navigation** without modifiers
- **h/j/k/l** - left/down/up/right
- **w/b** - word forward/backward
- **0/$** - beginning/end of line
- **gg/G** - top/bottom of buffer

### Insert Mode

- Press `i` to enter from Normal mode
- Type normally
- Press `ESC` or `fd` to return to Normal

### Visual Mode

- Press `v` to enter (character selection)
- Press `V` for line selection
- Press `C-v` for block selection

### Command Mode

- Press `:` to enter
- `:w` - save
- `:q` - quit
- `:wq` - save and quit

---

## 🔬 Spacemacs for R Development

### Potential R-Specific Bindings

If you adopted Spacemacs, you'd likely use:

#### ESS Layer Bindings

```
SPC m s     → Start R REPL
SPC m e e   → Eval region or function
SPC m e l   → Eval line
SPC m e b   → Eval buffer
SPC m h h   → R help
,           → Major mode prefix (alternative to SPC m)
```

#### Your Custom R Development

```
SPC m r r   → Roxygen skeleton (could map your function)
SPC m u r   → usethis use_r
SPC m u t   → usethis use_test
SPC m s c   → S7 class skeleton
SPC m s m   → S7 method skeleton
```

---

## 🍎 Spacemacs on macOS

### macOS Modifier Configuration

Spacemacs has an `osx` layer for macOS integration:

```elisp
(osx :variables
     osx-command-as 'super      ; Command → Super (s-)
     osx-option-as 'meta        ; Option → Meta (M-)
     osx-right-option-as 'none) ; Right Option for symbols
```

### Mac-like Shortcuts (with osx layer)

- `Cmd-=` - Increase font size
- `Cmd--` - Decrease font size
- `Cmd-0` - Reset font size
- `Cmd-v` - Paste
- `Cmd-c` - Copy
- `Cmd-x` - Cut
- `Cmd-q` - Quit

---

## 🚀 Advantages of Spacemacs

### ✅ Pros

1. **Discoverability** - Which-key shows all options
2. **Consistency** - Same pattern across all modes
3. **Mnemonic** - Easy to remember (`f` = file, `b` = buffer)
4. **Modal editing** - Efficient for navigation and text manipulation
5. **Community layers** - Pre-configured for languages (including R/ESS)
6. **Reduced RSI** - Less Ctrl/Meta strain

### ⚠️ Cons

1. **Learning curve** - Need to learn Vim keybindings
2. **Heavier** - More packages = longer startup
3. **Different paradigm** - May conflict with your muscle memory
4. **Complexity** - More layers of abstraction

---

## 🔄 Could You Adopt Spacemacs?

### Migration Path

**Option 1: Full Spacemacs**

```bash
# Backup current config
mv ~/.emacs.d ~/.emacs.d.backup

# Install Spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d -b develop

# First launch will ask:
# - Evil or Emacs style? → Choose Evil
# - Which layers? → Choose ess, git, osx
```

**Option 2: Spacemacs-lite (General.el + which-key)**
Keep your current setup, add Space leader:

```elisp
(use-package general
  :config
  (general-create-definer space-leader
    :states '(normal visual insert emacs)
    :prefix "SPC"
    :non-normal-prefix "M-SPC"))

(space-leader
  "f f" 'find-file
  "f s" 'save-buffer
  "b b" 'switch-to-buffer)
```

---

## 💡 Recommendation for You

### Should You Switch?

**Consider Spacemacs if:**

- ✅ You're comfortable learning modal editing
- ✅ You want better discoverability
- ✅ You like community-driven configurations
- ✅ You're starting fresh with Emacs

**Stick with current setup if:**

- ✅ You're productive with current keybindings
- ✅ You don't want to learn Vim keybindings
- ✅ You prefer lighter, custom configuration
- ✅ You have muscle memory for `C-` and `M-` bindings

### Middle Ground: Add Space Leader

You can add a Space leader key to your *current* config:

```elisp
;; Add to your init.el
(use-package which-key
  :config
  (which-key-mode))

;; Define space as leader (requires Evil mode or general.el)
;; This gives you Spacemacs-style discovery without full Spacemacs
```

---

## 📚 Learning Resources

- **Official docs:** [spacemacs.org](https://www.spacemacs.org)
- **Cheat sheet:** [spacemacs.org/doc/DOCUMENTATION.html#keybindings](https://www.spacemacs.org/doc/DOCUMENTATION.html#keybindings)
- **Video tutorial:** Search "Spacemacs tutorial" on YouTube
- **Community:** Reddit r/spacemacs

---

## ✅ Next Steps

**To explore Spacemacs:**

1. Try it in a VM or container first
2. Keep your current config as backup
3. Commit to 1 week of learning (muscle memory adjustment)
4. Start with basic navigation (h/j/k/l)
5. Learn one `SPC` prefix per day

**Or enhance current setup:**

1. Add which-key for better discovery
2. Create mnemonic prefixes (`C-c f` for files, `C-c b` for buffers)
3. Add hydra menus for complex workflows
4. Consider evil-mode *without* full Spacemacs
