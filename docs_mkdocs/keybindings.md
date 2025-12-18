# Keybindings Reference

Complete Spacemacs keybinding guide for R development on macOS.

## Understanding Spacemacs Keybindings

**Spacemacs uses a mnemonic, discoverable keybinding system:**

- **Leader key** (`SPC`) - Primary entry point for all commands
- **Major mode leader** (`,`) - Mode-specific commands (equivalent to `SPC m`)
- **Which-key** - Press any prefix and wait - a menu appears showing available commands

!!! tip "Discovery is Built-in"
    Press `SPC` and wait 1 second - which-key shows all available commands!

    Press `,` in an R file to see all R-specific commands!

## Modal Editing

Spacemacs uses **Vim-style modal editing**:

| Mode | Indicator | Purpose | How to Enter |
|------|-----------|---------|--------------|
| **Normal** | `<N>` | Navigate and manipulate text | Default mode, press `ESC` or `fd` |
| **Insert** | `<I>` | Type text | Press `i`, `a`, `o`, etc. |
| **Visual** | `<V>` | Select text | Press `v`, `V`, or `C-v` |

!!! warning "Stuck in Insert Mode?"
    Press `ESC` or type `fd` quickly to return to Normal mode!

## Survival Keys (Learn First!)

### Emergency Exit

| Key | Action | Description |
|-----|--------|-------------|
| `ESC` or `fd` | Exit mode | Return to Normal mode |
| `SPC q q` | Quit | Exit Spacemacs |
| `SPC q s` | Save and quit | Save all and exit |
| `u` (Normal mode) | Undo | Undo last change |

### Essential File Operations

| Key | Action | Description |
|-----|--------|-------------|
| `SPC f f` | Find file | Open file with fuzzy search |
| `SPC f s` | Save file | Save current buffer |
| `SPC f r` | Recent files | Open recent files |
| `SPC f R` | Rename file | Rename current file |

### Essential Buffer Operations

| Key | Action | Description |
|-----|--------|-------------|
| `SPC b b` | Switch buffer | Switch to another buffer |
| `SPC b d` | Delete buffer | Close current buffer |
| `SPC b l` | List buffers | Show all buffers |
| `SPC TAB` | Last buffer | Switch to previous buffer |

## Movement (Normal Mode)

### Basic Movement

| Key | Action |
|-----|--------|
| `h` | Left |
| `j` | Down |
| `k` | Up |
| `l` | Right |
| `0` | Beginning of line |
| `$` | End of line |
| `gg` | Beginning of buffer |
| `G` | End of buffer |

### Word Movement

| Key | Action |
|-----|--------|
| `w` | Forward word |
| `b` | Backward word |
| `e` | End of word |

### Page Movement

| Key | Action |
|-----|--------|
| `C-f` | Page down |
| `C-b` | Page up |
| `SPC j l` | Jump to line |

## Editing (Normal Mode)

### Text Manipulation

| Key | Action | Description |
|-----|--------|-------------|
| `i` | Insert | Enter Insert mode before cursor |
| `a` | Append | Enter Insert mode after cursor |
| `o` | Open below | New line below and Insert mode |
| `O` | Open above | New line above and Insert mode |
| `d d` | Delete line | Cut current line |
| `d w` | Delete word | Cut word forward |
| `y y` | Yank line | Copy current line |
| `y w` | Yank word | Copy word |
| `p` | Paste after | Paste after cursor |
| `P` | Paste before | Paste before cursor |
| `c w` | Change word | Delete word and enter Insert mode |
| `c c` | Change line | Delete line and enter Insert mode |

### Visual Mode Selection

| Key | Action |
|-----|--------|
| `v` | Visual character | Select by character |
| `V` | Visual line | Select by line |
| `C-v` | Visual block | Select rectangular block |

## Spacemacs Leader Key (`SPC`)

### File Operations

| Key | Action | Description |
|-----|--------|-------------|
| `SPC f f` | Find file | Open file |
| `SPC f s` | Save file | Save current file |
| `SPC f S` | Save all | Save all buffers |
| `SPC f r` | Recent files | Open recent files |
| `SPC f R` | Rename | Rename current file |
| `SPC f D` | Delete | Delete current file |
| `SPC f y` | Yank path | Copy file path |

### Buffer Management

| Key | Action | Description |
|-----|--------|-------------|
| `SPC b b` | Switch buffer | Fuzzy buffer search |
| `SPC b d` | Delete buffer | Close current buffer |
| `SPC b k` | Kill buffer | Kill buffer (alternative) |
| `SPC b l` | List buffers | Show all buffers |
| `SPC b n` | Next buffer | Next buffer |
| `SPC b p` | Previous buffer | Previous buffer |
| `SPC TAB` | Last buffer | Toggle last two buffers |

