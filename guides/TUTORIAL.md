# emacs-r-devkit Tutorial

A beginner-friendly guide to using emacs-r-devkit for R package development.

## About This Tutorial

This tutorial focuses on **Emacs-specific features** for R development. For your complete workflow:
- **R package aliases** (`rtest`, `rdoc`, `rpkg`, etc.) → See your `r-package-development` Claude skill
- **Shell environment** (`z`, git aliases, modern tools) → See your `zsh-environment` Claude skill
- **Emacs keybindings** → This tutorial

## Table of Contents

1. [Getting Started](#getting-started)
2. [Basic Emacs Navigation](#basic-emacs-navigation)
3. [Keybindings Reference](#keybindings-reference)
4. [Common Workflows](#common-workflows)
5. [R Package Development Workflow](#r-package-development-workflow)
6. [Tips & Tricks](#tips--tricks)

---

## Getting Started

### Launching Emacs

**macOS:**
```bash
# GUI mode (recommended)
open -a Emacs

# Terminal mode
emacs

# With specific file
open -a Emacs test.R
```

**First Launch:**
- Takes 10-15 minutes (package installation & compilation)
- You'll see compilation messages (normal!)
- Wait for: `emacs-r-devkit loaded! [macOS GUI | 30.2] Key prefix: C-c r`

### Understanding Emacs Notation (macOS)

**Key Modifiers:**
- `C-` = Control key
- `M-` = **Option (⌥)** key on macOS
- `S-` = Command (⌘) key (rarely used)
- `Shift` = Shift key

**Examples:**
- `C-x` = Hold Control, press x
- `M-x` = Hold **Option**, press x
- `C-x C-f` = Hold Control, press x, then f (keep holding Control)
- `M-f` = Hold **Option**, press f (move forward one word)
- `RET` = Return/Enter key
- `SPC` = Spacebar

**Important:** Throughout this tutorial, **M- always means Option (⌥)**, not Command!

### Your First Steps

1. **Open a file:** `C-x C-f` (Control-x Control-f) then type filename
2. **Save a file:** `C-x C-s` (Control-x Control-s)
3. **Exit Emacs:** `C-x C-c` (Control-x Control-c)
4. **Cancel command:** `C-g` (Control-g) - **use this if you get stuck!**

### Practice These First!

Before doing anything else, practice these movements:
```
C-a     (Control-a) → Go to beginning of line
C-e     (Control-e) → Go to end of line
M-f     (Option-f)  → Move forward one word
M-b     (Option-b)  → Move backward one word
C-g     (Control-g) → Cancel/escape (VERY IMPORTANT!)
```

---

## Basic Emacs Navigation

### Essential Movement

| Action | Keybinding | Alternative |
|--------|------------|-------------|
| Move forward | `C-f` | Right arrow |
| Move backward | `C-b` | Left arrow |
| Move up | `C-p` | Up arrow |
| Move down | `C-n` | Down arrow |
| Beginning of line | `C-a` | Cmd-Left |
| End of line | `C-e` | Cmd-Right |
| Next word | `M-f` | - |
| Previous word | `M-b` | - |
| Page up | `M-v` | Page Up |
| Beginning of buffer | `M-<` | Cmd-Up |
| End of buffer | `M->` | Cmd-Down |
| Go to line | `M-g g` | - |

### Editing

| Action | Keybinding |
|--------|------------|
| Delete character | `C-d` |
| Delete word | `M-d` |
| Kill region | `C-w` |
| Copy region | `M-w` |
| Yank (paste) | `C-y` |
| Undo | `C-/` or `C-_` |
| Mark (select) | `C-SPC` |

### Files & Buffers

| Action | Keybinding |
|--------|------------|
| Open file | `C-x C-f` |
| Save file | `C-x C-s` |
| Save as | `C-x C-w` |
| Close buffer | `C-x k` |
| Switch buffer | `C-x b` |
| List buffers | `C-x C-b` |
| Split window horizontal | `C-x 2` |
| Split window vertical | `C-x 3` |
| Close other windows | `C-x 1` |
| Switch window | `C-x o` |

### Search & Replace

| Action | Keybinding |
|--------|------------|
| Search | `C-s` (then type, press `C-s` again for next) |
| Search backward | `C-r` |
| Replace | `M-%` |
| Cancel search | `C-g` |

### Help System

| Action | Keybinding |
|--------|------------|
| Describe function | `C-h f` |
| Describe variable | `C-h v` |
| Describe key | `C-h k` |
| Show messages | `C-h e` |
| General help | `C-h ?` |

---

## Keybindings Reference

### emacs-r-devkit Commands (Prefix: `C-c r`)

**Quick Reference:** Press `C-c r` and wait - which-key will show all available commands!

#### Documentation & Templates

| Command | Keybinding | Description |
|---------|------------|-------------|
| Insert roxygen skeleton | `C-c r r` | Insert roxygen2 documentation template |
| Insert S7 class | `C-c r s c` | Insert S7 class skeleton |
| Insert S7 method | `C-c r s m` | Insert S7 method skeleton |
| Insert S7 generic | `C-c r s g` | Insert S7 generic function skeleton |

#### Usethis Integration

| Command | Keybinding | Description |
|---------|------------|-------------|
| Create R file | `C-c r u` | Run usethis::use_r() and open file |
| Create test file | `C-c r t` | Run usethis::use_test() and open file |
| Create package doc | `C-c r p` | Run usethis::use_package_doc() |

#### Tools

| Command | Keybinding | Description |
|---------|------------|-------------|
| Toggle styler | `C-c r S` | Enable/disable auto-formatting on save |
| Export GUI PATH | `C-c r P` | Export PATH to launchctl (macOS only) |

### LSP Mode (Prefix: `C-c l`)

| Command | Keybinding | Description |
|---------|------------|-------------|
| Go to definition | `M-.` | Jump to function/variable definition |
| Find references | `M-?` | Show all references to symbol |
| Rename symbol | `C-c l r r` | Rename symbol across project |
| Show hover info | Hover mouse | Show documentation (GUI mode) |
| Execute code action | `C-c l a a` | Show available code actions |

### Flycheck (Syntax Checking)

| Command | Keybinding | Description |
|---------|------------|-------------|
| List errors | `C-c ! l` | Show all syntax errors/warnings |
| Next error | `C-c ! n` | Jump to next error |
| Previous error | `C-c ! p` | Jump to previous error |
| Verify setup | `M-x flycheck-verify-setup` | Check Flycheck configuration |
| Describe checker | `C-c ! ?` | Show info about current checker |

### Company Mode (Completion)

| Command | Keybinding | Description |
|---------|------------|-------------|
| Complete | `TAB` | Accept completion |
| Next candidate | `C-n` | Move to next suggestion |
| Previous candidate | `C-p` | Move to previous suggestion |
| Show help | `C-h` | Show documentation for candidate |
| Search candidates | `C-s` | Filter completions |

### ESS (R Mode)

| Command | Keybinding | Description |
|---------|------------|-------------|
| Start R | `M-x R` | Launch R console |
| Send line | `C-RET` | Send current line to R |
| Send region | `C-RET` | Send selected region to R |
| Send function | `C-c C-c` | Send current function to R |
| Send buffer | `C-c C-b` | Send entire buffer to R |
| Load file | `C-c C-l` | Source current file in R |
| Switch to R | `C-c C-z` | Switch to R console buffer |

### Magit (Git)

| Command | Keybinding | Description |
|---------|------------|-------------|
| Status | `C-x g` | Open Magit status |
| Stage | `s` | Stage file (in Magit) |
| Unstage | `u` | Unstage file (in Magit) |
| Commit | `c c` | Create commit (in Magit) |
| Push | `P p` | Push to remote (in Magit) |
| Pull | `F p` | Pull from remote (in Magit) |

### Projectile

| Command | Keybinding | Description |
|---------|------------|-------------|
| Find file in project | `C-c p f` | Quickly find project file |
| Switch project | `C-c p p` | Switch to another project |
| Search in project | `C-c p s s` | Search across project |
| Run project tests | `C-c p P` | Run project test suite |

---

## Common Workflows

### Workflow 1: Create and Document an R Function

1. **Open or create an R file:**
   ```
   C-x C-f my-function.R RET
   ```

2. **Write your function:**
   ```r
   calculate_mean <- function(x, na.rm = FALSE) {
     mean(x, na.rm = na.rm)
   }
   ```

3. **Add roxygen documentation:**
   - Place cursor on line **above** the function
   - Press `C-c r r`
   - Fill in the template

4. **Save and auto-format:**
   - Press `C-x C-s`
   - Styler will automatically format your code

5. **Check for issues:**
   - Press `C-c ! l` to see Flycheck warnings

### Workflow 2: Start a New R Package

1. **Create package structure** (in terminal):
   ```bash
   R -e "usethis::create_package('~/mypackage')"
   cd ~/mypackage
   ```

2. **Open in Emacs:**
   ```bash
   open -a Emacs .
   ```

3. **Create a new R file:**
   - Press `C-c r u`
   - Enter name: `helper-functions`
   - File opens automatically

4. **Create a test file:**
   - Press `C-c r t`
   - Enter name: `helper-functions`
   - Test file opens automatically

### Workflow 3: Write and Test S7 Classes

1. **Create new R file for S7 classes:**
   ```
   C-c r u RET s7-classes RET
   ```

2. **Insert S7 class skeleton:**
   - Press `C-c r s c`
   - Enter class name: `Person`
   - Edit the skeleton

3. **Create a generic function:**
   - Press `C-c r s g`
   - Enter generic name: `greet`

4. **Create a method:**
   - Press `C-c r s m`
   - Enter generic name: `greet`
   - Enter class name: `Person`

5. **Test your code:**
   - Select region with code: `C-SPC`, move cursor
   - Send to R: `C-RET`

### Workflow 4: Fix Styling Issues

1. **Open file with style issues**

2. **Check what needs fixing:**
   - Look for Flycheck warnings (underlines)
   - Press `C-c ! l` to list all issues

3. **Option A - Auto-fix:**
   - Save file: `C-x C-s`
   - Styler will fix most issues

4. **Option B - Manual fix:**
   - Disable auto-styler: `C-c r S`
   - Fix issues manually
   - Re-enable: `C-c r S`

### Workflow 5: Navigate and Edit with LSP

1. **Jump to function definition:**
   - Place cursor on function name
   - Press `M-.`
   - Press `M-,` to jump back

2. **Find all uses of a function:**
   - Place cursor on function name
   - Press `M-?`
   - Navigate with `n` (next) and `p` (previous)

3. **Rename a function everywhere:**
   - Place cursor on function name
   - Press `C-c l r r`
   - Enter new name
   - All references update

---

## R Package Development Workflow

**Note**: This section integrates Emacs with your existing terminal workflow. For complete R package aliases (`rtest`, `rdoc`, `rpkg`, etc.), see your `r-package-development` Claude skill.

### Complete Package Development Cycle

**Create Package** (Terminal):
```bash
rnewpkg mypackage              # Creates in ~/R-packages/
mv ~/R-packages/mypackage ~/R-packages/active/  # Move to active tier
cd ~/R-packages/active/mypackage
```

**Add Functions** (Emacs + Terminal):
```
Emacs:
  C-c r u                      → Create R file
  Write function
  C-c r r                      → Add roxygen
  C-x C-s                      → Save (auto-formats)

Terminal:
  rdoc                         → Generate documentation
  rtest                        → Run tests
```

**Add Tests** (Emacs + Terminal):
```
Emacs:
  C-c r t                      → Create test file
  Write tests
  C-x C-s                      → Save

Terminal:
  rtest                        → Run all tests
```

**Validate** (Terminal):
```bash
rdev                           # Full cycle: doc → test → check
# Or step-by-step:
rdoc                           # Document
rtest                          # Test
rcheck                         # R CMD check
```

**Commit** (Terminal):
```bash
rpkgcommit "Add new feature"   # Doc → test → style → commit
git push
```

### Daily Development Workflow

**Morning** (Terminal):
```bash
z rmediation                   # Jump to active package
git pull                       # Update from remote
rpkg                           # Check package status
```

**During Development** (Emacs):
```
C-x C-f R/myfile.R             → Open file
Write code...
C-c r r                        → Add documentation
C-x C-s                        → Save (auto-formats)
C-c ! l                        → Check for issues
C-RET                          → Test in R console
M-.                            → Navigate to definitions
```

**Validate** (Terminal):
```bash
rtest                          # Run tests
rdev                           # Full validation cycle
```

**End of Day** (Terminal):
```bash
rpkgcommit "Descriptive message"  # Validated commit
git push
```

### Integration: Emacs ↔ Terminal

**Best Practice**: Use both together

- **Emacs for**: Writing, navigating, real-time feedback (Flycheck, LSP)
- **Terminal for**: Testing, validation (`rtest`, `rdev`, `rcheck`)

**Example Full Cycle**:
```
1. Terminal: z rmediation
2. Emacs: C-x C-f R/newfunction.R
3. Emacs: Write function, C-c r r (roxygen), C-x C-s
4. Terminal: rdoc
5. Terminal: rnewtest newfunction
6. Emacs: Write tests
7. Terminal: rtest
8. Terminal: rdev
9. Terminal: rpkgcommit "Add newfunction"
```

---

## Tips & Tricks

### Productivity Tips

1. **Learn the Which-Key shortcuts:**
   - Press `C-c r` and wait
   - See all available R-devkit commands

2. **Use Projectile for navigation:**
   - `C-c p f` finds any file in your project instantly
   - Much faster than browsing directories

3. **Let Flycheck guide you:**
   - Don't guess what's wrong
   - `C-c ! l` shows exactly what needs fixing

4. **Use completion everywhere:**
   - Start typing and wait
   - Company will suggest functions, variables, packages

5. **Keep R console open:**
   - Split window: `C-x 2`
   - Top: edit code, Bottom: R console
   - Quick feedback loop

### Customization Tips

**Adjust styler aggressiveness:**
```elisp
;; Add to ~/.emacs.d/init.el or create ~/.Rprofile
# .Rprofile
options(styler.cache_root = NULL)  # Disable caching
```

**Change keybindings:**
```elisp
;; Add to ~/.emacs.d/init.el
(global-set-key (kbd "C-c d") 'emacs-r-devkit/insert-roxygen-skeleton)
```

**Disable auto-styling for specific projects:**
```elisp
;; Create .dir-locals.el in project root
((ess-r-mode . ((emacs-r-devkit/styler-enabled . nil))))
```

### Troubleshooting Common Issues

**Problem: Flycheck not working**
```
Solution: M-x flycheck-verify-setup
Check that lintr and styler are installed
```

**Problem: LSP not starting**
```
Solution: Check languageserver is installed
R: install.packages("languageserver")
Restart Emacs
```

**Problem: Styler errors on save**
```
Solution: Toggle styler off temporarily
C-c r S (toggle)
Fix syntax errors first
C-c r S (toggle back on)
```

**Problem: Company not showing completions**
```
Solution: Check company is active
M-x company-mode (toggle)
Or wait a bit longer (0.1s delay)
```

---

## Quick Reference Card (macOS)

**REMEMBER:** `M-` = **Option (⌥)** | `C-` = Control | `S-` = Command (⌘)

### Most Important Keybindings

```
┌───────────────────────────────────────────────────┐
│ ESSENTIAL EMACS (macOS)                           │
├───────────────────────────────────────────────────┤
│ C-x C-f         Open file                         │
│ C-x C-s         Save file                         │
│ C-x C-c         Exit Emacs                        │
│ C-g             Cancel command (IMPORTANT!)       │
│                                                   │
│ MOVEMENT                                          │
│ C-a / C-e       Start/End of line                 │
│ M-f / M-b       Forward/Back word (Option-f/b)    │
│ C-n / C-p       Next/Previous line                │
│ M-< / M->       Start/End of buffer (Option-</>) │
├───────────────────────────────────────────────────┤
│ EDITING                                           │
│ C-SPC           Mark/Select                       │
│ M-w             Copy (Option-w)                   │
│ C-w             Cut                               │
│ C-y             Paste                             │
│ C-/             Undo                              │
├───────────────────────────────────────────────────┤
│ R DEVELOPMENT (Prefix: C-c r)                     │
├───────────────────────────────────────────────────┤
│ C-c r r         Insert roxygen                    │
│ C-c r u         Create R file (use_r)             │
│ C-c r t         Create test (use_test)            │
│ C-c r s c       Insert S7 class                   │
│ C-c r S         Toggle styler                     │
├───────────────────────────────────────────────────┤
│ CODE NAVIGATION                                   │
├───────────────────────────────────────────────────┤
│ M-.             Go to definition (Option-.)       │
│ M-,             Go back (Option-,)                │
│ C-c ! l         List errors                       │
│ C-c ! n         Next error                        │
├───────────────────────────────────────────────────┤
│ ESS (R)                                           │
├───────────────────────────────────────────────────┤
│ M-x R           Start R (Option-x, type R)        │
│ C-RET           Send line/region to R             │
│ C-c C-z         Switch to R console               │
├───────────────────────────────────────────────────┤
│ GIT (MAGIT)                                       │
├───────────────────────────────────────────────────┤
│ C-x g           Git status                        │
└───────────────────────────────────────────────────┘
```

**Print this and keep it visible while learning!**

### Most Common Mistakes

1. **Using Command instead of Option** - Remember: `M-` = Option (⌥), not Command!
2. **Forgetting C-g** - If stuck, always try `C-g` (Control-g) to cancel
3. **Not holding Control** - For `C-x C-f`, keep holding Control for both keys

---

## Next Steps

1. **Practice basic Emacs navigation** - spend 30 minutes just moving around
2. **Work through test-features.R** - try each feature
3. **Create a small test package** - apply what you learned
4. **Customize to your needs** - adjust keybindings, settings
5. **Read USAGE.md** - for deeper technical details

---

## Additional Resources

- **Emacs Manual:** `C-h r` (in Emacs)
- **ESS Manual:** https://ess.r-project.org/Manual/ess.html
- **Flycheck:** https://www.flycheck.org/
- **LSP Mode:** https://emacs-lsp.github.io/lsp-mode/
- **Magit:** https://magit.vc/

---

**Happy R package development! 🎉**
