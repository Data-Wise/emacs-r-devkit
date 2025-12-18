# Tooling Plan: Data Validation Module Support in spacemacs-rstats

**Objective:** Enhance `spacemacs-rstats` to provide first-class support for building robust data validation modules using S7 and `checkmate`.

This plan focuses on the **Editor Support** layer—what we need to add to Emacs to make writing the validation code faster and less error-prone.

---

## 1. 🧩 S7 Snippets for Validation

We need to add specific Yasnippet snippets to `snippets/ess-mode/` to generate the boilerplate for validation classes.

### A. Validator Class (`s7val`)
**Trigger:** `s7val`
**Output:**
```r
${1:Name}Validator <- S7::new_class(
  "${1:Name}Validator",
  parent = Validator,
  properties = list(
    ${2:param} = S7::class_${3:double}
  ),
  validator = function(self) {
    ${4:# Validation logic}
  }
)
```

### B. Schema Definition (`s7schema`)
**Trigger:** `s7schema`
**Output:**
```r
${1:Dataset}Schema <- S7::new_class(
  "${1:Dataset}Schema",
  properties = list(
    fields = S7::class_list,
    strict = S7::new_property(class_logical, default = TRUE)
  )
)
```

### C. Validation Method (`s7method_val`)
**Trigger:** `s7mval`
**Output:**
```r
S7::method(validate, ${1:ValidatorClass}) <- function(x, data, ...) {
  checkmate::assert_data_frame(data)
  # ${2:Implementation}
}
```

---

## 2. 🧪 Test Generation Helpers

Enhance `test-features.R` or creating a new helper function in `init.el` to scaffold validation tests.

**Proposed Function:** `spacemacs-rstats/insert-validation-test`
**Keybinding:** `C-c r t v` (Test Validation)
**Action:** Inserts a `testthat` block specifically for validation edge cases.

```r
test_that("${1:Schema} validation works", {
  # Valid data
  valid_data <- data.frame(${2:...})
  expect_silent(validate(schema, valid_data))

  # Invalid data (Type error)
  invalid_type <- valid_data
  invalid_type$col <- "wrong"
  expect_error(validate(schema, invalid_type), "Type mismatch")

  # Invalid data (Range error)
  invalid_range <- valid_data
  invalid_range$col <- -1
  expect_error(validate(schema, invalid_range), "Range error")
})
```

---

## 3. 🛠️ Project Template Enhancement

Update `bin/r-styler-check.R` or similar tooling to ensure `checkmate` and `S7` are recognized and styled correctly.

*   **Action:** Verify `styler` configuration handles S7 method syntax correctly (S7 is newer, sometimes requires specific styling rules).

---

## 4. 📚 Documentation

Add a section to `guides/TUTORIAL.md` on "Workflow: Building Type-Safe Packages".

**Content Outline:**
1.  Define the S7 Schema class (`C-c r s c`).
2.  Define Validators (`s7val` snippet).
3.  Generate validation tests (`C-c r t v`).
4.  Run tests (`C-c r t`).

---

## 5. ✅ Implementation Checklist

- [ ] Create `snippets/ess-mode/s7-validation.yasnippet`
- [ ] Implement `spacemacs-rstats/insert-validation-test` in `init.el`
- [ ] Bind `C-c r t v`
- [ ] Document the workflow in `guides/`

**Status:** Plan Drafted
**Date:** 2025-12-10