### Window Management

| Key | Action | Description |
|-----|--------|-------------|
| `SPC w /` | Split right | Split window vertically |
| `SPC w -` | Split below | Split window horizontally |
| `SPC w d` | Delete window | Close current window |
| `SPC w m` | Maximize | Toggle maximize window |
| `SPC w h/j/k/l` | Navigate | Move to window (left/down/up/right) |
| `SPC w H/J/K/L` | Move window | Move window (left/down/up/right) |

### Project Management (Projectile)

| Key | Action | Description |
|-----|--------|-------------|
| `SPC p f` | Project file | Find file in project |
| `SPC p p` | Switch project | Switch to another project |
| `SPC p /` | Search project | Search in project (ag/rg) |
| `SPC p t` | Project tree | Toggle file tree |
| `SPC p R` | Replace | Find and replace in project |

### Search

| Key | Action | Description |
|-----|--------|-------------|
| `SPC s s` | Search buffer | Search in current buffer |
| `SPC s p` | Search project | Search in project |
| `SPC s f` | Search files | Search file names |
| `/` (Normal) | Search forward | Incremental search |
| `?` (Normal) | Search backward | Reverse search |
| `n` | Next match | Next search result |
| `N` | Previous match | Previous search result |

### Git (Magit)

| Key | Action | Description |
|-----|--------|-------------|
| `SPC g s` | Git status | Open Magit status |
| `SPC g b` | Git blame | Show git blame |
| `SPC g l` | Git log | Show git log |
| `SPC g d` | Git diff | Show git diff |

#### In Magit Buffer

| Key | Action |
|-----|--------|
| `s` | Stage |
| `u` | Unstage |
| `c c` | Commit |
| `P p` | Push |
| `F p` | Pull |
| `TAB` | Toggle diff |
| `q` | Quit |

### Error Checking (Flycheck)

| Key | Action | Description |
|-----|--------|-------------|
| `SPC e l` | List errors | Show all errors |
| `SPC e n` | Next error | Jump to next error |
| `SPC e p` | Previous error | Jump to previous error |
| `SPC e v` | Verify | Verify Flycheck setup |

### Help System

| Key | Action | Description |
|-----|--------|-------------|
| `SPC h d k` | Describe key | What does this key do? |
| `SPC h d f` | Describe function | Function documentation |
| `SPC h d v` | Describe variable | Variable documentation |
| `SPC h d m` | Describe mode | Current mode info |
| `SPC ?` | Show keybindings | List all keybindings |

## R Development (Major Mode Leader `,`)

!!! tip "R Commands Discovery"
    In any R file, press `, ?` to see all available R commands via which-key!

### R Console

| Key | Action | Description |
|-----|--------|-------------|
| `SPC SPC R` | Start R | Launch R console |
| `, s i` | Start inferior | Start R (alternative) |
| `, s l` | Send line | Execute current line |
| `, s r` | Send region | Execute selected region |
| `, s b` | Send buffer | Execute entire buffer |
| `, s f` | Send function | Execute current function |
| `, s s` | Switch to R | Jump to R console |
| `C-RET` | Send line/region | Traditional keybinding (still works) |

### R Package Development

| Key | Action | Description |
|-----|--------|-------------|
| `, s b` | Build package | Build and load package |
| `, t p` | Test package | Run all tests |
| `, t f` | Test file | Run tests in current file |
| `, t c` | Check package | R CMD check |
| `, r d` | Document | Generate documentation (roxygen) |

### Documentation (Roxygen)

| Key | Action | Description |
|-----|--------|-------------|
| `, h i` | Insert roxygen | Generate roxygen skeleton |
| `, h h` | Help at point | R help for object at cursor |

### LSP Navigation

| Key | Action | Description |
|-----|--------|-------------|
| `, g g` | Go to definition | Jump to function definition |
| `, g r` | Find references | Find all references |
| `, g b` | Go back | Return to previous location |
| `, r s` | Rename symbol | Rename variable/function |
| `, r o` | Organize imports | Organize imports |

### Code Actions

| Key | Action | Description |
|-----|--------|-------------|
| `, =` | Format buffer | Format entire buffer |
| `, = r` | Format region | Format selected region |

## Completion (Company)

