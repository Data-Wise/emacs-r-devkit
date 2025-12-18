# API Reference

This document provides a detailed reference for the internal Emacs Lisp functions provided by `emacs-r-devkit`. These functions can be used interactively or called within your own Emacs configuration.

## 1. Overview

The `emacs-r-devkit` exposes a set of functions designed to automate R package development tasks. All functions are prefixed with `emacs-r-devkit/` to avoid namespace collisions.

- **Prefix**: `emacs-r-devkit/`
- **Primary Keymap**: `C-c r`

## 2. Core Development Functions

### Roxygen2 Integration

#### `emacs-r-devkit/insert-roxygen-skeleton`
- **Keybinding**: `C-c r r`
- **Description**: Inserts a comprehensive Roxygen2 documentation skeleton for the R function at point.
- **Features**:
    - Automatically parses function signatures to generate `@param` tags.
    - Extracts parameter names while ignoring default values.
    - Uses the currently selected region (if any) as the content for the `@examples` section.
    - Includes `@title`, `@description`, `@return`, and `@export` tags by default.

### Styler Integration

#### `emacs-r-devkit/style-buffer-with-guard`
- **Hook**: `before-save-hook`
- **Description**: Formats the current buffer using the R `styler` package.
- **Safety Mechanism**: It styles a temporary file first. If R code contains syntax errors and `styler` fails, the buffer remains untouched, preventing the insertion of error messages into your source code.

#### `emacs-r-devkit/toggle-styler`
- **Keybinding**: `C-c r S`
- **Description**: Toggles the automatic styling-on-save feature.
- **Related Variable**: `emacs-r-devkit/styler-enabled` (can be set via `.dir-locals.el`).

### Usethis Scaffolding

#### `emacs-r-devkit/usethis-use-r`
- **Keybinding**: `C-c r u`
- **Description**: Prompts for a filename and executes `usethis::use_r()`. Automatically opens the newly created file in `R/`.

#### `emacs-r-devkit/usethis-use-test`
- **Keybinding**: `C-c r t`
- **Description**: Prompts for a test name and executes `usethis::use_test()`. Opens the test file in `tests/testthat/`.

#### `emacs-r-devkit/usethis-use-package-doc`
- **Keybinding**: `C-c r p`
- **Description**: Executes `usethis::use_package_doc()` to create or update the package-level documentation.

### S7 OOP Support

#### `emacs-r-devkit/s7-insert-class`
- **Keybinding**: `C-c r s c`
- **Description**: Inserts a template for a new S7 class definition (`s7::new_class`).

#### `emacs-r-devkit/s7-insert-method`
- **Keybinding**: `C-c r s m`
- **Description**: Inserts a template for an S7 method definition (`s7::method`).

#### `emacs-r-devkit/s7-insert-generic`
- **Keybinding**: `C-c r s g`
- **Description**: Inserts a template for a new S7 generic function (`s7::new_generic`).

## 3. System & Environment

### `emacs-r-devkit/export-gui-path`
- **Keybinding**: `C-c r P`
- **Description**: Runs an external script (`export-gui-path.sh`) to export the current shell `PATH` to the macOS `launchctl` environment. This is essential for GUI Emacs to locate `R`, `quarto`, and other CLI tools.

### `emacs-r-devkit/is-macos`
- **Description**: Returns `t` if the system is macOS.

### `emacs-r-devkit/is-gui`
- **Description**: Returns `t` if Emacs is running in a windowed (GUI) session.

## 4. Configuration Variables

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `emacs-r-devkit/styler-enabled` | boolean | `t` | Enable/disable auto-formatting on save. |

## 5. Usage Example

You can use these functions in your own custom Elisp to build specialized workflows:

```elisp
(defun my/quick-r-feature (name)
  "Create a new R file and add a roxygen skeleton immediately."
  (interactive "sFeature Name: ")
  (emacs-r-devkit/usethis-use-r name)
  (insert (format "%s <- function(x) {
  
}" name))
  (forward-line -1)
  (emacs-r-devkit/insert-roxygen-skeleton))
```

