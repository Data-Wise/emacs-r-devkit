#!/usr/bin/env Rscript
#
# R Package Tests for emacs-r-devkit
#
# Tests:
# 1. Required R packages are installed
# 2. Helper scripts work correctly
# 3. R languageserver is functional
#

library(testthat)

# Test 1: Required packages
test_that("Required R packages are installed", {
    required_packages <- c(
        "devtools",
        "usethis",
        "roxygen2",
        "testthat",
        "lintr",
        "styler",
        "languageserver"
    )

    for (pkg in required_packages) {
        expect_true(
            requireNamespace(pkg, quietly = TRUE),
            info = paste(pkg, "is installed")
        )
    }
})

# Test 2: Styler functionality
test_that("Styler can format R code", {
    skip_if_not_installed("styler")

    messy_code <- "x=1+2"
    styled <- styler::style_text(messy_code)

    expect_true(length(styled) > 0)
    expect_match(as.character(styled), "x <- 1 \\+ 2")
})

# Test 3: Lintr functionality
test_that("Lintr can check R code", {
    skip_if_not_installed("lintr")

    bad_code <- tempfile(fileext = ".R")
    writeLines("x=1+2", bad_code)

    lints <- lintr::lint(bad_code)

    expect_true(length(lints) > 0)

    unlink(bad_code)
})

# Test 4: Roxygen2 functionality
test_that("Roxygen2 can parse documentation", {
    skip_if_not_installed("roxygen2")

    test_func <- "
#' Test Function
#'
#' @param x A number
#' @return The number plus one
#' @export
test_func <- function(x) {
  x + 1
}
"

    temp_file <- tempfile(fileext = ".R")
    writeLines(test_func, temp_file)

    # Parse roxygen comments
    blocks <- roxygen2::parse_file(temp_file)

    expect_true(length(blocks) > 0)

    unlink(temp_file)
})

# Test 5: Language server
test_that("Language server package is available", {
    skip_if_not_installed("languageserver")

    expect_true(
        "languageserver" %in% loadedNamespaces() ||
            requireNamespace("languageserver", quietly = TRUE)
    )
})

# Test 6: Helper script - r-styler-check.R
test_that("r-styler-check.R script exists and works", {
    skip_if_not_installed("styler")

    script_path <- "~/.emacs.d/bin/r-styler-check.R"
    script_path <- path.expand(script_path)

    skip_if_not(file.exists(script_path), "Helper script not found")

    # Create test file
    test_file <- tempfile(fileext = ".R")
    writeLines("x <- 1 + 2", test_file)

    # Run styler check
    result <- system2(
        "Rscript",
        c(script_path, test_file),
        stdout = TRUE,
        stderr = TRUE
    )

    expect_true(attr(result, "status") %in% c(0, 1, NULL))

    unlink(test_file)
})

# Test 7: devtools functionality
test_that("devtools can load packages", {
    skip_if_not_installed("devtools")

    expect_true(
        is.function(devtools::load_all)
    )
})

# Test 8: usethis functionality
test_that("usethis functions are available", {
    skip_if_not_installed("usethis")

    expect_true(is.function(usethis::use_r))
    expect_true(is.function(usethis::use_test))
})

# Run tests
cat("\n🧪 Running R Package Tests\n")
cat("==========================\n\n")

test_results <- test_dir(".", reporter = "summary")

cat("\n✅ R package tests complete!\n")
