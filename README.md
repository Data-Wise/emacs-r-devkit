# emacs-r-devkit

**Professional Emacs environment for R package development on macOS**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub release](https://img.shields.io/github/v/release/Data-Wise/emacs-r-devkit)](https://github.com/Data-Wise/emacs-r-devkit/releases)
[![GitHub stars](https://img.shields.io/github/stars/Data-Wise/emacs-r-devkit?style=social)](https://github.com/Data-Wise/emacs-r-devkit/stargazers)
[![Documentation](https://img.shields.io/badge/docs-GitHub%20Pages-blue)](https://data-wise.github.io/emacs-r-devkit/)
[![CI](https://img.shields.io/github/actions/workflow/status/Data-Wise/emacs-r-devkit/mkdocs.yml?branch=main&label=docs)](https://github.com/Data-Wise/emacs-r-devkit/actions)
[![Emacs](https://img.shields.io/badge/Emacs-27%2B-7F5AB6?logo=gnu-emacs)](https://www.gnu.org/software/emacs/)
[![R](https://img.shields.io/badge/R-4.0%2B-276DC3?logo=r)](https://www.r-project.org/)
[![macOS](https://img.shields.io/badge/macOS-12%2B-000000?logo=apple)](https://www.apple.com/macos/)

---

## ✨ Features

A complete, integrated development environment for R package development within Emacs:

- **🔍 ESS Integration** - Full Emacs Speaks Statistics support with R console and code evaluation
- **✅ Flycheck + Linters** - Real-time syntax checking with lintr and custom styler integration
- **🚀 LSP Mode** - Language Server Protocol for intelligent code navigation and refactoring
- **💡 Smart Completion** - Company mode with context-aware autocompletion
- **📝 Roxygen2 Automation** - Automatic documentation skeleton generation with parameter detection
- **🎨 Auto-Formatting** - Styler integration for automatic code formatting on save
- **🔷 S7 Support** - Built-in snippets and helpers for R's new S7 OOP system
- **📦 Usethis Integration** - Quick commands for creating R files, tests, and documentation
- **🔗 Git Integration** - Magit for visual Git operations
- **📚 Quarto/LaTeX** - Full support for Quarto documents and LaTeX writing

## 🚀 Quick Start

### Prerequisites

- **macOS** 12.0+ (tested on macOS 12+)
- **Emacs** 27.1+ ([emacs-plus](https://github.com/d12frosted/homebrew-emacs-plus) recommended)
- **R** 4.0+
- **Homebrew** (recommended)

### Installation

```bash
# Clone the repository
git clone https://github.com/Data-Wise/emacs-r-devkit.git
cd emacs-r-devkit

# Run installer
./install-init.sh

# Install required R packages
Rscript -e 'install.packages(c("devtools", "usethis", "roxygen2", "testthat", "lintr", "styler", "languageserver"))'

# Verify installation
./check-dependencies.sh
```

### First Launch

```bash
# Start Emacs (first launch takes 10-15 minutes for package installation)
emacs

# Or use GUI
open -a Emacs
```

**Note:** The first launch downloads and compiles packages from MELPA. Subsequent launches are fast (<5 seconds).

## 📚 Documentation

Comprehensive documentation is available at **[data-wise.github.io/emacs-r-devkit](https://data-wise.github.io/emacs-r-devkit/)**

- [**Getting Started**](https://data-wise.github.io/emacs-r-devkit/getting-started/) - Installation and setup guide
- [**Features**](https://data-wise.github.io/emacs-r-devkit/features/) - Detailed feature documentation
- [**Keybindings**](https://data-wise.github.io/emacs-r-devkit/keybindings/) - Complete keybinding reference for macOS
- [**Configuration**](https://data-wise.github.io/emacs-r-devkit/configuration/) - Customization options
- [**Troubleshooting**](https://data-wise.github.io/emacs-r-devkit/troubleshooting/) - Common issues and solutions
- [**Testing**](https://data-wise.github.io/emacs-r-devkit/testing/) - Verification guide

## 🎯 Key Keybindings

| Key | Action | Description |
|-----|--------|-------------|
| <kbd>⌃</kbd> <kbd>g</kbd> | Cancel | Escape/cancel (use when stuck!) |
| <kbd>⌃</kbd> <kbd>x</kbd> <kbd>⌃</kbd> <kbd>f</kbd> | Find file | Open file |
| <kbd>⌃</kbd> <kbd>x</kbd> <kbd>⌃</kbd> <kbd>s</kbd> | Save | Save file |
| <kbd>⌥</kbd> <kbd>x</kbd> | Execute | Run command |
| <kbd>⌃</kbd> <kbd>c</kbd> <kbd>r</kbd> | R prefix | emacs-r-devkit commands |
| <kbd>⌃</kbd> <kbd>c</kbd> <kbd>r</kbd> <kbd>r</kbd> | Roxygen | Insert documentation |
| <kbd>⌃</kbd> <kbd>⏎</kbd> | Send to R | Execute line/region |
| <kbd>⌥</kbd> <kbd>.</kbd> | Go to def | Jump to definition |
| <kbd>⌃</kbd> <kbd>c</kbd> <kbd>!</kbd> <kbd>l</kbd> | List errors | Show Flycheck errors |

> **Note:** <kbd>⌥</kbd> = Option key (Meta), <kbd>⌃</kbd> = Control, <kbd>⇧</kbd> = Shift, <kbd>⌘</kbd> = Command

See the [complete keybinding reference](https://data-wise.github.io/emacs-r-devkit/keybindings/) for more.

## 🔧 What's Included

### Emacs Configuration (`init.el`)

- **Package Management** - Automatic package installation via MELPA
- **ESS (R Mode)** - Full R integration with console and evaluation
- **Flycheck** - Syntax checking with lintr and custom styler checker
- **LSP Mode** - Language Server Protocol with R languageserver
- **Company** - Smart code completion
- **Vertico/Consult** - Modern completion framework
- **Magit** - Visual Git interface
- **Projectile** - Project management
- **Which-Key** - Keybinding discovery
- **Yasnippet** - Code snippets
- **Quarto/Polymode** - Quarto document support
- **AUCTeX** - LaTeX integration
- **Org Mode** - Enhanced org-mode
- **Citar** - Citation management

### Helper Scripts (`~/.emacs.d/bin/`)

- `r-styler-check.R` - External Flycheck checker for styler
- `export-gui-path.sh` - PATH exporter for macOS GUI Emacs

### Documentation

- `TUTORIAL.md` - Complete user guide
- `CHEAT-SHEET.md` - Quick keybinding reference
- `TROUBLESHOOTING.md` - Problem solving guide
- `TEST-CHECKLIST.md` - Verification checklist

### Test Files

- `test-features.R` - Interactive feature testing
- `test-roxygen.R` - Roxygen generation testing

## 🌟 Workflow Integration

emacs-r-devkit integrates seamlessly with:

- **Terminal Workflow** - Use with `rtest`, `rdoc`, `rcheck` aliases
- **Claude Code** - AI-powered development assistance
- **zsh-environment** - Modern shell with development tools
- **r-package-development** - Complete R workflow automation

## 💻 Development Workflow

```bash
# 1. Open R package
cd ~/R-packages/active/mypackage
emacs .

# 2. Edit code in Emacs
# - Auto-completion
# - Real-time error checking
# - Roxygen documentation
# - Auto-formatting on save

# 3. Test interactively in R console
# M-x R
# C-RET to send code

# 4. Validate in terminal
rtest          # Run tests
rdoc           # Build documentation
rcheck         # R CMD check
```

## 🤝 Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Ways to Contribute

- 🐛 Report bugs via [GitHub Issues](https://github.com/Data-Wise/emacs-r-devkit/issues)
- 💡 Suggest features or improvements
- 📝 Improve documentation
- 🔧 Submit pull requests

## 📋 Requirements

### System

- macOS 12.0+ (Monterey or later)
- Emacs 27.1+ (30.0+ recommended)
- R 4.0+
- Git 2.0+

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
```

### Optional R Packages

```r
install.packages(c(
  "languageserver",  # LSP support
  "s7",              # S7 OOP system
  "covr",            # Test coverage
  "pkgdown",         # Package websites
  "remotes"          # Remote packages
))
```

## 🔍 Verification

After installation, verify everything works:

```bash
# Run automated checks
./check-dependencies.sh

# Open test file in Emacs
emacs test-features.R

# Follow TEST-CHECKLIST.md for comprehensive testing
```

## 📖 Learning Resources

- [Emacs Speaks Statistics (ESS)](https://ess.r-project.org/)
- [R Packages Book](https://r-pkgs.org/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- [GNU Emacs Manual](https://www.gnu.org/software/emacs/manual/)

## 🐛 Troubleshooting

Having issues? Check:

1. **[Troubleshooting Guide](https://data-wise.github.io/emacs-r-devkit/troubleshooting/)** - Common problems and solutions
2. **[GitHub Issues](https://github.com/Data-Wise/emacs-r-devkit/issues)** - Known issues and discussions
3. **Dependency Checker** - Run `./check-dependencies.sh`
4. **Messages Buffer** - In Emacs: <kbd>⌃</kbd> <kbd>h</kbd> <kbd>e</kbd>

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

## 🙏 Acknowledgments

Built with:

- [GNU Emacs](https://www.gnu.org/software/emacs/) - The extensible text editor
- [ESS](https://ess.r-project.org/) - Emacs Speaks Statistics
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) - Documentation theme
- [R Project](https://www.r-project.org/) - Statistical computing

## 📬 Contact

- **Issues**: [GitHub Issues](https://github.com/Data-Wise/emacs-r-devkit/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Data-Wise/emacs-r-devkit/discussions)
- **Website**: [data-wise.github.io/emacs-r-devkit](https://data-wise.github.io/emacs-r-devkit/)

---

**Made with** ❤️ **for the R development community**

⭐ Star this repo if you find it useful!
