# Features

spacemacs-rstats provides a complete, integrated development environment for R package development powered by Spacemacs.

## Core Components

### ESS (Emacs Speaks Statistics)

Full integration with R for interactive development.

**Capabilities:**

- Interactive R console (`SPC SPC R` or `, s i`)
- Send code from buffer to R (`, s l` for line, `, s r` for region)
- Function and region evaluation
- Syntax highlighting for R, Rmd, and Quarto
- Smart indentation
- Help system integration

**Key Features:**

```r
# Send line to R
x <- 1:10              # Cursor here, press , s l (or C-RET)

# Send region to R
summary(mtcars)        # Select region in Visual mode, press , s r
plot(mpg ~ wt, mtcars)

# Send entire function
my_function <- function(x) {
  result <- x * 2
  return(result)
}  # Cursor in function, press , s f
```bash

### Flycheck Integration

Real-time syntax and style checking with multiple checkers.

**Checkers:**

1. **lintr** - R code linting
    - Syntax errors
    - Style violations
    - Code smells
    - Best practice violations

2. **r-styler** - Code style validation
    - Tidyverse style guide compliance
    - Custom styler checker at `~/.emacs.d/bin/r-styler-check.R`

**In Action:**

- Errors shown with red squiggles
- Warnings with orange squiggles
- Info with blue squiggles
- List all issues: `SPC e l`
- Jump to next: `SPC e n`
- Jump to previous: `SPC e p`

### LSP Mode

Language Server Protocol support for intelligent code navigation.

**Features:**

- Go to definition (`, g g`)
- Find references (`, g r`)
- Go back (`, g b`)
- Symbol search
- Hover documentation
- Code actions
- Rename refactoring (`, r s`)

**Requirements:**

- R package: `languageserver`
- Must be in R package (needs `DESCRIPTION` file)
- Standalone R files won't activate LSP

**Usage:**

```r
# Jump to function definition
source_function()     # , g g on this

# Find all usages
my_variable          # , g r on this

# Rename symbol
old_name <- 1        # , r s to rename
```bash

### Company Mode

Context-aware code completion.

**Completion Sources:**

- R functions and objects
- Function arguments
- File paths
- R package exports
- LSP suggestions

**Behavior:**

- Automatic popup after short delay (0.1 seconds)
- Navigate with `C-n` / `C-p`
- Accept with `TAB` or `RET`
- Cancel with `C-g`
- Manual trigger: `M-x company-complete`

### Roxygen2 Integration

Automatic documentation skeleton generation with parameter detection.

**Command:** `, h i` (or `SPC m h i`)

**Example:**

```r
# Before - your function
calculate_stats <- function(data,
                           method = "mean",
                           na.rm = TRUE) {
  # implementation
}

# After pressing , h i (cursor before function)
#' Title
#'
#' @param data
#' @param method
#' @param na.rm
#'
#' @return
#' @export
#'
#' @examples
calculate_stats <- function(data,
                           method = "mean",
                           na.rm = TRUE) {
  # implementation
}
```text

**Features:**

- Detects function parameters (handles complex signatures)
- Supports multiline parameter lists
- Extracts parameter names (ignores defaults)
- Can use selected region as `@examples`

### Styler Auto-Format

Automatic code formatting on save using the styler R package.

**Behavior:**

- Runs on every save (`SPC f s` or `:w` in Normal mode)
- Formats entire buffer
- Preserves cursor position
- Guards against syntax errors
- Toggle with `, =` or disable in configuration

**What It Fixes:**

- Indentation
- Spacing around operators
- Line breaks
- Trailing whitespace
- Brace placement

**Example:**

```r
# Before save (messy)
my_func=function(x,y){
result=x+y
return(result)
}

# After save (clean)
my_func <- function(x, y) {
  result <- x + y
  return(result)
}
```text

**Disable for Project:**

Create `.dir-locals.el` in project root:

```elisp
((ess-r-mode . ((spacemacs-rstats/styler-enabled . nil))))
```bash

### Usethis Integration

Quick commands for R package scaffolding.

**Commands:**

- `, u r` - Create R file (`usethis::use_r()`)
- `, u t` - Create test file (`usethis::use_test()`)
- `, u d` - Create data file

**Example:**

