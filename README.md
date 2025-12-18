# spacemacs-rstats

[![Tests](https://img.shields.io/badge/tests-59%20passing-brightgreen)](tests/)
[![Documentation](https://img.shields.io/badge/docs-mkdocs-blue)](https://data-wise.github.io/spacemacs-rstats/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS-lightgrey)](https://www.apple.com/macos/)
[![Emacs](https://img.shields.io/badge/Emacs-27.1+-purple)](https://www.gnu.org/software/emacs/)
[![R](https://img.shields.io/badge/R-4.0+-blue)](https://www.r-project.org/)
[![Spacemacs](https://img.shields.io/badge/Spacemacs-develop-blueviolet)](https://www.spacemacs.org/)

**Professional Spacemacs environment for R package development on macOS**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub release](https://img.shields.io/github/v/release/Data-Wise/spacemacs-rstats)](https://github.com/Data-Wise/spacemacs-rstats/releases)
[![GitHub stars](https://img.shields.io/github/stars/Data-Wise/spacemacs-rstats?style=social)](https://github.com/Data-Wise/spacemacs-rstats/stargazers)
[![Documentation](https://img.shields.io/badge/docs-GitHub%20Pages-blue)](https://data-wise.github.io/spacemacs-rstats/)
[![CI](https://img.shields.io/github/actions/workflow/status/Data-Wise/spacemacs-rstats/mkdocs.yml?branch=main&label=docs)](https://github.com/Data-Wise/spacemacs-rstats/actions)
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

# Clone spacemacs-rstats
git clone https://github.com/Data-Wise/spacemacs-rstats.git ~/spacemacs-rstats
cd ~/spacemacs-rstats

# Install configuration
cp dotspacemacs.el ~/.spacemacs
mkdir -p ~/.emacs.d/bin && cp bin/* ~/.emacs.d/bin/ && chmod +x ~/.emacs.d/bin/*

# Install required R packages
Rscript -e 'install.packages(c("devtools", "usethis", "roxygen2", "testthat", "lintr", "styler", "languageserver"))'

# Verify installation
### First Launch

```bash
## ⚡ Installation (Copy-Paste This)

```bash
git clone https://github.com/Data-Wise/spacemacs-rstats.git
cd spacemacs-rstats
./scripts/install.sh
```

**Done!** ☕ Grab coffee (~10 min install time)

<details>
<summary>🔍 What's happening?</summary>

**The installer automatically:**

1. ✅ Checks macOS version, disk space, network
2. ✅ Installs Homebrew (if needed)
3. ✅ Installs Emacs with native compilation
4. ✅ Installs Spacemacs
5. ✅ Configures for R development
6. ✅ Installs R packages

**First Emacs launch:** Takes 10-15 min (packages installing)

</details>

<details>
<summary>⚙️ Troubleshooting</summary>

**Already installed?**

```bash
./scripts/health-check.sh --pre-flight
```

Shows 4 options: check health, update, repair, or reinstall.

**Something broke?**

```bash
./scripts/repair.sh  # Interactive menu
```

**Start over?**

```bash
./scripts/install.sh --force
```

</details>

<details>
<summary>🤓 Advanced options</summary>

```bash
./scripts/install.sh --skip-checks  # Skip pre-flight (not recommended)
./scripts/install.sh --yes          # No prompts
./scripts/patch.sh                  # Update only
./scripts/uninstall.sh              # Remove (3 levels)
```

See [Installation Management](https://data-wise.github.io/spacemacs-rstats/installation-management/) for details.

</details>
etup guide

- [**Migration Guide**](https://data-wise.github.io/spacemacs-rstats/migration-guide/) - Migrating from vanilla Emacs
- [**Spacemacs Learning**](https://data-wise.github.io/spacemacs-rstats/spacemacs-learning/) - Complete learning curriculum
- [**Features**](https://data-wise.github.io/spacemacs-rstats/features/) - Detailed feature documentation
- [**Keybindings**](https://data-wise.github.io/spacemacs-rstats/keybindings/) - Complete keybinding reference
- [**Configuration**](https://data-wise.github.io/spacemacs-rstats/configuration/) - Customization options
- [**Troubleshooting**](https://data-wise.github.io/spacemacs-rstats/troubleshooting/) - Common issues and solutions

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

See the [complete keybinding reference](https://data-wise.github.io/spacemacs-rstats/keybindings/) for more.

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

spacemacs-rstats integrates seamlessly with:

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

- 🐛 Report bugs via [GitHub Issues](https://github.com/Data-Wise/spacemacs-rstats/issues)
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

1. **[Troubleshooting Guide](https://data-wise.github.io/spacemacs-rstats/troubleshooting/)** - Common problems and solutions
2. **[GitHub Issues](https://github.com/Data-Wise/spacemacs-rstats/issues)** - Known issues and discussions
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

- **Issues**: [GitHub Issues](https://github.com/Data-Wise/spacemacs-rstats/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Data-Wise/spacemacs-rstats/discussions)
- **Website**: [data-wise.github.io/spacemacs-rstats](https://data-wise.github.io/spacemacs-rstats/)

---

**Made with** ❤️ **for the R development community**

⭐ Star this repo if you find it useful!
