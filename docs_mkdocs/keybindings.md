# Keybindings Reference

Complete keybinding guide for emacs-r-devkit on macOS.

!!! warning "macOS Important"
    **Meta key** (`M-`) = **Option (⌥)**, NOT Command!
    Example: `M-x` means press `Option-x`, `M-.` means press `Option-.`

## Key Notation

| Notation | macOS Key | Description |
|----------|-----------|-------------|
| `C-` | Control | Control key |
| `M-` | Option (⌥) | Meta/Option key ← Important! |
| `S-` | Command (⌘) | Super/Command key |
| `Shift` | Shift | Shift key |
| `RET` | Return | Return/Enter |
| `SPC` | Space | Spacebar |
| `TAB` | Tab | Tab key |

## Survival Keys (Learn First!)

!!! tip "Emergency Exit"
    If you get stuck, press ++ctrl+g++ multiple times to cancel everything!

| Key | Action | Description |
|-----|--------|-------------|
| ++ctrl+g++ | Cancel | Escape/cancel current command |
| ++ctrl+x++ ++ctrl+f++ | Find file | Open a file |
| ++ctrl+x++ ++ctrl+s++ | Save | Save current file |
| ++ctrl+x++ ++ctrl+c++ | Exit | Quit Emacs |
| ++option+x++ | Execute | Run a command by name |

## Movement

### Basic Movement

| Key | Action |
|-----|--------|
| ++ctrl+a++ | Beginning of line |
| ++ctrl+e++ | End of line |
| ++ctrl+n++ | Next line |
| ++ctrl+p++ | Previous line |
| ++ctrl+f++ | Forward character |
| ++ctrl+b++ | Backward character |

### Word/Sentence Movement

| Key | Action |
|-----|--------|
| ++option+f++ | Forward word |
| ++option+b++ | Backward word |
| ++option+shift+less++ | Beginning of buffer |
| ++option+shift+greater++ | End of buffer |

### Page Movement

| Key | Action |
|-----|--------|
| ++ctrl+v++ | Page down |
| ++option+v++ | Page up |
| ++option+g++ ++g++ | Go to line number |

## Editing

### Cut, Copy, Paste

| Key | Action |
|-----|--------|
| ++ctrl+space++ | Start selection (mark) |
| ++ctrl+w++ | Cut (kill region) |
| ++option+w++ | Copy |
| ++ctrl+y++ | Paste (yank) |
| ++ctrl+k++ | Cut to end of line |
| ++option+d++ | Delete word forward |

### Undo

| Key | Action |
|-----|--------|
| ++ctrl+slash++ | Undo |
| ++ctrl+x++ ++u++ | Undo (alternative) |

## Files & Buffers

### File Operations

| Key | Action |
|-----|--------|
| ++ctrl+x++ ++ctrl+f++ | Find/open file |
| ++ctrl+x++ ++ctrl+s++ | Save file |
| ++ctrl+x++ ++ctrl+w++ | Save as |

### Buffer Operations

| Key | Action |
|-----|--------|
| ++ctrl+x++ ++b++ | Switch buffer |
| ++ctrl+x++ ++k++ | Kill (close) buffer |
| ++ctrl+x++ ++ctrl+b++ | List all buffers |

## Windows & Frames

### Window Management

| Key | Action |
|-----|--------|
| ++ctrl+x++ ++2++ | Split horizontally |
| ++ctrl+x++ ++3++ | Split vertically |
| ++ctrl+x++ ++1++ | Close other windows |
| ++ctrl+x++ ++0++ | Close current window |
| ++ctrl+x++ ++o++ | Switch to other window |

## Search & Replace

| Key | Action |
|-----|--------|
| ++ctrl+s++ | Search forward (isearch) |
| ++ctrl+r++ | Search backward |
| ++ctrl+s++ ++ctrl+s++ | Search again |
| ++option+shift+5++ | Query replace |

## Help System

| Key | Action | Description |
|-----|--------|-------------|
| ++ctrl+h++ ++k++ | Describe key | What does this key do? |
| ++ctrl+h++ ++f++ | Describe function | Function documentation |
| ++ctrl+h++ ++v++ | Describe variable | Variable documentation |
| ++ctrl+h++ ++m++ | Describe mode | Current mode info |
| ++ctrl+h++ ++e++ | View messages | Show `*Messages*` buffer |

## emacs-r-devkit Prefix (C-c r)

!!! tip "Discovery"
    Press ++ctrl+c++ ++r++ and wait 1 second - Which-Key will show all available commands!

### Core Commands

| Key | Action | Description |
|-----|--------|-------------|
| ++ctrl+c++ ++r++ ++r++ | Roxygen | Insert roxygen skeleton |
| ++ctrl+c++ ++r++ ++shift+s++ | Toggle styler | Enable/disable auto-format |
| ++ctrl+c++ ++r++ ++shift+p++ | Export PATH | Fix macOS PATH issues |

### Usethis Integration

| Key | Action | Description |
|-----|--------|-------------|
| ++ctrl+c++ ++r++ ++u++ | Use R | Create R file (`use_r()`) |
| ++ctrl+c++ ++r++ ++t++ | Use test | Create test file (`use_test()`) |
| ++ctrl+c++ ++r++ ++p++ | Package doc | Create package doc |

### S7 Integration

| Key | Action | Description |
|-----|--------|-------------|
| ++ctrl+c++ ++r++ ++s++ ++c++ | S7 class | Insert class definition |
| ++ctrl+c++ ++r++ ++s++ ++m++ | S7 method | Insert method |
| ++ctrl+c++ ++r++ ++s++ ++g++ | S7 generic | Insert generic |

