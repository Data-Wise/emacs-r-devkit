# Spacemacs Learning Curriculum for Beginners

**A 4-week progressive learning path from Vim beginner to productive Spacemacs R developer**

---

## 📋 Curriculum Overview

### Learning Philosophy

- **One concept per day** - Don't overwhelm yourself
- **Practice before moving on** - Muscle memory is key
- **R-focused examples** - Use your actual workflow
- **15-30 minutes daily** - Consistency over intensity

### Week-by-Week Goals

1. **Week 1:** Vim basics (modal editing fundamentals)
2. **Week 2:** Spacemacs navigation & discovery
3. **Week 3:** R development workflow
4. **Week 4:** Advanced features & customization

---

## 🗓️ Week 1: Vim Fundamentals

### Day 1: Modal Editing Concept

**Learn:** Understanding Normal vs Insert mode

**Concepts:**

- **Normal mode** = Command mode (navigation, editing)
- **Insert mode** = Typing mode
- `i` = Enter Insert mode
- `ESC` or `fd` = Return to Normal mode

**Practice (10 minutes):**

```
1. Open any text file in Spacemacs
2. Try: i (insert) → type "hello" → ESC → i → type "world" → ESC
3. Repeat 20 times until muscle memory forms
4. Goal: ESC becomes automatic
```

**R Example:**

```r
# Practice entering/exiting insert mode while editing this:
my_function <- function(x) {
  result <- x + 1
  return(result)
}
```

---

### Day 2: Basic Navigation (hjkl)

**Learn:** Moving without arrow keys

**Keys:**

- `h` = Left
- `j` = Down  
- `k` = Up
- `l` = Right

**Mental model:** `hjkl` are on home row, faster than arrow keys

**Practice (15 minutes):**

```
1. Open a 50-line R script
2. Navigate ONLY with hjkl (resist arrow keys!)
3. Move to line 10, then 30, then back to 1
4. Navigate around a function definition
```

**Challenge:**
Navigate through this code without arrow keys:

```r
mtcars %>%
  filter(mpg > 20) %>%
  select(mpg, cyl, hp) %>%
  arrange(desc(mpg))
```

---

### Day 3: Word Movement

**Learn:** Move by words, not characters

**Keys:**

- `w` = Next **w**ord
- `b` = **B**ackward word
- `e` = **E**nd of word

**Practice (15 minutes):**

```
1. Open roxygen documentation:
   #' Calculate mean of numeric vector
   #' @param x Numeric vector
   
2. Navigate from '#' to 'Calculate' using w
3. Navigate backward using b
4. Jump to end of 'vector' using e
```

**R Challenge:**
Navigate this line using only `w` and `b`:

```r
model <- lm(mpg ~ cyl + hp + wt, data = mtcars)
```

Count: How many `w` presses to reach "mtcars"?

---

### Day 4: Line Navigation

**Learn:** Jump within lines

**Keys:**

- `0` = Beginning of line
- `$` = End of line
- `^` = First non-whitespace character

**Practice (15 minutes):**

```r
# For this indented line:
    my_var <- some_function(arg1, arg2, arg3)

1. Press 0 (jump to column 1)
2. Press ^ (jump to 'm' in my_var)
3. Press $ (jump to end after ')')
```

**Challenge:**
Fix these lines (add missing semicolons) using `$`:

```r
x <- 1
y <- 2
z <- 3
```

Goal: Press `$` → `a` → `;` → `ESC` for each line

---

### Day 5: Editing Commands

**Learn:** Delete, change, yank (copy)

**Keys:**

- `x` = Delete character
- `dd` = Delete line
- `yy` = Yank (copy) line
- `p` = Paste

**Practice (20 minutes):**

```r
# Start with:
line1 <- "first"
line2 <- "second"
line3 <- "third"

# Practice:
1. dd on line2 (delete it)
2. yy on line1 (copy it)
3. p to paste after current line
4. x to delete individual characters
```

---

### Day 6: Visual Mode

**Learn:** Select text visually

**Keys:**

- `v` = Character selection
- `V` = Line selection
- `y` = Yank selection
- `d` = Delete selection

**Practice (20 minutes):**

```r
# Select and copy this function
my_func <- function(x, y) {
  result <- x + y
  return(result)
}

# Steps:
1. Move to first line
2. Press V (line visual)
3. Press jjj (select 4 lines)
4. Press y (yank)
5. Move elsewhere and p (paste)
```

---

### Day 7: Week 1 Review & Integration

**Practice (30 minutes):**
Real R workflow without looking at notes:

