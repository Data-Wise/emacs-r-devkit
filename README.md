# emacs-r-devkit

[![Tests](https://img.shields.io/badge/tests-59%20passing-brightgreen)](tests/)
[![Documentation](https://img.shields.io/badge/docs-mkdocs-blue)](https://data-wise.github.io/emacs-r-devkit/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS-lightgrey)](https://www.apple.com/macos/)
[![Emacs](https://img.shields.io/badge/Emacs-27.1+-purple)](https://www.gnu.org/software/emacs/)
[![R](https://img.shields.io/badge/R-4.0+-blue)](https://www.r-project.org/)
[![Spacemacs](https://img.shields.io/badge/Spacemacs-develop-blueviolet)](https://www.spacemacs.org/)

**Professional Spacemacs environment for R package development on macOS**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub release](https://img.shields.io/github/v/release/Data-Wise/emacs-r-devkit)](https://github.com/Data-Wise/emacs-r-devkit/releases)
[![GitHub stars](https://img.shields.io/github/stars/Data-Wise/emacs-r-devkit?style=social)](https://github.com/Data-Wise/emacs-r-devkit/stargazers)
[![Documentation](https://img.shields.io/badge/docs-GitHub%20Pages-blue)](https://data-wise.github.io/emacs-r-devkit/)
[![CI](https://img.shields.io/github/actions/workflow/status/Data-Wise/emacs-r-devkit/mkdocs.yml?branch=main&label=docs)](https://github.com/Data-Wise/emacs-r-devkit/actions)
[![Emacs](https://img.shields.io/badge/Emacs-27%2B-7F5AB6?logo=gnu-emacs)](https://www.gnu.org/software/emacs/)
[![Spacemacs](https://img.shields.io/badge/Spacemacs-develop-9266CC)](https://www.spacemacs.org/)
[![R](https://img.shields.io/badge/R-4.0%2B-276DC3?logo=r)](https://www.r-project.org/)
[![macOS](https://img.shields.io/badge/macOS-12%2B-000000?logo=apple)](https://www.apple.com/macos/)

---

## ✨ Features

A complete, integrated development environment for R package development powered by **Spacemacs**:

- **🎯 Modal Editing** - Vim-style navigation with discoverable keybindings
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
- **🗝️ Which-Key** - Discoverable keybindings (press `SPC` and wait!)

## 🚀 Quick Start

### Prerequisites

- **macOS** 12.0+ (tested on macOS 12+)
- **Emacs** 27.1+ ([emacs-plus@30](https://github.com/d12frosted/homebrew-emacs-plus) recommended)
- **R** 4.0+
- **Git** 2.0+
- **Homebrew** (recommended)

### Installation

```bash
# Install Emacs
brew tap d12frosted/emacs-plus
brew install emacs-plus@30 --with-native-comp
ln -s /opt/homebrew/opt/emacs-plus@30/Emacs.app /Applications/Emacs.app

# Install Spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cd ~/.emacs.d && git checkout develop

# Clone emacs-r-devkit
git clone https://github.com/Data-Wise/emacs-r-devkit.git ~/emacs-r-devkit
cd ~/emacs-r-devkit

# Install configuration
cp dotspacemacs.el ~/.spacemacs
mkdir -p ~/.emacs.d/bin && cp bin/* ~/.emacs.d/bin/ && chmod +x ~/.emacs.d/bin/*

# Install required R packages
Rscript -e 'install.packages(c("devtools", "usethis", "roxygen2", "testthat", "lintr", "styler", "languageserver"))'

# Verify installation
./check-dependencies.sh
```

### First Launch

```bash
# Start Spacemacs (first launch takes 10-15 minutes for layer installation)
emacs

# Or use GUI
open -a Emacs
```

**During first launch:**

The smart installer handles everything automatically:

```bash
# Clone the repository
git clone https://github.com/Data-Wise/emacs-r-devkit.git
cd emacs-r-devkit

# Run the smart installer
./scripts/install.sh
```

The installer will:

- ✅ Check your system health
- ✅ Install Emacs (if needed)
- ✅ Install Spacemacs (develop branch)
- ✅ Configure everything for R development
- ✅ Install required R packages

**First launch takes 10-15 minutes** as Spacemacs installs packages.

### Installation Management

```bash
# Check system health
./scripts/health-check.sh

# Update existing installation
./scripts/patch.sh

# Repair issues
./scripts/repair.sh

# Uninstall (3 levels)
./scripts/uninstall.sh

# Force reinstall
./scripts/install.sh --force
```

See [Installation Guide](https://data-wise.github.io/emacs-r-devkit/getting-started/) for details.
etup guide

- [**Migration Guide**](https://data-wise.github.io/emacs-r-devkit/migration-guide/) - Migrating from vanilla Emacs
- [**Spacemacs Learning**](https://data-wise.github.io/emacs-r-devkit/spacemacs-learning/) - Complete learning curriculum
- [**Features**](https://data-wise.github.io/emacs-r-devkit/features/) - Detailed feature documentation
- [**Keybindings**](https://data-wise.github.io/emacs-r-devkit/keybindings/) - Complete keybinding reference
- [**Configuration**](https://data-wise.github.io/emacs-r-devkit/configuration/) - Customization options
- [**Troubleshooting**](https://data-wise.github.io/emacs-r-devkit/troubleshooting/) - Common issues and solutions

## 🎯 Key Keybindings

| Key | Action | Description |
|-----|--------|-------------|
| `SPC f f` | Find file | Open file with fuzzy search |
| `SPC f s` | Save file | Save current buffer |
| `SPC b b` | Switch buffer | Switch to another buffer |
| `SPC SPC` | Execute | Run command (M-x) |
| `SPC p f` | Project file | Find file in project |
| `, s l` | Send line to R | Execute current line in R |
| `, s r` | Send region to R | Execute selected region in R |
| `, h i` | Insert roxygen | Generate documentation |
| `, g g` | Go to definition | Jump to function definition |
| `SPC e l` | List errors | Show Flycheck errors |

> **Note:** `,` is the major mode leader key (equivalent to `SPC m`). Press `, ?` in any R file to see all available commands via which-key.

See the [complete keybinding reference](https://data-wise.github.io/emacs-r-devkit/keybindings/) for more.

## 🔧 What's Included

### Spacemacs Configuration (`~/.spacemacs`)

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

- `guides/TUTORIAL.md` - Complete user guide
- `guides/CHEAT-SHEET.md` - Quick keybinding reference
- `guides/TROUBLESHOOTING.md` - Problem solving guide
- `tests/TEST-CHECKLIST.md` - Verification checklist

### Test Files

- `tests/test-features.R` - Interactive feature testing
- `tests/test-roxygen.R` - Roxygen generation testing

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
./scripts/check-dependencies.sh

# Open test file in Emacs
emacs tests/test-features.R

# Follow tests/TEST-CHECKLIST.md for comprehensive testing
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
3. **Dependency Checker** - Run `./scripts/check-dependencies.sh`
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