## ESS (R Mode)

### R Console

| Key | Action |
|-----|--------|
| ++option+x++ `R` | Start R console |
| ++ctrl+enter++ | Send line/region to R |
| ++ctrl+c++ ++ctrl+c++ | Send function to R |
| ++ctrl+c++ ++ctrl+b++ | Send buffer to R |
| ++ctrl+c++ ++ctrl+z++ | Switch to R console |
| ++ctrl+c++ ++ctrl+l++ | Load file in R |

### R Help

| Key | Action |
|-----|--------|
| ++ctrl+c++ ++ctrl+v++ | R help on object |

## Flycheck (Syntax Checking)

| Key | Action |
|-----|--------|
| ++ctrl+c++ ++exclam++ ++l++ | List all errors |
| ++ctrl+c++ ++exclam++ ++n++ | Next error |
| ++ctrl+c++ ++exclam++ ++p++ | Previous error |
| ++ctrl+c++ ++exclam++ ++question++ | Describe checker |
| ++ctrl+c++ ++exclam++ ++v++ | Verify setup |

## LSP Mode

| Key | Action |
|-----|--------|
| ++option+period++ | Go to definition |
| ++option+comma++ | Go back |
| ++option+question++ | Find references |
| ++ctrl+c++ ++l++ ++r++ ++r++ | Rename symbol |
| ++ctrl+c++ ++l++ ++g++ ++g++ | Find definition |

## Company (Completion)

| Key | Action |
|-----|--------|
| (automatic) | Completions appear |
| ++ctrl+n++ | Next completion |
| ++ctrl+p++ | Previous completion |
| ++tab++ or ++enter++ | Accept completion |
| ++ctrl+g++ | Cancel completion |
| ++option+x++ `company-complete` | Manual trigger |

## Magit (Git)

### Launch

| Key | Action |
|-----|--------|
| ++ctrl+x++ ++g++ | Magit status |

### In Magit Buffer

| Key | Action |
|-----|--------|
| ++s++ | Stage file |
| ++u++ | Unstage file |
| ++c++ ++c++ | Commit |
| ++shift+p++ ++p++ | Push |
| ++shift+f++ ++p++ | Pull |
| ++q++ | Quit magit |
| ++tab++ | Toggle diff |

## Projectile

| Key | Action |
|-----|--------|
| ++ctrl+c++ ++p++ ++f++ | Find file in project |
| ++ctrl+c++ ++p++ ++p++ | Switch project |
| ++ctrl+c++ ++p++ ++s++ ++s++ | Search in project |

## Quarto

| Key | Action |
|-----|--------|
| ++ctrl+c++ ++ctrl+c++ | Execute chunk |

## Custom Keybinding Examples

### Common Workflows

=== "Add Documentation"

    ```
    1. C-c r r          # Insert roxygen
    2. Fill in fields
    3. C-x C-s          # Save (auto-formats)
    ```

=== "Navigate Code"

    ```
    1. M-.              # Jump to definition
    2. Explore code
    3. M-,              # Jump back
    ```

=== "Fix Errors"

    ```
    1. C-c ! l          # List errors
    2. C-c ! n          # Next error
    3. Fix code
    4. C-x C-s          # Save
    ```

=== "Test in R"

    ```
    1. C-RET            # Send line to R
    2. Check output in R console
    3. C-c C-z          # Jump to R console
    ```

## Common Mistakes

!!! failure "Using Command instead of Option"
    `M-x` is `Option-x`, NOT `Command-x`
    `M-.` is `Option-.`, NOT `Command-.`

!!! failure "Forgetting to hold Control"
    `C-x C-f` requires holding Control for both: `Ctrl-x` then `Ctrl-f`

!!! failure "Not using C-g"
    When stuck, press `C-g` repeatedly! It cancels everything.

!!! failure "Trying to use mouse"
    Emacs is keyboard-first. Learn the keybindings!

## Customizing Keybindings

To add custom keybindings, edit `~/.emacs.d/init.el`:

```elisp
;; Example: Add custom keybinding
(define-key ess-r-mode-map (kbd "C-c m") 'my-custom-function)

;; Example: Remap existing key
(define-key ess-r-mode-map (kbd "C-c C-r") 'ess-eval-region)
```

## Keybinding Conflicts

If you have conflicts with macOS system shortcuts:

**System Preferences → Keyboard → Shortcuts**

Consider disabling:

- Mission Control shortcuts
- Spotlight shortcuts
- Input Source shortcuts

These often conflict with Emacs `M-` (Option) keys.

## Quick Reference Card

Print this table for your desk:

| Task | Keys |
|------|------|
| Open file | `C-x C-f` |
| Save | `C-x C-s` |
| Cancel | `C-g` |
| Undo | `C-/` |
| Start R | `M-x R` |
| Send to R | `C-RET` |
| Roxygen | `C-c r r` |
| Go to def | `M-.` |
| List errors | `C-c ! l` |
| Help | `C-h k` |

## Learning Strategy

1. **Week 1:** Master survival keys (C-g, C-x C-f, C-x C-s)
2. **Week 2:** Learn movement (C-a, C-e, M-f, M-b)
3. **Week 3:** Learn editing (C-w, M-w, C-y)
4. **Week 4:** Learn R workflow (C-RET, C-c r r, M-.)
5. **Week 5+:** Explore advanced features

---

**Next:** Learn how to [configure](configuration.md) emacs-r-devkit for your needs.
