# Spacemacs Learning

Complete learning resources for mastering Spacemacs with R development.

## Overview

Spacemacs combines the best of Emacs and Vim, providing a powerful, discoverable environment for R development. This page links to comprehensive learning materials to help you become proficient.

## Quick Start

**New to Spacemacs?** Start here:

- **[Quick Start Guide](https://github.com/Data-Wise/emacs-r-devkit/blob/main/guides/spacemacs-learning/00-QUICK-START.md)** - Get productive in 30 minutes
  - Essential keybindings
  - Modal editing basics
  - R workflow primer

## Learning Path

### 1. Fundamentals

**[Emacs Basics](https://github.com/Data-Wise/emacs-r-devkit/blob/main/guides/spacemacs-learning/00-EMACS-BASICS.md)**

- Understanding buffers, windows, and frames
- The minibuffer and echo area
- Basic navigation and editing
- File operations

### 2. Spacemacs Essentials

**[Spacemacs Guide](https://github.com/Data-Wise/emacs-r-devkit/blob/main/guides/spacemacs-learning/01-SPACEMACS-GUIDE.md)**

- Modal editing (Normal, Insert, Visual modes)
- Leader key (`SPC`) paradigm
- Which-key discovery system
- Layer architecture
- Configuration structure

### 3. Structured Learning

**[Learning Curriculum](https://github.com/Data-Wise/emacs-r-devkit/blob/main/guides/spacemacs-learning/02-LEARNING-CURRICULUM.md)**

- **Week 1**: Modal editing and basic navigation
- **Week 2**: File and buffer management
- **Week 3**: R development workflow
- **Week 4**: Advanced features and customization

Daily lessons with practice exercises and real-world R coding tasks.

### 4. Reference Materials

**[Cheat Sheets](https://github.com/Data-Wise/emacs-r-devkit/blob/main/guides/spacemacs-learning/03-CHEAT-SHEETS.md)**

- Modal editing commands
- Spacemacs keybindings
- R-specific commands
- Quick reference tables

**[Learning Roadmap](https://github.com/Data-Wise/emacs-r-devkit/blob/main/guides/spacemacs-learning/04-LEARNING-ROADMAP.md)**

- Beginner to advanced progression
- Skill milestones
- Practice recommendations

**[Spacemacs Reference](https://github.com/Data-Wise/emacs-r-devkit/blob/main/guides/spacemacs-learning/SPACEMACS-REFERENCE.md)**

- Complete keybinding reference
- Layer documentation
- Configuration options

## R Development Workflow

### Essential Keybindings

| Task | Keybinding | Description |
|------|------------|-------------|
| **File Operations** | | |
| Find file | `SPC f f` | Open file with fuzzy search |
| Save file | `SPC f s` | Save current buffer |
| Recent files | `SPC f r` | Open recent files |
| **Buffer Management** | | |
| Switch buffer | `SPC b b` | Switch to another buffer |
| Kill buffer | `SPC b d` | Close current buffer |
| List buffers | `SPC b l` | Show all buffers |
| **R Console** | | |
| Start R | `SPC SPC R` | Launch R console |
| Send line | `, s l` | Execute current line |
| Send region | `, s r` | Execute selected region |
| Send buffer | `, s b` | Execute entire buffer |
| **R Development** | | |
| Insert roxygen | `, h i` | Generate documentation |
| Load package | `, s b` | Load R package |
| Run tests | `, t p` | Run package tests |
| Check package | `, t c` | R CMD check |
| **LSP Navigation** | | |
| Go to definition | `, g g` | Jump to function definition |
| Go back | `, g b` | Return to previous location |
| Find references | `, g r` | Find all references |
| Rename symbol | `, r s` | Rename variable/function |
| **Error Checking** | | |
| List errors | `SPC e l` | Show Flycheck errors |
| Next error | `SPC e n` | Jump to next error |
| Previous error | `SPC e p` | Jump to previous error |

!!! tip "Discover More"
    Press `, ?` in any R file to see all available major mode commands via which-key.

## Modal Editing Primer

### The Three Modes

**Normal Mode** (`<N>`) - Default mode for navigation and text manipulation

- Move: `h` (left), `j` (down), `k` (up), `l` (right)
- Delete: `d d` (delete line), `d w` (delete word)
- Copy: `y y` (copy line), `y w` (copy word)
- Paste: `p` (paste after), `P` (paste before)

**Insert Mode** (`<I>`) - For typing text

- Enter: Press `i` (insert), `a` (append), `o` (new line below)
- Exit: Press `ESC` or type `fd` quickly

**Visual Mode** (`<V>`) - For selecting text

- Enter: Press `v` (character), `V` (line), `C-v` (block)
- Exit: Press `ESC`

### Why Modal Editing?

- **Ergonomic**: Hands stay on home row
- **Efficient**: Fewer keystrokes for common operations
- **Powerful**: Combine commands (e.g., `d3w` = delete 3 words)
- **Discoverable**: Which-key shows available commands

## Practice Recommendations

### Daily Practice (15-30 minutes)

**Week 1: Muscle Memory**

- Practice mode switching (Normal ↔ Insert)
- Basic navigation (`h`, `j`, `k`, `l`)
- Simple edits (`i`, `a`, `o`, `ESC`)

**Week 2: File Operations**

- Opening files (`SPC f f`)
- Switching buffers (`SPC b b`)
- Saving and quitting (`:w`, `:q`)

**Week 3: R Development**

- Start R console (`SPC SPC R`)
- Send code to R (`, s l`, `, s r`)
- Navigate code (`, g g`, `, g b`)

**Week 4: Advanced Features**

- Project management (`SPC p ...`)
- Git operations (`SPC g ...`)
- Custom workflows

### Real-World Exercises

Use your actual R projects to practice:

1. **Refactor a function** - Practice LSP navigation and renaming
2. **Write documentation** - Use roxygen insertion (`, h i`)
3. **Debug code** - Use Flycheck error navigation
4. **Run tests** - Execute test suite (`, t p`)

## Getting Help

### In Spacemacs

- **Help documentation**: `SPC h d`
- **Describe key**: `SPC h d k` then press any key
- **Describe function**: `SPC h d f` then type function name
- **Search documentation**: `SPC h d s`
- **List keybindings**: `SPC ?`

### External Resources

- **[Spacemacs Documentation](https://www.spacemacs.org/doc/DOCUMENTATION.html)** - Official docs
- **[Evil Mode Guide](https://github.com/emacs-evil/evil)** - Vim emulation
- **[ESS Manual](https://ess.r-project.org/Manual/ess.html)** - R integration
- **[Spacemacs Gitter](https://gitter.im/syl20bnr/spacemacs)** - Community chat

## Tips for Success

!!! tip "Start Small"
    Don't try to learn everything at once. Master one concept before moving to the next.

!!! tip "Use Which-Key"
    When in doubt, press `SPC` and wait. Which-key will show available commands.

!!! tip "Practice Daily"
    Even 15 minutes of daily practice builds muscle memory faster than occasional long sessions.

!!! tip "Use Real Projects"
    Apply what you learn to your actual R development work immediately.

!!! tip "Embrace Mistakes"
    Stuck in Insert mode? Press `ESC`. Made a mistake? Press `u` to undo. Mistakes are part of learning!

## Next Steps

1. **Start with Quick Start** - [00-QUICK-START.md](https://github.com/Data-Wise/emacs-r-devkit/blob/main/guides/spacemacs-learning/00-QUICK-START.md)
2. **Follow the Curriculum** - [02-LEARNING-CURRICULUM.md](https://github.com/Data-Wise/emacs-r-devkit/blob/main/guides/spacemacs-learning/02-LEARNING-CURRICULUM.md)
3. **Keep Cheat Sheets Handy** - [03-CHEAT-SHEETS.md](https://github.com/Data-Wise/emacs-r-devkit/blob/main/guides/spacemacs-learning/03-CHEAT-SHEETS.md)
4. **Practice with Real R Code** - Apply to your projects

---

**Happy Learning!** Remember: Spacemacs has a learning curve, but the productivity gains are worth it.
