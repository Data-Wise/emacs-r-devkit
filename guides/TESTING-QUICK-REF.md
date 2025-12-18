# Testing Guide

Quick reference for running the spacemacs-rstats test suite.

## Quick Start

Run all tests:

```bash
cd tests
./run_all_tests.sh
```

Expected: All 59 tests pass (100% success rate)

## Test Tiers

### A: Documentation (8 tests)

```bash
python3 tests/test_documentation.py
```

- Link validation
- Markdown syntax
- Code blocks
- **Edge cases:** Unclosed blocks, missing images, invalid YAML

### B: Emacs Lisp (25 tests)

```bash
tests/run_elisp_tests.sh
```

- Package loading
- Custom functions
- Keybindings
- **Edge cases:** Error handling, buffer states, invalid input

### C: R Packages (20 tests)

```bash
Rscript -e "testthat::test_file('tests/test_r_packages.R')"
```

- Required packages
- Styler/lintr
- Roxygen2
- **Edge cases:** Empty files, syntax errors, nonexistent files

### D: Integration (6 tests)

```bash
tests/test_integration.sh
```

- Spacemacs config
- Helper scripts
- R availability
- End-to-end workflows

## Edge Case Tests

**16 edge case tests** with **9 test fixtures** in `tests/fixtures/`:

**Documentation:**

- `unclosed-code-block.md` - Malformed markdown
- `bad-yaml.md` - Invalid YAML frontmatter
- `missing-images.md` - Broken image references

**R Code:**

- `empty.R` - Comment-only files
- `syntax-error.R` - Invalid R syntax
- `unicode.R` - Unicode characters
- `no-violations.R` - Clean code baseline

## Test Output

View results:

```bash
cat tests/test_run.log
```

## CI/CD

Exit codes:

- `0` = All tests passed
- `1` = One or more suites failed

---

**See also:**

- [Full Testing Guide](../docs_mkdocs/testing.md)
- [Edge Case Testing Guide](../docs_mkdocs/edge-case-testing.md)