```r
# Task: Edit this badly formatted code
x<-function(a,b){
result<-a+b
result
}

# Steps using only Vim commands:
1. Navigate to function definition
2. Add proper spacing
3. Delete and rewrite 'result' line
4. Copy entire function
5. Paste it below
```

**Self-Test:**

- Can you navigate without arrow keys?
- Do you instinctively press ESC after typing?
- Can you delete/copy/paste lines fluently?

---

## 🗓️ Week 2: Spacemacs Navigation

### Day 8: SPC Leader Discovery

**Learn:** The Space menu system

**Concept:** Press `SPC` in Normal mode → see all options

**Practice (15 minutes):**

```
1. Press SPC
2. Don't press anything else - just observe menu
3. Press f (files menu appears)
4. Press ESC to cancel
5. Repeat with: b, p, w, g
```

**R Task:**
Find these commands using `SPC` discovery:

- How to save a file?
- How to switch buffers?
- How to search in file?

---

### Day 9: File Operations (SPC f)

**Learn:** All file commands under `SPC f`

**Keys:**

- `SPC f f` = Find file
- `SPC f s` = Save file
- `SPC f r` = Recent files
- `SPC f t` = File tree

**Practice (20 minutes):**

```
# Workflow:
1. SPC f f → open an R script
2. Make a change
3. SPC f s → save it
4. SPC f f → open another file
5. SPC f r → return to recent
6. SPC f t → toggle tree view
```

**Challenge:**
Open 5 R files in your project using only `SPC f` commands

---

### Day 10: Buffer Management (SPC b)

**Learn:** Working with multiple buffers

**Keys:**

- `SPC b b` = Switch buffer
- `SPC TAB` = Previous buffer
- `SPC b k` = Kill buffer
- `SPC b d` = Kill other buffers

**Practice (20 minutes):**

```
# Open 4 R files, then:
1. SPC b b → switch between them
2. SPC TAB → toggle between last 2
3. SPC b k → kill one buffer
4. SPC b d → kill all except current
```

---

### Day 11: Window Management (SPC w)

**Learn:** Split screen editing

**Keys:**

- `SPC w /` = Split vertically
- `SPC w -` = Split horizontally
- `SPC w d` = Delete window
- `SPC w w` = Cycle windows

**R Workflow:**

```
# Ultimate R workflow:
1. SPC w / → split screen
2. Left: R script, Right: R console
3. SPC w w → move between them
4. Edit script → eval in console
```

---

### Day 12: Project Navigation (SPC p)

**Learn:** Project-wide operations

**Keys:**

- `SPC p f` = Find file in project
- `SPC p p` = Switch project
- `SPC p t` = Toggle impl/test

**R Package Workflow:**

```
1. SPC p f → quickly jump to any R file
2. Type few letters to filter
3. SPC p t → toggle between R/ and tests/
```

---

### Day 13: Search Commands (SPC s)

**Learn:** Finding code

**Keys:**

- `/` = Search in buffer
- `SPC s s` = Enhanced search
- `SPC s p` = Search in project

**Practice:**

```r
# In a large R package:
1. / → search for "function"
2. n → next occurrence
3. N → previous occurrence
4. SPC s p → search entire project for "library"
```

---

### Day 14: Week 2 Review

**Integration Challenge (30 minutes):**

```
Real R package development workflow:
1. SPC p p → open your R package
2. SPC f t → open file tree
3. SPC p f → find a test file
4. SPC w / → split screen
5. SPC w w → switch to right pane
6. SPC f f → open corresponding R file
7. Make edits
8. SPC f s → save
9. Evaluate in R (we'll learn Week 3)
```

---

## 🗓️ Week 3: R Development Workflow

### Day 15: ESS Mode Basics (SPC m)

**Learn:** R-specific commands

**Keys:**

- `SPC m s` = Start R REPL
- `SPC m e e` = Eval region/function
- `SPC m e l` = Eval line
- `,` = Shortcut for `SPC m`

**Practice:**

```r
# Write this function:
add_one <- function(x) {
  x + 1
}

# Then:
1. SPC m s → start R
2. Put cursor in function
3. SPC m e e → eval it
4. Test: add_one(5)
```

---

### Day 16: Custom R Keybindings

**Learn:** Your spacemacs-rstats functions in Spacemacs

**Map to Spacemacs style:**

```elisp
;; Add to .spacemacs config:
(spacemacs/set-leader-keys-for-major-mode 'ess-r-mode
  "rr" 'spacemacs-rstats/insert-roxygen-skeleton
  "ur" 'spacemacs-rstats/usethis-use-r
  "ut" 'spacemacs-rstats/usethis-use-test
  "sc" 'spacemacs-rstats/s7-insert-class
  "sm" 'spacemacs-rstats/s7-insert-method)
```

