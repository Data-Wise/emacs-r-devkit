# emacs-r-devkit

**Context for Gemini Agent**

## Project Overview
`emacs-r-devkit` is a professional Emacs integrated development environment (IDE) configuration tailored for R package development on macOS. It provides a pre-configured, batteries-included setup that integrates ESS (Emacs Speaks Statistics), LSP (Language Server Protocol), and modern Emacs packages to rival commercial IDEs.

**Key Goals:**
- Provide a robust R package development workflow (devtools, testthat, roxygen2).
- Automate tedious tasks like formatting (styler), documentation (roxygen2 skeletons), and dependency checking.
- Seamless integration with macOS (PATH synchronization, keybindings).
- Support for modern R features like the S7 object-oriented system.

## Technical Stack
- **Core:** GNU Emacs (Lisp), R (4.0+), Shell (Bash).
- **Emacs Packages:** ESS, LSP Mode, Flycheck, Company, Magit, Vertico, Consult, Marginalia.
- **R Tooling:** `lintr`, `styler`, `roxygen2`, `languageserver`, `s7`.
- **Documentation:** MkDocs (Material theme).
- **CI/CD:** GitHub Actions (for documentation deployment).

## Architecture & Directory Structure
- **`init.el`**: The single-file, comprehensive Emacs configuration.
- **`bin/`**: Helper scripts (e.g., `export-gui-path.sh` for macOS PATH sync, `r-styler-check.R`).
- **`guides/`**: User-facing documentation (Tutorials, Cheat Sheets).
- **`docs_mkdocs/`**: Source files for the static documentation site.
- **`tests/`**: Verification scripts (`test-features.R`) and checklists.
- **`standards/`**: Documentation standards and templates for the ecosystem.

## Building and Running

### Installation
The project is designed to be installed into `~/.emacs.d/`.

```bash
# Standard installation
./install-init.sh
```

### Verification
Always verify the environment after installation or changes.

```bash
# Check system and R dependencies
./check-dependencies.sh
```

### Running
- **Terminal:** `emacs`
- **GUI:** `open -a Emacs` (or launch via Spotlight)

### Documentation
The documentation site is built with MkDocs.

```bash
# Preview locally
mkdocs serve

# Build static site
mkdocs build
```

## Development Conventions

### Branching Strategy
- **`main`**: Stable, production-ready code.
- **`dev`**: Active development branch. All feature branches should target `dev`.
- **`feature/*`**: Feature branches.

### Commit Messages
Follow [Conventional Commits](https://www.conventionalcommits.org/):
- `feat:` New features.
- `fix:` Bug fixes.
- `docs:` Documentation changes.
- `chore:` Maintenance, dependency updates.

### Code Style
- **R:** Tidyverse style guide. Enforced by `lintr` and `styler`.
- **Emacs Lisp:** Standard conventions. Custom functions must be prefixed with `emacs-r-devkit/`.

### Testing
- **Automated Checks:** `check-dependencies.sh` ensures the environment is correct.
- **Interactive Testing:** Use `tests/test-features.R` inside Emacs to verify IDE features (completion, linting, etc.).
- **Manual Verification:** Follow `tests/TEST-CHECKLIST.md` before merging PRs.

## Key Configuration Details (`init.el`)
- **Package Management:** Uses `package.el` and `use-package`.
- **macOS Integration:** `exec-path-from-shell` ensures GUI Emacs inherits the shell environment.
- **Custom Functions:**
    - `emacs-r-devkit/insert-roxygen-skeleton`: Smart doc insertion.
    - `emacs-r-devkit/style-buffer-with-guard`: Safe auto-formatting.
    - `emacs-r-devkit/s7-*`: Snippets for S7 OOP.
