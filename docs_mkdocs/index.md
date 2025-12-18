# emacs-r-devkit

**Professional Emacs environment for R package development on macOS**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub release](https://img.shields.io/github/release/Data-Wise/emacs-r-devkit.svg)](https://github.com/Data-Wise/emacs-r-devkit/releases)
[![GitHub stars](https://img.shields.io/github/stars/Data-Wise/emacs-r-devkit.svg?style=social)](https://github.com/Data-Wise/emacs-r-devkit/stargazers)

---

## ✨ Features

<div class="grid cards" markdown>

- :material-file-code:{ .lg .middle } **ESS Integration**

    ---

    Full Emacs Speaks Statistics support with R console, code evaluation, and REPL interaction.

- :material-check-decagram:{ .lg .middle } **Flycheck + Linters**

    ---

    Real-time syntax checking with lintr and custom styler integration for code quality.

- :material-server:{ .lg .middle } **LSP Mode**

    ---

    Language Server Protocol support with R languageserver for intelligent code navigation.

- :material-file-document-edit:{ .lg .middle } **Smart Completion**

    ---

    Company mode with context-aware autocompletion for R functions and objects.

- :material-file-star:{ .lg .middle } **Roxygen2 Automation**

    ---

    Automatic documentation skeleton generation with parameter detection.

- :material-brush:{ .lg .middle } **Auto-Formatting**

    ---

    Styler integration for automatic code formatting on save with error guards.

- :material-cube-outline:{ .lg .middle } **S7 Support**

    ---

    Built-in snippets and helpers for R's new S7 object-oriented programming system.

- :material-package-variant:{ .lg .middle } **Usethis Integration**

    ---

    Quick commands for creating R files, tests, and package documentation.

</div>

## 🚀 Quick Start

=== "Installation"

    ```bash
    # Clone the repository
    git clone https://github.com/Data-Wise/emacs-r-devkit.git
    cd emacs-r-devkit

    # Run the installer
    ./install-init.sh

    # Check dependencies
    ./check-dependencies.sh
    ```

=== "First Launch"

    ```bash
    # Start Emacs (first launch takes 10-15 minutes for package installation)
    open -a Emacs

    # Or from terminal
    emacs
    ```

=== "Verify Setup"

    ```bash
    # Open a test R file
    emacs test-features.R

    # Follow the checklist in TEST-CHECKLIST.md
    ```

## 🎯 Core Capabilities

| Feature | Tool | Keybinding | Purpose |
|---------|------|------------|---------|
| R Console | ESS | `M-x R` | Start interactive R session |
| Send Code | ESS | `C-RET` | Execute line/region in R |
| Documentation | Roxygen2 | `C-c r r` | Insert roxygen skeleton |
| Go to Definition | LSP | `M-.` | Jump to function definition |
| Find References | LSP | `M-?` | Find all usages |
| Syntax Check | Flycheck | `C-c ! l` | List errors/warnings |
| Auto-Format | Styler | On save | Format code automatically |
| Completion | Company | Automatic | Suggest completions |

## 📋 Prerequisites

!!! info "System Requirements"
    - **macOS** (tested on macOS 12+)
    - **Emacs 27+** (emacs-plus recommended)
    - **R 4.0+**

### Required R Packages

```r
install.packages(c(
  "devtools",
  "usethis",
  "roxygen2",
  "testthat",
  "lintr",
  "styler"
))
```bash

### Optional R Packages

```r
install.packages(c(
  "languageserver",  # For LSP mode
  "s7",              # For S7 OOP support
  "covr",            # For test coverage
  "pkgdown"          # For package websites
))
```bash

## 🎨 Integrated Workflow

emacs-r-devkit is designed to work seamlessly with your existing R development workflow:

=== "Emacs (Editing)"

    - Write and edit R code with syntax highlighting
    - Auto-format with styler on save
    - Generate documentation with roxygen2
    - Navigate code with LSP
    - Test interactively in R console

=== "Terminal (Validation)"

    ```bash
    rtest          # Run package tests
    rdoc           # Build documentation
    rdev           # Full development cycle
    rcheck         # R CMD check
    ```

    See your `r-package-development` Claude skill for complete workflow aliases.

## 📚 Documentation

- [Getting Started](getting-started.md) - Installation and setup guide
- [Features](features.md) - Detailed feature overview
- [Keybindings](keybindings.md) - Complete keybinding reference
- [Configuration](configuration.md) - Customization options
- [Troubleshooting](troubleshooting.md) - Common issues and solutions

## 🔧 Key Keybindings

!!! tip "Quick Reference"
    - ++ctrl+g++ - Cancel/Escape (use when stuck!)
    - ++ctrl+x++ ++ctrl+f++ - Open file
    - ++ctrl+x++ ++ctrl+s++ - Save file
    - ++option+x++ - Execute command (`M-x`)
    - ++ctrl+c++ ++r++ - emacs-r-devkit prefix (shows all options)

!!! warning "macOS Important"
    **Meta key** (M-) = **Option (⌥)**, NOT Command!
    Example: `M-x` = `Option-x`, `M-.` = `Option-.`

## 🤝 Integration

Works seamlessly with:

- **zsh-environment** - Modern shell with development aliases
- **r-package-development** - Complete R workflow automation
- **Claude Code** - AI-powered development assistance

## 🎯 Use Cases

- R package development
- Statistical computing
- Data analysis scripts
- Interactive R exploration
- Documentation writing
- Test development

## 📄 License

MIT License - see [LICENSE](https://github.com/Data-Wise/emacs-r-devkit/blob/main/LICENSE) for details.

## 🙏 Acknowledgments

Built with:

- [Emacs](https://www.gnu.org/software/emacs/) - The extensible text editor
- [ESS](https://ess.r-project.org/) - Emacs Speaks Statistics
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) - Documentation theme
