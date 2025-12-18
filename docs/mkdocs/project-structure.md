# Project Structure

The emacs-r-devkit project follows a clean, organized structure:

## Directory Layout

```
emacs-r-devkit/
├── config/              # Emacs configuration
│   ├── init.el         # Main configuration file
│   ├── dotspacemacs.el # Spacemacs configuration
│   ├── .lintr          # R linting rules
│   └── snippets/       # Code snippets
│
├── docs/               # Documentation
│   ├── mkdocs/        # Website source
│   ├── guides/        # User guides
│   └── archive/       # Archived content
│
├── scripts/           # Installation & setup scripts
│   ├── install-init.sh
│   ├── check-dependencies.sh
│   ├── link-emacs-app.sh
│   ├── post-install-verification.sh
│   └── test-r-workflow.sh
│
├── bin/               # Runtime helper scripts
│   ├── export-gui-path.sh
│   └── r-styler-check.R
│
├── tests/             # Test suite
│   ├── fixtures/     # Test data
│   ├── *.sh          # Shell tests
│   ├── *.R           # R tests
│   ├── *.py          # Python tests
│   └── *.el          # Emacs Lisp tests
│
├── project-docs/      # Development documentation
│   ├── GEMINI.md
│   ├── LEARNINGS.md
│   └── ...
│
└── guides/            # Quick reference guides
    ├── TUTORIAL.md
    ├── CHEAT-SHEET.md
    └── ...
```

## Key Files

### Configuration

- **`config/init.el`** - Main Emacs configuration (23KB, 700+ lines)
- **`config/dotspacemacs.el`** - Spacemacs-specific configuration
- **`config/.lintr`** - R linting rules

### Scripts

- **`scripts/install-init.sh`** - Install configuration to `~/.emacs.d/`
- **`scripts/check-dependencies.sh`** - Verify all dependencies
- **`scripts/link-emacs-app.sh`** - Create macOS application launcher

### Documentation

- **`README.md`** - Project overview and quick start
- **`docs/mkdocs/`** - Website documentation source
- **`docs/guides/`** - Tutorials and reference guides

### Tests

- **`tests/run_all_tests.sh`** - Run complete test suite (59 tests)
- **`tests/fixtures/`** - Test data and edge cases

## Installation Locations

After installation, files are placed in:

```
~/.emacs.d/
├── init.el              # From config/init.el
├── bin/
│   ├── export-gui-path.sh
│   └── r-styler-check.R
└── backups/             # Backup of previous init.el
```

## Development Workflow

1. **Clone repository**

   ```bash
   git clone https://github.com/Data-Wise/emacs-r-devkit.git
   cd emacs-r-devkit
   ```

2. **Install dependencies**

   ```bash
   ./scripts/check-dependencies.sh
   ```

3. **Install configuration**

   ```bash
   ./scripts/install-init.sh
   ```

4. **Run tests**

   ```bash
   ./tests/run_all_tests.sh
   ```

## Documentation Structure

- **Website** (`docs/mkdocs/`) - Built with MkDocs Material
- **Guides** (`docs/guides/`) - Printable tutorials and cheat sheets
- **Project Docs** (`project-docs/`) - Development notes and learnings

## See Also

- [Getting Started](getting-started.md) - Installation guide
- [Configuration](configuration.md) - Customization options
- [Testing](testing.md) - Test suite documentation
