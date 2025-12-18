# test-features.R
# Test file for emacs-r-devkit features
#
# HOW TO USE THIS FILE:
# 1. Open in Emacs: C-x C-f test-features.R
# 2. Follow the test instructions below
# 3. Each section tests different features

# ==============================================================================
# TEST 1: Smart Roxygen Insertion (C-c r r)
# ==============================================================================
# INSTRUCTIONS:
# 1. Place cursor on the line ABOVE the function below
# 2. Press: C-c r r
# 3. Should insert roxygen skeleton with @param for x, y, z

calculate_sum <- function(x, y, z = 0) {
  x + y + z
}


# TEST 2: Roxygen with Selected Examples (C-c r r)
# INSTRUCTIONS:
# 1. Select the next 2 lines (mark with C-SPC, move down)
# 2. Press: C-c r r
# 3. Should insert roxygen with selected lines in @examples

# result <- multiply_values(5, 10)
# print(result)

multiply_values <- function(a, b) {
  a * b
}


# ==============================================================================
# TEST 3: Styler Auto-formatting (Save with C-x C-s)
# ==============================================================================
# INSTRUCTIONS:
# 1. The code below is poorly formatted
# 2. Save the file with: C-x C-s
# 3. Styler should auto-format it (if enabled)
# 4. Toggle styler with: C-c r S

badly_formatted<-function(x,y){
if(x>0){
return(x+y)
}else{
return(x-y)
}}


# TEST 4: Check Flycheck is working
# INSTRUCTIONS:
# 1. Look for "FlyC" in the mode line (bottom of window)
# 2. This line below should trigger a lintr warning (line too long)
very_long_variable_name <- "This is an extremely long line that exceeds 120 characters and should trigger a lintr warning about line length"

# This should trigger a styler warning if you have the custom checker enabled
bad_spacing<-function( x ){x+1}


# ==============================================================================
# TEST 5: S7 Class Skeleton (C-c r s c)
# ==============================================================================
# INSTRUCTIONS:
# 1. Position cursor below this comment
# 2. Press: C-c r s c
# 3. Enter class name: "Person"
# 4. Should insert S7 class skeleton



# ==============================================================================
# TEST 6: S7 Generic Function (C-c r s g)
# ==============================================================================
# INSTRUCTIONS:
# 1. Position cursor below this comment
# 2. Press: C-c r s g
# 3. Enter generic name: "greet"
# 4. Should insert S7 generic skeleton



# ==============================================================================
# TEST 7: S7 Method (C-c r s m)
# ==============================================================================
# INSTRUCTIONS:
# 1. Position cursor below this comment
# 2. Press: C-c r s m
# 3. Enter generic name: "greet"
# 4. Enter class name: "Person"
# 5. Should insert S7 method skeleton



# ==============================================================================
# TEST 8: LSP Features (if languageserver package installed)
# ==============================================================================
# INSTRUCTIONS:
# 1. Type: libr and wait - should see completion suggestions
# 2. Hover over 'mean' below - should see documentation (if mouse enabled)
# 3. M-. on 'mean' - should offer to go to definition

test_lsp <- function() {
  x <- c(1, 2, 3, 4, 5)
  mean(x)
}


# ==============================================================================
# TEST 9: Company Completion
# ==============================================================================
# INSTRUCTIONS:
# 1. Type: dat and wait - should see completion popup
# 2. Use C-n/C-p to navigate, TAB to complete

test_completion <- function() {
  # Type here: dat[wait for completion]

}


# ==============================================================================
# TEST 10: Which-Key Helper
# ==============================================================================
# INSTRUCTIONS:
# 1. Press: C-c r (and wait)
# 2. Should see popup showing all available r-devkit commands:
#    r = insert roxygen
#    u = use_r
#    t = use_test
#    p = use_package_doc
#    s = S7 submenu
#    S = toggle styler
#    P = export GUI path


# ==============================================================================
# TEST 11: Sample S7 Code (for reference)
# ==============================================================================
# Example S7 class definition (properly formatted)

if (requireNamespace("s7", quietly = TRUE)) {
  library(s7)

  # Define a simple S7 class
  Point <- s7::new_class(
    "Point",
    properties = list(
      x = class_numeric,
      y = class_numeric
    ),
    validator = function(self) {
      if (length(self@x) != 1 || length(self@y) != 1) {
        "x and y must be length 1"
      }
    }
  )

  # Create a generic
  distance <- s7::new_generic("distance", "x")

  # Define a method
  s7::method(distance, Point) <- function(x) {
    sqrt(x@x^2 + x@y^2)
  }

  # Test it
  p <- Point(x = 3, y = 4)
  # distance(p)  # Should return 5
}


# ==============================================================================
# TEST 12: Toggle Styler (C-c r S)
# ==============================================================================
# INSTRUCTIONS:
# 1. Press: C-c r S
# 2. Should see message: "Styler on save: disabled"
# 3. Press: C-c r S again
# 4. Should see message: "Styler on save: enabled"


# ==============================================================================
# TEST 13: Verify Helper Scripts
# ==============================================================================
# INSTRUCTIONS:
# Run these in terminal to verify helper scripts work:
#
# Test styler checker:
# Rscript ~/.emacs.d/bin/r-styler-check.R test-features.R
#
# Test PATH export (macOS only):
# ~/.emacs.d/bin/export-gui-path.sh


# ==============================================================================
# EXPECTED BEHAVIOR CHECKLIST
# ==============================================================================
# After opening this file in Emacs, you should see:
#
# Mode line (bottom) should show:
# - ESS[R] or similar (ESS mode active)
# - FlyC (Flycheck active)
# - LSP or lsp (if languageserver installed)
# - Company (completion active)
#
# Available keybindings (press C-c r to see):
# - C-c r r : Insert roxygen skeleton
# - C-c r u : usethis::use_r()
# - C-c r t : usethis::use_test()
# - C-c r p : usethis::use_package_doc()
# - C-c r s c : Insert S7 class
# - C-c r s m : Insert S7 method
# - C-c r s g : Insert S7 generic
# - C-c r S : Toggle styler on/off
# - C-c r P : Export GUI PATH (macOS)
#
# Auto-formatting:
# - Save file (C-x C-s) should auto-format with styler (if enabled)
# - Styler errors should prevent save and show error message
#
# Syntax checking:
# - Red/yellow underlines on problematic code
# - C-c ! l to list all errors
# - C-c ! n/p to navigate errors
#
# LSP features (if languageserver installed):
# - M-. : Go to definition
# - M-? : Find references
# - C-c l : LSP command prefix
# - Hover for documentation


# ==============================================================================
# END OF TESTS
# ==============================================================================
# If all tests work, your emacs-r-devkit installation is successful!
