# Testing Your Spacemacs Setup

Quick guide to verify your Spacemacs configuration is working correctly.

## Quick Test

Run the automated test suite:

```bash
cd ~/projects/dev-tools/spacemacs-rstats/tests
./run_all_tests.sh
```

**Expected:** All 59 tests pass

## Layer Verification

### Test ESS Layer

```elisp
M-x ess-version
```

**Expected:** ESS version displayed

### Test LSP Layer

1. Open R package: `cd ~/test-pkg && emacs R/utils.R`
2. Check mode line for `LSP`
3. **Expected:** LSP mode active

### Test Completion Layer

1. In R file, type: `mea`
2. **Expected:** Completion popup with `mean`, `median`

## Keybinding Tests

### Leader Key (`SPC`)

```
SPC f f    # Find file
```

**Expected:** File finder opens

### Major Mode Leader (`,`)

In R file:

```
, r r      # Insert roxygen
```

**Expected:** Roxygen skeleton inserted

## Modal Editing Test

1. Press `i` to enter insert mode
2. Type some text
3. Press `ESC` to return to normal mode
4. Press `dd` to delete line
5. **Expected:** Line deleted

## Edge Cases

The test suite verifies:

- ✅ Spacemacs layers load correctly
- ✅ Which-key integration works
- ✅ Custom functions available
- ✅ Keybindings don't conflict

## Troubleshooting

**Layers not loading:**

```bash
# Check .spacemacs
emacs ~/.spacemacs
# Verify dotspacemacs-configuration-layers includes:
# - ess
# - lsp
# - auto-completion
```

**Keybindings not working:**

```bash
# Verify which-key
M-x which-key-mode
# Press SPC and wait - should show options
```

## See Also

- [Spacemacs Learning Curriculum](02-LEARNING-CURRICULUM.md)
- [Full Testing Guide](../../tests/README.md)
- [Edge Case Testing](https://data-wise.github.io/spacemacs-rstats/edge-case-testing/)
