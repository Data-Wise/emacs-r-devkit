# Test Suite

Comprehensive test suite for emacs-r-devkit.

## Test Suites

### A) Documentation Tests (`test_documentation.py`)

- Link validation (internal and external)
- Markdown syntax validation
- Code block language specification
- MkDocs build verification
- Cross-reference validation

**Run:** `./run_doc_tests.sh`

### B) Emacs Lisp Tests (`test-emacs-r-devkit.el`)

- Configuration tests (layers, ESS, company)
- Custom function tests (roxygen, styler, S7)
- Keybinding tests
- Mode activation tests
- LSP backend tests
- Helper script tests

**Run:** `./run_elisp_tests.sh`

### C) R Package Tests (`test_r_packages.R`)

- Required package installation
- Styler functionality
- Lintr functionality
- Roxygen2 functionality
- Language server availability
- Helper script functionality
- devtools/usethis functions

**Run:** `Rscript test_r_packages.R`

### D) Integration Tests (`test_integration.sh`)

- Spacemacs configuration exists
- Helper scripts present and executable
- R availability and version
- Required R packages installed
- Emacs functionality
- Documentation builds

**Run:** `./test_integration.sh`

## Running All Tests

```bash
./run_all_tests.sh
```

This runs all test suites in order and provides a summary.

## Requirements

### Python

- Python 3.6+
- No additional packages required

### R

- R 4.0+
- testthat package

### Optional

- markdownlint (for enhanced markdown checking)
- markdown-link-check (for link validation)

## Test Output

Tests use color-coded output:

- 🟢 Green = Pass
- 🔴 Red = Fail
- 🟡 Yellow = Warning

## CI/CD Integration

These tests can be integrated into GitHub Actions:

```yaml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run tests
        run: cd tests && ./run_all_tests.sh
```

## Adding New Tests

### Documentation Tests

Add test methods to `DocumentationTester` class in `test_documentation.py`.

### Emacs Lisp Tests

Add `ert-deftest` definitions to `test-emacs-r-devkit.el`.

### R Package Tests

Add `test_that` blocks to `test_r_packages.R`.

### Integration Tests

Add test sections to `test_integration.sh`.

## Troubleshooting

### Documentation tests fail

- Ensure you're running from project root
- Check mkdocs.yml exists
- Verify all referenced files exist

### Emacs tests fail

- Ensure Spacemacs is installed
- Check ~/.spacemacs exists
- Verify ESS and other packages are installed

### R tests fail

- Install required R packages: `install.packages(c("devtools", "usethis", "roxygen2", "testthat", "lintr", "styler", "languageserver"))`
- Check R is in PATH

### Integration tests fail

- Follow installation guide in docs
- Verify all dependencies are installed