**Practice:**

```
Now: SPC m r r inserts roxygen!
```

---

### Day 17: Roxygen Workflow

**Practice (30 minutes):**

```r
# Write function without docs:
calculate_ci <- function(x, conf_level = 0.95) {
  mean(x) + c(-1, 1) * qnorm(1 - (1 - conf_level)/2) * sd(x) / sqrt(length(x))
}

# Add documentation:
1. Move to line above function
2. SPC m r r → insert skeleton
3. Fill in params
4. Save and check
```

---

### Day 18-20: Full R Package Workflow

**Integrated Practice:**

```
Daily task: Add one new function to package

Day 18:
1. SPC m u r → create R file
2. Write function
3. SPC m r r → document
4. SPC m e e → test in R

Day 19:
1. SPC m u t → create test  
2. Write test expectations
3. Run tests in R
4. Iterate

Day 20:
1. SPC m s c → create S7 class
2. SPC m s m → add methods
3. Document and test
```

---

### Day 21: Week 3 Review

**Capstone Project:**
Create mini R package from scratch:

```
1. Create package structure
2. Add 2 functions with roxygen
3. Add tests
4. Run R CMD check
5. All using Spacemacs keybindings!
```

---

## 🗓️ Week 4: Advanced Features

### Day 22: Git Integration (Magit)

**Keys:**

- `SPC g s` = Magit status
- `s` = Stage
- `c c` = Commit
- `P p` = Push

**Practice:** Stage, commit, and push your R package

---

### Day 23-24: Advanced Editing

- Text objects (`ci"`, `di(`, `ca{`)
- Macros (`q` to record, `@` to replay)
- Multiple cursors

---

### Day 25-26: Customization

- Add your own `SPC` bindings
- Configure layers
- Theme customization

---

### Day 27-28: Speed Challenges

Timed exercises:

```
- Open 10 files in 30 seconds
- Navigate to function in 10 seconds
- Document function in 2 minutes
- All keyboard, no mouse
```

---

## 📊 Progress Tracking

### Daily Checklist

```
[ ] Practiced new concept (15 min)
[ ] Reviewed previous concepts (5 min)
[ ] Applied to real R code (10 min)
[ ] Avoided mouse/arrow keys
```

### Weekly Self-Assessment

**Week 1:**

- [ ] Can navigate without arrow keys?
- [ ] ESC is automatic?
- [ ] Can delete/copy/paste fluently?

**Week 2:**

- [ ] Use SPC without thinking?
- [ ] Find files quickly?
- [ ] Manage buffers comfortably?

**Week 3:**

- [ ] Write
 R code faster?
- [ ] Document functions easily?
- [ ] Eval code smoothly?

**Week 4:**

- [ ] Completely keyboard-driven?
- [ ] Faster than before?
- [ ] Comfortable with Spacemacs?

---

## 🎯 Practice Exercises Repository

### Beginner Drills (Week 1)

1. **Navigation drill:** 50-line script, navigate to every line using only `hjkl`
2. **Editing drill:** Fix 20 syntax errors using `x`, `dd`, and `i`
3. **Copy drill:** Duplicate 10 functions using `yy` and `p`

### Intermediate Challenges (Week 2-3)

1. **File management:** Open/close 20 files in 2 minutes
2. **Search challenge:** Find 10 functions across package in 3 minutes
3. **Documentation sprint:** Document 5 functions in 15 minutes

### Advanced Missions (Week 4)

1. **Package from scratch:** 30-minute timer
2. **Refactoring:** Reorganize R code using only keyboard
3. **Speed coding:** Write function + tests + docs in 10 minutes

---

## 💡 Tips for Success

1. **Disable arrow keys** (first 2 weeks):

   ```elisp
   (global-set-key (kbd "<up>") 'ignore)
   (global-set-key (kbd "<down>") 'ignore)
   (global-set-key (kbd "<left>") 'ignore)
   (global-set-key (kbd "<right>") 'ignore)
   ```

2. **Print cheat sheet** - keep on desk first week

3. **15 min daily** > 2 hours weekly

4. **Real work only** - force yourself to use Spacemacs for actual R development

5. **Week 3** is the hump - power through!

---

## 📅 Getting Started Tomorrow

**Day 1 Setup:**

1. Install Spacemacs (backup current config!)
2. Choose `vim` editing style
3. Add `ess` and `osx` layers
4. Open any R file
5. Start Day 1 lesson above
6. Practice 15 minutes
7. Close Spacemacs
8. Repeat tomorrow

**You've got this! 🚀**
