# Project Structure

**Organization of emacs-r-devkit repository**

This document explains the file and folder organization of the emacs-r-devkit project.

---

## 📂 Directory Structure

```text
emacs-r-devkit/
├── .github/                # GitHub configuration
│   ├── workflows/          # CI/CD workflows (MkDocs deployment)
│   ├── ISSUE_TEMPLATE/     # Issue templates
│   └── pull_request_template.md
│
├── .claude/                # Claude Code project settings
│   └── CLAUDE.md           # Project instructions for Claude
│
├── assets/                 # Media files
│   ├── screenshots/        # Project screenshots
│   └── README.md
│
├── bin/                    # Helper scripts
│   ├── export-gui-path.sh  # PATH exporter for macOS GUI Emacs
│   ├── r-styler-check.R    # External Flycheck checker for styler
│   └── ...
│
├── docs/                   # Legacy documentation (may be removed)
│   └── USAGE.md
│
├── docs_mkdocs/            # MkDocs website content
│   ├── index.md            # Homepage
│   ├── getting-started.md  # Installation guide
│   ├── features.md         # Features documentation
│   ├── keybindings.md      # Keybinding reference
│   ├── configuration.md    # Configuration guide
│   ├── troubleshooting.md  # Troubleshooting guide
│   └── testing.md          # Testing guide
│
├── guides/                 # User guides and documentation
│   ├── TUTORIAL.md         # Complete user guide
│   ├── CHEAT-SHEET.md      # Quick reference
│   ├── TROUBLESHOOTING.md  # Problem solving
│   └── README.md
│
├── snippets/               # Emacs snippets
│   └── ess-mode/           # ESS mode snippets (S7, etc.)
│
├── standards/              # Documentation standards (Data-Wise)
│   ├── DOCUMENTATION_STANDARDS.md      # MkDocs standards
│   ├── MEDIATIONVERSE_STANDARDS.md     # R package standards
│   ├── DOCUMENTATION_README.md         # Master overview
│   ├── DOCUMENTATION_INVENTORY.md      # Repository inventory
│   ├── IMPLEMENTATION_PLAN.md          # Rollout plan
│   ├── mkdocs-base.yml                 # Shared MkDocs config
│   └── README.md
│
├── tests/                  # Test files and verification
│   ├── test-features.R     # Feature testing script
│   ├── test-roxygen.R      # Roxygen testing
│   ├── TEST-CHECKLIST.md   # Verification checklist
│   └── README.md
│
├── .gitignore              # Git ignore rules
├── .lintr                  # Lintr configuration
├── check-dependencies.sh   # Dependency verification script
├── CONTRIBUTING.md         # Contribution guidelines
├── emacs-r-devkit.code-workspace  # VS Code workspace
├── init.el                 # Main Emacs configuration
├── install-init.sh         # Installation script
├── KNOWLEDGE_INDEX.md      # Central knowledge map
├── LEARNINGS.md            # Daily insights & patterns
├── LICENSE                 # MIT License
├── mkdocs.yml              # MkDocs configuration
├── PROJECT_STRUCTURE.md    # This file
├── ROADMAP.md              # Project roadmap
├── CHANGELOG.md            # Version history
└── README.md               # Main project README
```

---

## 📋 File Organization Principles

### Root Level

**Only essential files** that must be in root:

- Configuration files (`init.el`, `mkdocs.yml`, `.gitignore`, `.lintr`)
- Entry point scripts (`install-init.sh`, `check-dependencies.sh`)
- Documentation files (`README.md`, `CONTRIBUTING.md`, `LICENSE`)
- Coordination files (`KNOWLEDGE_INDEX.md`, `ROADMAP.md`, `CHANGELOG.md`, `LEARNINGS.md`)
- Workspace files (`emacs-r-devkit.code-workspace`)

### Grouped by Purpose

**Related files in dedicated folders:**

