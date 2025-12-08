# Features

emacs-r-devkit provides a complete, integrated development environment for R package development within Emacs.

## Core Components

### ESS (Emacs Speaks Statistics)

Full integration with R for interactive development.

**Capabilities:**

- Interactive R console (`M-x R`)
- Send code from buffer to R (`C-RET`)
- Function and region evaluation
- Syntax highlighting for R, Rmd, and Quarto
- Smart indentation
- Help system integration

**Key Features:**

```r
# Send line to R
x <- 1:10              # Cursor here, press C-RET

# Send region to R
summary(mtcars)        # Select region, press C-RET
plot(mpg ~ wt, mtcars)

# Send entire function
my_function <- function(x) {
  result <- x * 2
  return(result)
}  # Cursor in function, press C-c C-c
```

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
- List all issues: `C-c ! l`
- Jump to next: `C-c ! n`

### LSP Mode

Language Server Protocol support for intelligent code navigation.

**Features:**

- Go to definition (`M-.`)
- Find references (`M-?`)
- Symbol search
- Hover documentation
- Code actions
- Rename refactoring

**Requirements:**

- R package: `languageserver`
- Must be in R package (needs `DESCRIPTION` file)
- Standalone R files won't activate LSP

**Usage:**

```r
# Jump to function definition
source_function()     # M-. on this

# Find all usages
my_variable          # M-? on this

# Rename symbol
old_name <- 1        # C-c l r r to rename
```

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

**Command:** `C-c r r`

**Example:**

```r
# Before - your function
calculate_stats <- function(data,
                           method = "mean",
                           na.rm = TRUE) {
  # implementation
}

# After pressing C-c r r (cursor before function)
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
```

**Features:**

- Detects function parameters (handles complex signatures)
- Supports multiline parameter lists
- Extracts parameter names (ignores defaults)
- Can use selected region as `@examples`

### Styler Auto-Format

Automatic code formatting on save using the styler R package.

**Behavior:**

- Runs on every save (`C-x C-s`)
- Formats entire buffer
- Preserves cursor position
- Guards against syntax errors
- Toggle with `C-c r S`

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
```

**Disable for Project:**

Create `.dir-locals.el` in project root:

```elisp
((ess-r-mode . ((emacs-r-devkit/styler-enabled . nil))))
```

### Usethis Integration

Quick commands for R package scaffolding.

**Commands:**

- `C-c r u` - Create R file (`usethis::use_r()`)
- `C-c r t` - Create test file (`usethis::use_test()`)
- `C-c r p` - Create package doc (`usethis::use_package_doc()`)

**Example:**

```
C-c r u
Prompt: utils
Creates: R/utils.R

C-c r t
Prompt: utils
Creates: tests/testthat/test-utils.R
```

### S7 Support

Built-in snippets and helpers for R's new S7 OOP system.

**Commands:**

- `C-c r s c` - Insert S7 class definition
- `C-c r s m` - Insert S7 method
- `C-c r s g` - Insert S7 generic

**Example Class:**

```r
# After C-c r s c
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
```

## Additional Integrations

### Magit (Git Integration)

Professional Git interface within Emacs.

**Launch:** `C-x g`

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

- `C-c p f` - Find file in project
- `C-c p p` - Switch project
- `C-c p s s` - Search in project

### Which-Key

Visual keybinding guide.

**Usage:**

- Press `C-c r` and wait
- Popup shows all available commands
- Shows keybindings and descriptions
- Helps discover functionality

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

```
C-c r P         # Export PATH
```

Or run:

```bash
~/.emacs.d/bin/export-gui-path.sh
```

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

emacs-r-devkit integrates seamlessly with:

### Terminal Workflow

```bash
# Terminal (validation)
rtest          # Run tests
rdoc           # Build docs
rcheck         # R CMD check

# Emacs (editing)
C-x C-f        # Open file
C-c r r        # Add roxygen
C-x C-s        # Save (auto-format)
```

### Claude Code Integration

Works with Claude Code for AI assistance:

- Access via `~/.claude/skills/emacs-r-devkit.md`
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

| Feature | Without emacs-r-devkit | With emacs-r-devkit |
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