| Key | Action | Description |
|-----|--------|-------------|
| (automatic) | Show completions | Appears after typing |
| `C-n` | Next completion | Navigate down |
| `C-p` | Previous completion | Navigate up |
| `TAB` or `RET` | Accept | Accept completion |
| `C-g` | Cancel | Cancel completion |
| `SPC i c` | Complete | Manual trigger |

## Custom emacs-r-devkit Commands

### Usethis Integration

| Key | Action | Description |
|-----|--------|-------------|
| `, u r` | Use R | Create R file (`use_r()`) |
| `, u t` | Use test | Create test file (`use_test()`) |
| `, u d` | Use data | Create data file |

### S7 Integration

| Key | Action | Description |
|-----|--------|-------------|
| `, S c` | S7 class | Insert S7 class definition |
| `, S m` | S7 method | Insert S7 method |
| `, S g` | S7 generic | Insert S7 generic |

## Common Workflows

### Add Documentation to Function

```
1. Place cursor on function definition
2. , h i                # Insert roxygen skeleton
3. Fill in @param, @return, @examples
4. , s b                # Build package to update docs
```

### Navigate Code

```
1. , g g                # Jump to definition
2. Explore code
3. , g b                # Jump back
```

### Fix Syntax Errors

```
1. SPC e l              # List all errors
2. SPC e n              # Jump to next error
3. Fix code (in Insert mode: i)
4. ESC                  # Return to Normal mode
5. SPC f s              # Save
```

### Test R Code Interactively

```
1. SPC SPC R            # Start R console
2. Write code in R file
3. , s l                # Send line to R
4. Check output in R console
5. , s s                # Jump to R console if needed
```

### Git Workflow

```
1. SPC g s              # Open Magit status
2. s                    # Stage files
3. c c                  # Commit
4. Write commit message
5. C-c C-c              # Confirm commit
6. P p                  # Push
```

## macOS-Specific Notes

### Meta Key Mapping

In Spacemacs, the traditional Emacs `M-` (Meta) key is still Option (⌥):

- `M-x` = `Option-x` (but use `SPC SPC` instead!)
- `M-.` = `Option-.` (but use `, g g` instead!)

### System Shortcuts Conflicts

Consider disabling these macOS shortcuts that conflict with Spacemacs:

**System Preferences → Keyboard → Shortcuts:**

- Mission Control (`C-↑`, `C-↓`)
- Spotlight (`Cmd-Space` - use Alfred or disable)
- Input Sources (Option shortcuts)

## Customizing Keybindings

To add custom keybindings, edit `~/.spacemacs` in the `dotspacemacs/user-config` section:

```elisp
(defun dotspacemacs/user-config ()
  "Configuration for user code."
  
  ;; Add custom R keybinding
  (spacemacs/set-leader-keys-for-major-mode 'ess-r-mode
    "x" 'my-custom-r-function)
  
  ;; Add global keybinding
  (spacemacs/set-leader-keys "o c" 'my-custom-function)
)
```

## Quick Reference Card

Print this for your desk:

| Task | Keys |
|------|------|
| **Files** | |
| Open file | `SPC f f` |
| Save | `SPC f s` |
| Recent | `SPC f r` |
| **Buffers** | |
| Switch | `SPC b b` |
| Close | `SPC b d` |
| Last | `SPC TAB` |
| **R Console** | |
| Start R | `SPC SPC R` |
| Send line | `, s l` |
| Send region | `, s r` |
| **R Development** | |
| Roxygen | `, h i` |
| Go to def | `, g g` |
| Test package | `, t p` |
| **Errors** | |
| List errors | `SPC e l` |
| Next error | `SPC e n` |
| **Help** | |
| Show keys | `SPC ?` |
| Describe key | `SPC h d k` |

## Learning Strategy

### Week 1: Modal Editing Basics

- Practice switching modes (`i`, `ESC`, `v`)
- Learn basic navigation (`h`, `j`, `k`, `l`)
- Master `SPC f f` (find file) and `SPC f s` (save)

### Week 2: Spacemacs Leader Key

- Explore `SPC` menu (wait for which-key)
- Learn file operations (`SPC f ...`)
- Learn buffer management (`SPC b ...`)

### Week 3: R Workflow

- Start R console (`SPC SPC R`)
- Send code to R (`, s l`, `, s r`)
- Insert roxygen (`, h i`)

### Week 4: Advanced Features

- LSP navigation (`, g g`, `, g r`)
- Error checking (`SPC e l`, `SPC e n`)
- Git workflow (`SPC g s`)

### Week 5+: Customization

- Explore layers
- Add custom keybindings
- Optimize your workflow

---

**Next:** Learn how to [configure](configuration.md) Spacemacs for your needs.
