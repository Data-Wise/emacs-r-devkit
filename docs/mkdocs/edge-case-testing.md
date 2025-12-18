# Edge Case Testing Guide

This document describes the edge case tests included in spacemacs-rstats and how to use them for development and debugging.

## Overview

The test suite includes **16 edge case tests** designed to catch corner cases and error scenarios that could cause failures in production use.

## Test Fixtures

Test fixtures are located in `tests/fixtures/` and provide realistic edge case scenarios.

### Documentation Fixtures (`tests/fixtures/docs/`)

1. **`unclosed-code-block.md`**
   - Purpose: Test detection of malformed markdown
   - Contains: Code block without closing fence
   - Tests: `test_unclosed_code_blocks()`

2. **`broken-table.md`**
   - Purpose: Test table syntax validation
   - Contains: Table with inconsistent column counts
   - Tests: Future table validation

3. **`bad-yaml.md`**
   - Purpose: Test YAML frontmatter validation
   - Contains: Invalid YAML syntax
   - Tests: `test_yaml_frontmatter()`

4. **`missing-images.md`**
   - Purpose: Test asset reference validation
   - Contains: References to nonexistent images
   - Tests: `test_missing_images()`

### R Code Fixtures (`tests/fixtures/r/`)

5. **`empty.R`**
   - Purpose: Test handling of comment-only files
   - Contains: Only comments, no code
   - Tests: Styler edge case handling

6. **`syntax-error.R`**
   - Purpose: Test error handling with invalid R syntax
   - Contains: Missing parenthesis, wrong assignment operator
   - Tests: Styler graceful degradation

7. **`long-line.R`**
   - Purpose: Test line length limit handling
   - Contains: Lines exceeding 120 characters
   - Tests: Lintr warnings

8. **`unicode.R`**
   - Purpose: Test Unicode character support
   - Contains: Greek letters, emoji, Chinese characters
   - Tests: Styler/lintr with non-ASCII

9. **`no-violations.R`**
   - Purpose: Baseline for clean code
   - Contains: Well-formatted, documented R code
   - Tests: Lintr should return minimal violations

## Edge Case Tests by Tier

### Documentation Tests (3 edge cases)

#### `test_unclosed_code_blocks()`

**What it tests:** Detection of malformed markdown with unclosed code fences

**How it works:**

- Counts ``` markers in each markdown file
- Fails if count is odd (unclosed block)

**Example failure:**

```markdown
# Document
```python
def foo():
    return True
# Missing closing ```
```

#### `test_missing_images()`

**What it tests:** Validation of image file references

**How it works:**

- Extracts all `![alt](path)` references
- Checks if referenced files exist
- Reports as warnings (non-blocking)

**Example failure:**

```markdown
![Missing](./nonexistent.png)
```

#### `test_yaml_frontmatter()`

**What it tests:** YAML syntax in document frontmatter

**How it works:**

- Parses YAML between `---` markers
- Checks for required colons in key-value pairs
- Validates indentation

**Example failure:**

```yaml
---
title: Document
invalid yaml here
---
```

### Emacs Lisp Tests (9 edge cases)

#### Custom Function Edge Cases

**`test-roxygen-skeleton-no-function`**

- Tests roxygen insertion when no function signature found
- Verifies graceful handling (no crash)

**`test-styler-guard-nonexistent-file`**

- Tests styler with buffers that have no associated file
- Expects `nil` return (can't style unsaved buffers)

**`test-styler-toggle`**

- Tests styler enable/disable functionality
- Verifies state preservation

**`test-s7-insert-class-basic`**

- Tests S7 class insertion with mocked input
- Uses `cl-letf` to mock `read-string`

**`test-s7-insert-method-basic`**

- Tests S7 method insertion
- Validates multi-prompt handling

**`test-s7-insert-generic-basic`**

- Tests S7 generic function insertion
- Confirms template accuracy

#### Buffer State Edge Cases

**`test-r-mode-in-non-r-buffer`**

- Tests functions called in wrong major mode
- Ensures no crashes in `fundamental-mode`

**`test-styler-disabled-state`**

- Tests styler when explicitly disabled
- Verifies proper bypass behavior

**`test-empty-r-buffer`**

- Tests R mode activation in empty buffers
- Confirms clean initialization

### R Package Tests (4 edge cases)

#### `Styler handles empty R files gracefully`

**What it tests:** Styler behavior with comment-only files

**How it works:**

```r
empty_file <- tempfile(fileext = ".R")
writeLines("# Only comments", empty_file)
expect_no_error(styler::style_file(empty_file))
```

#### `Lintr returns no violations for clean code`

**What it tests:** Baseline for well-formatted code

**How it works:**

- Creates properly formatted R code
- Runs lintr
- Expects \u003c3 violations (allows minor style preferences)

#### `Styler handles syntax errors gracefully`

**What it tests:** Error handling with invalid R syntax

**How it works:**

- Creates R file with syntax error
- Runs styler with `tryCatch`
- Expects error (validates it doesn't crash)

#### `Helper script handles nonexistent files`

**What it tests:** `r-styler-check.R` error handling

**How it works:**

- Calls script with nonexistent file path
- Expects non-zero exit code

## Using Edge Case Tests for Development

### Adding New Edge Cases

1. **Create test fixture:**

   ```bash
   # Add to tests/fixtures/r/ or tests/fixtures/docs/
   echo "# Your edge case" > tests/fixtures/r/new-case.R
   ```

2. **Write test:**

   ```r
   # In test_r_packages.R
   test_that("Description of edge case", {
     # Your test logic
   })
   ```

3. **Run tests:**

   ```bash
   ./tests/run_all_tests.sh
   ```

### Debugging Failed Edge Cases

**View detailed error:**

```bash
# Check test log
cat tests/test_run.log | grep -A 20 "FAILED"
```

**Run single test:**

```bash
# Emacs Lisp
emacs --batch -l tests/test-spacemacs-rstats.el \
  -f ert-run-tests-batch-and-exit

# R
Rscript -e "testthat::test_file('tests/test_r_packages.R')"
```

## Best Practices

1. **Always test edge cases** when adding new features
2. **Use realistic fixtures** based on actual user scenarios
3. **Document expected behavior** in test comments
4. **Keep tests isolated** - no dependencies between tests
5. **Mock external dependencies** (user input, file system)

## Technical Implementation Details

### ERT Error Handling

```elisp
;; Don't use should-not-error (doesn't exist)
;; Use condition-case instead:
(should (condition-case nil
            (progn (function-call) t)
          (error nil)))
```

### Mocking User Input

```elisp
;; Use cl-letf to mock read-string:
(cl-letf (((symbol-function 'read-string)
           (lambda (prompt) "TestValue")))
  (your-function-that-calls-read-string))
```

### R Test Isolation

```r
# Always use temp files
test_file <- tempfile(fileext = ".R")
writeLines("code", test_file)
# ... test ...
unlink(test_file)  # Clean up
```

## Coverage Goals

Current edge case coverage: **~40%** of planned scenarios

**Covered:**

- ✅ Malformed markdown
- ✅ Missing assets
- ✅ Invalid YAML
- ✅ Empty R files
- ✅ R syntax errors
- ✅ Buffer state issues
- ✅ Invalid user input

**Future opportunities:**

- ⏳ Integration edge cases (missing dependencies, permissions)
- ⏳ Performance edge cases (very large files)
- ⏳ Concurrent operation edge cases

---

**See also:** [Testing Guide](testing.md) for general testing information
