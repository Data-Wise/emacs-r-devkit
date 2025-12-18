# Testing Guide

> **TL;DR:** Run all tests: `./tests/run_all_tests.sh`  
> Or individual suites: `pytest tests/test_documentation.py -v`

The spacemacs-rstats includes comprehensive testing infrastructure with 88 automated tests.

## Test Suites

### 1. Unit Tests (69 tests)

**Documentation Tests** (Python, 8 tests)

```bash
pytest tests/test_documentation.py -v
```

**Emacs Lisp Tests** (ERT, 25 tests)

```bash
emacs --batch -l tests/test-spacemacs-rstats.el -f ert-run-tests-batch-and-exit
```

**R Package Tests** (testthat, 20 tests)

```bash
Rscript tests/test_r_packages.R
```

**Integration Tests** (Bash, 6 tests)

```bash
./tests/test_integration.sh
```

### 2. Pre-Flight Tests (10 tests)

Tests for the pre-flight check system:

```bash
./tests/test_preflight.sh
```

Tests:

- --pre-flight flag exists
- --auto-fix flag exists
- System requirement checks
- Already-installed detection
- Clear options when installed
- Install.sh integration

### 3. Fixture Tests (5 tests)

Fast tests using mock environments:

```bash
# Create fixtures first
./scripts/create-test-fixtures.sh

# Run fixture tests
./tests/test_with_fixtures.sh
```

Fixtures:

- `fresh/` - Nothing installed
- `emacs-only/` - Emacs but no Spacemacs
- `installed/` - Complete installation
- `conflicting/` - Multiple Emacs versions
- `corrupted/` - Broken installation
- `spacemacs-vanilla/` - Vanilla Spacemacs

### 4. CI/CD Tests (4 jobs)

Automated testing via GitHub Actions on every push:

- Pre-flight check tests
- Fixture-based tests
- Fresh installation test
- All test suites

View results: [GitHub Actions](https://github.com/Data-Wise/spacemacs-rstats/actions)

## Running All Tests

```bash
# Run all local tests
pytest tests/test_documentation.py -v
Rscript tests/test_r_packages.R
./tests/test_integration.sh
./tests/test_preflight.sh
./tests/test_with_fixtures.sh
```

## Sandbox Testing

For safe testing without affecting your system:

### Test Fixtures (Fast - 5 seconds)

```bash
# Create mock environments
./scripts/create-test-fixtures.sh

# Test with fixtures
export HOME="$PWD/tests/fixtures/fresh"
./scripts/health-check.sh
```

### GitHub Actions (Automated)

Tests run automatically on macOS-latest for every push to `main` or `dev`.

### Temporary User (Manual)

For full integration testing:

```bash
# Create test user
sudo dscl . -create /Users/emacs-test
# ... (see sandbox testing guide)

# Test installation
su - emacs-test
git clone https://github.com/Data-Wise/spacemacs-rstats.git
cd spacemacs-rstats
./scripts/install.sh

# Clean up
sudo dscl . -delete /Users/emacs-test
sudo rm -rf /Users/emacs-test
```

## Test Coverage

- **Total Tests**: 88
- **Unit Tests**: 69 (Documentation, Elisp, R, Integration)
- **Pre-Flight Tests**: 10
- **Fixture Tests**: 5
- **CI/CD Jobs**: 4
- **Pass Rate**: 100%

## Writing New Tests

### Documentation Tests

Add to `tests/test_documentation.py`:

```python
def test_new_feature():
    """Test new documentation feature."""
    assert condition
```

### Pre-Flight Tests

Add to `tests/test_preflight.sh`:

```bash
test_new_preflight_feature() {
    echo "Testing new feature..."
    assert_output_contains "expected" "$output" "Test description"
}
```

### Fixture Tests

1. Add fixture to `scripts/create-test-fixtures.sh`
2. Add test to `tests/test_with_fixtures.sh`

## Continuous Integration

Tests run automatically on:

- Every push to `main` or `dev`
- Every pull request
- macOS-latest runner (true macOS environment)

View workflow: `.github/workflows/test-installation.yml`

## See Also

- [Installation Management](installation-management.md) - Installation system docs
- [Troubleshooting](troubleshooting.md) - Common issues
- [Contributing](../CONTRIBUTING.md) - Development guidelines
