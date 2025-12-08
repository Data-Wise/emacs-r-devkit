---
name: Bug Report
about: Report a bug or issue with emacs-r-devkit
title: '[BUG] '
labels: bug
assignees: ''
---

## Bug Description

A clear and concise description of what the bug is.

## Steps to Reproduce

1. Start Emacs with '...'
2. Open file '....'
3. Execute command '....'
4. See error

## Expected Behavior

What you expected to happen.

## Actual Behavior

What actually happened.

## Environment

**System Information:**
- macOS Version: [e.g., macOS 14.0 Sonoma]
- Emacs Version: [Run `M-x emacs-version`]
- R Version: [Run `R --version` in terminal]

**emacs-r-devkit:**
- Installation Method: [installer script / manual]
- Last Update: [approximate date or commit]

**Installed R Packages:**
```r
# Run in R and paste output:
packageVersion("devtools")
packageVersion("usethis")
packageVersion("lintr")
packageVersion("styler")
packageVersion("languageserver")
```

## Error Messages

**From Emacs `*Messages*` buffer (C-h e):**
```
Paste error messages here
```

**From R console:**
```
Paste R errors here if applicable
```

**From Flycheck (C-c ! l):**
```
Paste Flycheck errors here if applicable
```

## Additional Context

- Screenshots (if applicable)
- Minimal reproducible example
- Workarounds you've tried
- Links to related issues

## Checklist

- [ ] I've run `./check-dependencies.sh` and all dependencies are installed
- [ ] I've checked existing issues for duplicates
- [ ] I've tested with `emacs -Q` to rule out other package conflicts
- [ ] I've included full error messages from `*Messages*` buffer
