# Learning Roadmap: R Package Development with Spacemacs

This roadmap guides you from setting up your environment to mastering professional R package development using Spacemacs.

## 1. Current State Assessment

### Prerequisites Check
- [ ] Basic understanding of R programming (functions, scripts)
- [ ] Familiarity with file systems and terminal commands
- [ ] Curiosity about Emacs/Spacemacs (no prior experience needed)

### Skill Level Check
- [ ] **Novice**: Use RStudio, new to Emacs/CLI tools.
- [ ] **Intermediate**: Comfortable with R, maybe used Git.
- [ ] **Advanced**: Experience with other editors (Vim/VS Code), wrote some R packages.

## 2. Learning Goals

### Short-term Goals (1 Month)
- [ ] Goal 1: Install and configure `emacs-r-devkit` successfully.
- [ ] Goal 2: Master basic Spacemacs navigation and keybindings (`SPC` leader key).
- [ ] Goal 3: Create a simple "Hello World" R package using the devkit's tools.

### Medium-term Goals (3 Months)
- [ ] Goal 1: Build a complete R package with documentation (roxygen2) and tests (testthat).
- [ ] Goal 2: Integrate Git workflow (Magit) into daily development.
- [ ] Goal 3: Customize Spacemacs layers and user configuration.

### Long-term Goals (6 Months)
- [ ] Goal 1: Publish a package to CRAN or GitHub.
- [ ] Goal 2: Contribute to the `emacs-r-devkit` or other Open Source projects.
- [ ] Goal 3: Develop a fully keyboard-driven workflow (no mouse).

## 3. Complete Learning Path

### Phase 1: The Spacemacs Foundation (Weeks 1-2)

#### Week 1: Setup & Survival
**Focus**: Installation and basic movement.

**Topics:**
- [ ] Installing Emacs & Spacemacs (`install-init.sh`)
- [ ] The "Evil" way (Vim bindings) vs "Holy" mode (Emacs bindings)
- [ ] The Leader Key (`SPC`) concept
- [ ] Buffers vs. Windows vs. Frames

**Resources:**
- 📚 `guides/spacemacs-learning/00-EMACS-BASICS.md` (In this repo)
- 📚 `guides/spacemacs-learning/01-SPACEMACS-GUIDE.md` (In this repo)
- 📚 [Spacemacs Documentation](https://www.spacemacs.org/doc/DOCUMENTATION.html)

**Practice:**
- **Project**: "The Tutor"
  - Run `SPC h T` (Evil tutor) inside Spacemacs.
  - Complete the first 3 lessons.

#### Week 2: R in Spacemacs (ESS)
**Focus**: Running R code interactively.

**Topics:**
- [ ] ESS (Emacs Speaks Statistics) basics
- [ ] Sending code: Line (`, s l`), Function (`, s f`), Region (`, s r`)
- [ ] The R Console buffer (`SPC m '`)
- [ ] Help & Documentation lookup (`, h h`)

**Resources:**
- 📚 `docs_mkdocs/features.md` (ESS section)
- 📚 [ESS Manual](https://ess.r-project.org/Manual/ess.html)

**Practice:**
- **Project**: Analysis Script
  - Open a `.R` file.
  - Write a script to load `mtcars` data and plot it.
  - Execute code line-by-line and as a whole buffer using Spacemacs keys.

### Phase 2: Package Development Workflow (Weeks 3-6)

#### Week 3: Scaffolding & Documentation
**Focus**: `devtools`, `usethis`, and `roxygen2`.

**Topics:**
- [ ] Creating a package skeleton
- [ ] Using `C-c r r` (or `, r d`) for Roxygen skeletons
- [ ] Generating docs (`devtools::document()`)
- [ ] The `DESCRIPTION` file

**Resources:**
- 📚 [R Packages (2e) - Whole Game](https://r-pkgs.org/whole-game.html)
- 📚 `guides/TUTORIAL.md`

**Practice:**
- **Project**: `mypkg`
  - Create a new package.
  - Add 2 functions with Roxygen documentation.
  - Generate the `man/` files.

#### Week 4: Testing & Quality
**Focus**: `testthat` and `check`.

**Topics:**
- [ ] Writing unit tests (`usethis::use_test()`)
- [ ] Running tests in Emacs (`, t t`)
- [ ] Running R CMD Check
- [ ] Linting & Styling (Flycheck)

**Practice:**
- **Project**: `mypkg` (continued)
  - Add tests for your 2 functions.
  - Run `rtest` in the terminal and `, t t` in Spacemacs.
  - Fix any lintr warnings shown in the buffer.

#### Week 5-6: Git & Magit
**Focus**: Version control without leaving Emacs.

**Topics:**
- [ ] Magit status (`SPC g s`)
- [ ] Staging (`s`), Committing (`c c`), Pushing (`P p`)
- [ ] Branching (`b b`) and Merging (`m m`)
- [ ] Blaming and History

**Resources:**
- 📚 [Magit: A Git Porcelain](https://magit.vc/)
- 📚 [System Crafters: Magit](https://systemcrafters.net/magit/)

**Practice:**
- **Project**: Version Control
  - Initialize a git repo for `mypkg`.
  - Make changes, stage chunks (hunks), and commit.
  - Push to GitHub.

### Phase 3: Advanced Proficiency (Weeks 7-10)

#### Week 7-8: Navigation & Project Management
**Focus**: Projectile and LSP.

**Topics:**
- [ ] Finding files in a project (`SPC p f`)
- [ ] Switching projects (`SPC p p`)
- [ ] Go to definition (`gd`)
- [ ] Find references (`gr`)

**Practice:**
- **Project**: Code Navigation
  - Download a large open-source R package (e.g., `ggplot2`).
  - Use Projectile to explore the file structure.
  - Use LSP to trace function calls.

#### Week 9-10: Advanced R & S7
**Focus**: Modern OOP and advanced devkit features.

**Topics:**
- [ ] S7 Object Oriented Programming
- [ ] Using devkit S7 snippets (`C-c r s c`)
- [ ] Debugging in ESS

**Practice:**
- **Project**: S7 Class
  - Create an S7 class in your package using the snippets.
  - Write methods and validate them.

## 4. Daily Routine for Success

### Daily (30-60 mins)
- **10 min**: "Spacemacs Daily" - Learn 1 new keybinding.
- **20 min**: Coding in R using *only* keyboard shortcuts.
- **Optional**: Read one section of "R Packages" book.

### Weekly
- **Friday**: "Refactor Friday" - Clean up your code and config.
- **Sunday**: Plan the next week's package feature.

## 5. Common Pitfalls

1.  **The "Pinky Problem"**: Overusing `Ctrl` in standard Emacs.
    *   *Fix*: Embrace the Spacemacs `SPC` leader key.
2.  **Config Overload**: Trying to customize everything at once.
    *   *Fix*: Stick to the default `emacs-r-devkit` config for the first month.
3.  **Mouse Reliance**: Reaching for the mouse for navigation.
    *   *Fix*: Disable the mouse or force yourself to use `SPC w` for window management.