- **guides/** - User-facing documentation (tutorials, references, troubleshooting)
- **tests/** - Testing and verification resources
- **standards/** - Documentation standards for Data-Wise projects
- **assets/** - Media files (screenshots, images)
- **bin/** - Executable scripts and helpers
- **snippets/** - Code snippets for Emacs
- **docs_mkdocs/** - MkDocs website content

### Clear Separation

- **Project files** vs **standards files** (standards/ is for cross-project documentation)
- **Source** vs **tests** vs **documentation**
- **Runtime** vs **build-time** resources

---

## 🎯 Finding What You Need

### "I want to install and use emacs-r-devkit"

→ Start with [README.md](README.md)
→ Then [guides/TUTORIAL.md](guides/TUTORIAL.md)
→ Use [guides/CHEAT-SHEET.md](guides/CHEAT-SHEET.md) for quick reference

### "I need to verify my installation"

→ Run `./check-dependencies.sh`
→ Follow [tests/TEST-CHECKLIST.md](tests/TEST-CHECKLIST.md)
→ Test with [tests/test-features.R](tests/test-features.R)

### "I want to customize my setup"

→ Check [docs_mkdocs/configuration.md](docs_mkdocs/configuration.md)
→ Edit `init.el` (main configuration file)
→ See [guides/TUTORIAL.md](guides/TUTORIAL.md) for examples

### "I'm having problems"

→ [guides/TROUBLESHOOTING.md](guides/TROUBLESHOOTING.md)
→ Run `./check-dependencies.sh`
→ Check [GitHub Issues](https://github.com/Data-Wise/emacs-r-devkit/issues)

### "I want to document other projects"

→ See [standards/](standards/)
→ Read [standards/DOCUMENTATION_README.md](standards/DOCUMENTATION_README.md)
→ Use Claude skill: `data-wise-documentation`

### "I want to contribute"

→ Read [CONTRIBUTING.md](CONTRIBUTING.md)
→ Check [tests/](tests/) for verification
→ Follow existing patterns in codebase

---

## 🔄 Changes from Previous Structure

### Reorganized (2025-12-07)

**Before:**

```text
emacs-r-devkit/
├── TUTORIAL.md
├── CHEAT-SHEET.md
├── TROUBLESHOOTING.md
├── TEST-CHECKLIST.md
├── test-features.R
├── test-roxygen.R
├── DOCUMENTATION_STANDARDS.md
├── MEDIATIONVERSE_STANDARDS.md
├── DOCUMENTATION_*.md
├── mkdocs-base.yml
├── Screenshot *.png
└── ... (30+ files in root)
```

**After:**

```
emacs-r-devkit/
├── guides/                # User documentation
├── tests/                 # Test files
├── standards/             # Documentation standards
├── assets/                # Media files
└── ... (13 files in root)
```

### Benefits

- ✅ Cleaner root directory (30+ files → 13 essential files)
- ✅ Logical grouping (guides, tests, standards, assets)
- ✅ Clear separation of concerns
- ✅ Easier to navigate and find files
- ✅ Better organization for future growth
- ✅ README in each folder for context

---

## 📝 Maintenance

### Adding New Files

**User guides/documentation:**
→ Add to `guides/`

**Test scripts or checklists:**
→ Add to `tests/`

**Screenshots or images:**
→ Add to `assets/screenshots/`

**Documentation standards:**
→ Add to `standards/`

**Helper scripts:**
→ Add to `bin/`

**Website content:**
→ Add to `docs_mkdocs/`

### Updating Structure

1. Move files with `git mv` to preserve history
2. Update references in documentation
3. Add README to new folders
4. Test links and paths
5. Update this file (PROJECT_STRUCTURE.md)

---

## 🔗 Related

**Main README:** [README.md](README.md)
**Contributing:** [CONTRIBUTING.md](CONTRIBUTING.md)
**Documentation:** <https://data-wise.github.io/emacs-r-devkit/>

---

**Version:** 2.1
**Last Updated:** 2025-12-09
**Maintained by:** Data-Wise