```text
, u r
Prompt: utils
Creates: R/utils.R

, u t
Prompt: utils
Creates: tests/testthat/test-utils.R
```bash

### S7 Support

Built-in snippets and helpers for R's new S7 OOP system.

**Commands:**

- `, S c` - Insert S7 class definition
- `, S m` - Insert S7 method
- `, S g` - Insert S7 generic

**Example Class:**

```r
# After , S c
MyClass <- S7::new_class(
  name = "MyClass",
  properties = list(
    field1 = class_integer,
    field2 = class_character
  ),
  validator = function(self) {
    # Validation logic
  }
)
```bash

## Additional Integrations

### Magit (Git Integration)

Professional Git interface within Emacs.

**Launch:** `SPC g s`

**Common Operations:**

- `s` - Stage file
- `u` - Unstage file
- `c c` - Commit
- `P p` - Push
- `F p` - Pull
- `q` - Quit magit

### Projectile (Project Management)

Navigate and manage projects efficiently.

**Key Commands:**

- `SPC p f` - Find file in project
- `SPC p p` - Switch project
- `SPC p /` - Search in project

### Which-Key

Visual keybinding guide.

**Usage:**

- Press `SPC` or `,` (in R files) and wait
- Popup shows all available commands
- Shows keybindings and descriptions
- Helps discover functionality
- Press `SPC ?` to see all keybindings

### Vertico/Consult/Marginalia

Modern completion framework for enhanced UX.

**Features:**

- Vertical completion display (Vertico)
- Enhanced search commands (Consult)
- Rich annotations (Marginalia)
- Fuzzy matching
- Preview support

## macOS Enhancements

### PATH Management

Automatic PATH synchronization for GUI Emacs.

**How It Works:**

- Uses `exec-path-from-shell` package
- Loads PATH from shell at startup
- Ensures R, Quarto, etc. are found

**Manual Export:**

Rarely needed with Spacemacs (uses `exec-path-from-shell` automatically).

Or run:

```bash
~/.emacs.d/bin/export-gui-path.sh
```bash

### Keybinding Optimization

macOS-friendly keybindings:

- `Option (⌥)` = Meta (`M-`)
- `Command (⌘)` = Super (`S-`)
- Right-Option available for special chars

## Performance Features

### On-Demand Loading

Packages load only when needed (`use-package` with `:defer`):

- Fast startup (<5 seconds after initial install)
- Minimal memory footprint
- Lazy loading of heavy packages

### Optimized Defaults

Pre-configured for performance:

- Disabled automatic backups in working directory
- Custom auto-save directory (`~/.emacs.d/auto-saves/`)
- Disabled toolbar, scrollbar for cleaner UI
- Line numbers only for programming modes

### Smart Caching

- Recent files tracking (`recentf`)
- File name cache
- LSP workspace caching

## Workflow Integration

spacemacs-rstats integrates seamlessly with:

### Terminal Workflow

```bash
# Terminal (validation)
rtest          # Run tests
rdoc           # Build docs
rcheck         # R CMD check

# Spacemacs (editing)
SPC f f        # Open file
, h i          # Add roxygen
SPC f s        # Save (auto-format)
```bash

### Claude Code Integration

Works with Claude Code for AI assistance:

- Access via `~/.claude/skills/spacemacs-rstats.md`
- Context-aware help
- Workflow automation

### Quarto Support

Full Quarto integration:

- Syntax highlighting for `.qmd` files
- Code execution
- Preview support

## Customization Points

All major features can be customized:

- Disable auto-formatting per-project
- Adjust company delay
- Configure LSP settings
- Customize keybindings
- Add custom snippets

See [Configuration](configuration.md) for details.

## Feature Comparison

| Feature | Without spacemacs-rstats | With spacemacs-rstats |
|---------|----------------------|-------------------|
| Code Editing | Basic text editing | Syntax highlighting, smart indentation |
| Documentation | Manual roxygen | Auto-generated skeletons |
| Style Checking | Manual `styler::style_file()` | Automatic on save |
| Navigation | Manual search | Jump to definition, find refs |
| Completion | None | Context-aware suggestions |
| Error Detection | After R CMD check | Real-time in editor |
| Git | Command-line only | Visual interface (Magit) |
| R Console | Separate terminal | Integrated in Emacs |

---

**Next:** Learn the [Keybindings](keybindings.md) to use these features effectively.
