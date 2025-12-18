# Spacemacs Migration Quick-Start

**From vanilla spacemacs-rstats to Spacemacs in 4 weeks**

---

## 🎯 Before You Start

**Time Commitment:** 15-30 minutes daily for 4 weeks  
**Expected Productivity Dip:** 50% (Week 1-2) → 80% (Week 3) → 120% (Week 4+)  
**Point of No Return:** Day 7 (if you make it past Week 1, you'll succeed)

---

## Week 0: Preparation (Do This First!)

### Step 1: Update Modifier Keys

Edit `~/.emacs.d/init.el` (lines 133-137):

**Change FROM:**

```elisp
(setq mac-command-modifier 'meta
      mac-option-modifier 'super
      mac-right-option-modifier nil)
```

**Change TO:**

```elisp
(setq mac-command-modifier 'super
      mac-option-modifier 'meta
      mac-right-option-modifier nil)
```

### Step 2: Practice New Mapping (2-3 days)

- `M-x` is now `Option-x` (not Command-x!)
- Use vanilla Emacs with new mapping
- Build muscle memory before Spacemacs

### Step 3: Backup Everything

```bash
# Backup current config
cp -r ~/.emacs.d ~/.emacs.d.vanilla-backup
cp ~/projects/dev-tools/spacemacs-rstats/init.el ~/init.el.backup

# Verify backup
ls -la ~/.emacs.d.vanilla-backup
```

---

## Week 1: Installation & Vim Basics

### Day 1: Install Spacemacs

```bash
# Remove current .emacs.d (it's backed up!)
mv ~/.emacs.d ~/.emacs.d.old

# Clone Spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d -b develop

# Launch
emacs
```

**First Launch Prompts:**

1. "What is your editing style?" → Press `1` (vim)
2. "Choose distribution" → Press `1` (spacemacs)
3. "What is your preferred font?" → Press Enter (default is fine)

Emacs will install packages (10-15 minutes).

### Day 2-7: Follow Curriculum Week 1

Open: `~/projects/dev-tools/spacemacs-rstats/guides/spacemacs-learning/02-LEARNING-CURRICULUM.md`

**Daily tasks:**

- Day 2: Modal editing concept
- Day 3: hjkl navigation
- Day 4: Word movement
- Day 5: Line navigation
- Day 6: Editing commands
- Day 7: Visual mode

**Print cheat sheet:** `guides/spacemacs-learning/03-CHEAT-SHEETS.md` (Week 1 section)

---

## Week 2: Spacemacs Navigation

### Day 8: Add ESS Layer

Edit `~/.spacemacs` (around line 30):

```elisp
dotspacemacs-configuration-layers
'(
  ess        ; Add this line
  osx        ; Add this line
  git
  markdown
  ;; other layers...
)
```

Save and reload: `SPC f e R`

### Day 9-14: Follow Curriculum Week 2

Learn `SPC` leader system:

- File operations (`SPC f`)
- Buffer management (`SPC b`)
- Window management (`SPC w`)
- Project navigation (`SPC p`)
- Search commands (`SPC s`)

---

## Week 3: R Development

### Day 15: Port Your Functions

Create `~/.spacemacs.d/spacemacs-rstats.el`:

```elisp
;; Copy all your custom functions from init.el
(defun spacemacs-rstats/insert-roxygen-skeleton ()
  ;; ... your code ...
)

;; ... other functions ...
(provide 'spacemacs-rstats)
```

Add to `~/.spacemacs` user-config:

```elisp
(defun dotspacemacs/user-config ()
  ;; Load your functions
  (require 'spacemacs-rstats)
  
  ;; Map to Spacemacs style
  (spacemacs/set-leader-keys-for-major-mode 'ess-r-mode
    "rr" 'spacemacs-rstats/insert-roxygen-skeleton
    "ur" 'spacemacs-rstats/usethis-use-r
    "ut" 'spacemacs-rstats/usethis-use-test
    "up" 'spacemacs-rstats/usethis-use-package-doc
    "sc" 'spacemacs-rstats/s7-insert-class
    "sm" 'spacemacs-rstats/s7-insert-method
    "sg" 'spacemacs-rstats/s7-insert-generic))
```

Now: `SPC m r r` inserts roxygen! (`, r r` also works)

### Day 16-21: Follow Curriculum Week 3

Full R package development workflow with Spacemacs.

---

## Week 4: Mastery

Follow curriculum Week 4 for advanced features.

---

## Quick Reference

### Emergency Commands

**Stuck?**

```
ESC ESC ESC  (or C-g C-g C-g)
```

**Modes:**

- Normal mode: `ESC` or `fd`
- Insert mode: `i`
- Visual mode: `v`

**Essential Spacemacs:**

- Help: `SPC h d k` (describe key)
- Find file: `SPC f f`
- Save: `SPC f s`
- Quit: `SPC q q`

### Your R Keybindings

After setup (Week 3):

```
SPC m r r   → Insert roxygen
SPC m u r   → Create R file
SPC m u t   → Create test
SPC m s c   → S7 class skeleton
SPC m e e   → Eval function/region
SPC m s     → Start R
```

Or use `,` instead of `SPC m`:

```
, r r   → Insert roxygen
, e e   → Eval code
, s     → Start R
```

---

## Troubleshooting

**"I can't type anything!"**
→ You're in Normal mode. Press `i` to enter Insert mode.

**"The keys don't match the docs!"**
→ Did you update modifier keys? `M-x` = `Option-x`, not `Command-x`

**"This is too hard!"**
→ Week 1 is hardest. Everyone feels this. Power through to Day 7.

**"I want my old Emacs back"**

```bash
mv ~/.emacs.d ~/.emacs.d.spacemacs
mv ~/.emacs.d.vanilla-backup ~/.emacs.d
```

---

## Success Timeline

- **Day 1-3:** 😫 "This is impossible"
- **Day 4-7:** 😐 "Still frustrating"
- **Day 8-14:** 🤔 "Getting there..."
- **Day 15-21:** 😊 "This is nice!"
- **Day 22-28:** 🚀 "Faster than before!"
- **Month 2+:** ⚡ "Never going back!"

---

## Next Steps

1. ✅ Complete Week 0 preparation
2. ✅ Install Spacemacs (Week 1, Day 1)
3. ✅ Open curriculum: `guides/spacemacs-learning/02-LEARNING-CURRICULUM.md`
4. ✅ Print cheat sheets: `guides/spacemacs-learning/03-CHEAT-SHEETS.md`
5. ✅ Start Day 1 lesson
6. ✅ Practice 15 minutes
7. ✅ Repeat daily

**You've got this! 💪**
