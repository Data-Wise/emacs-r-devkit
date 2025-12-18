# spacemacs-rstats Cheat Sheet (macOS)

**Focus**: Emacs keybindings only. For R workflow (`rtest`, `rdoc`, etc.), see `r-package-development` skill.

## Key Modifiers
- `C-` = **Control**
- `M-` = **Option (⌥)** ← IMPORTANT!
- `S-` = Command (⌘)
- `Shift` = Shift

---

## Survival Keys (Learn These First!)
```
C-g         Cancel/Escape (USE THIS WHEN STUCK!)
C-x C-f     Open file
C-x C-s     Save file
C-x C-c     Exit Emacs
```

---

## Movement
```
C-a / C-e       Beginning/End of line
C-n / C-p       Next/Previous line (or use arrows)
C-f / C-b       Forward/Backward character

M-f / M-b       Forward/Backward WORD (Option-f/b)
M-< / M->       Beginning/End of buffer (Option-</>)

C-v / M-v       Page down/up
M-g g           Go to line number
```

---

## Editing
```
C-SPC           Start selection (mark)
C-w             Cut (kill)
M-w             Copy (Option-w)
C-y             Paste (yank)
C-k             Cut from cursor to end of line
C-/             Undo
M-d             Delete word forward (Option-d)
```

---

## Files & Buffers
```
C-x C-f         Find file (open)
C-x C-s         Save file
C-x C-w         Save as...
C-x b           Switch buffer
C-x k           Kill (close) buffer
C-x C-b         List all buffers
```

---

## Windows
```
C-x 2           Split window horizontally
C-x 3           Split window vertically
C-x 1           Close all other windows
C-x 0           Close current window
C-x o           Switch to other window
```

---

## Search
```
C-s             Search forward (C-s again for next)
C-r             Search backward
M-%             Replace (Option-%)
```

---

## Help
```
C-h k           Describe key (what does this key do?)
C-h f           Describe function
C-h v           Describe variable
C-h e           Show messages buffer
C-h m           Describe current mode
```

---

## R Development (spacemacs-rstats)
```
PREFIX: C-c r   (Press and wait to see all options)

C-c r r         Insert roxygen skeleton
C-c r u         Create R file (usethis::use_r)
C-c r t         Create test file (usethis::use_test)
C-c r p         Create package doc
C-c r s c       Insert S7 class
C-c r s m       Insert S7 method
C-c r s g       Insert S7 generic
C-c r S         Toggle styler on/off
C-c r P         Export PATH (macOS)
```

---

## ESS (R Mode)
```
M-x R           Start R console (Option-x, type R)
C-RET           Send line/region to R
C-c C-c         Send function to R
C-c C-b         Send buffer to R
C-c C-z         Switch to R console
C-c C-l         Load file in R
```

---

## Flycheck (Syntax Checking)
```
C-c ! l         List all errors/warnings
C-c ! n         Next error
C-c ! p         Previous error
C-c ! ?         Describe checker
```

---

## LSP (Language Server)
```
M-.             Go to definition (Option-.)
M-,             Go back (Option-,)
M-?             Find references (Option-?)
C-c l r r       Rename symbol
```

---

## Company (Completion)
```
Just type - suggestions appear automatically
C-n / C-p       Navigate suggestions
TAB or RET      Accept completion
C-g             Cancel
```

---

## Magit (Git)
```
C-x g           Magit status

In Magit buffer:
s               Stage file
u               Unstage file
c c             Commit
P p             Push
F p             Pull
q               Quit magit
```

**Note**: For quick terminal git, use your zsh aliases:
- `gst` (status), `ga .` (add), `gcmsg "msg"` (commit)
- `rpkgcommit "msg"` for R packages (includes validation)

---

## Projectile
```
C-c p f         Find file in project
C-c p p         Switch project
C-c p s s       Search in project
```

---

## Common Mistakes
1. **Using Command (⌘) instead of Option (⌥)** for M- keys
2. **Forgetting to hold Control** in sequences like `C-x C-f`
3. **Not using C-g to escape** when stuck
4. **Trying to use mouse** - learn keyboard first!

---

## Emergency Recovery
```
C-g C-g C-g     Cancel everything!
M-x recovery    Recover lost file
C-/             Undo
C-x u           Undo (alternative)
```

---

**Remember:** Practice makes perfect! Start with just the Survival Keys, then gradually add more.

**Pro tip:** Keep this cheat sheet visible on your desk while learning!
