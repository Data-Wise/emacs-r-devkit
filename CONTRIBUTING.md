# Contributing to spacemacs-rstats

Thank you for your interest in contributing to spacemacs-rstats! This document provides guidelines for contributing to the project.

## 🤝 How to Contribute

### Reporting Bugs

If you find a bug, please [open an issue](https://github.com/Data-Wise/spacemacs-rstats/issues/new?template=bug_report.md) with:

- **Description** - Clear description of the bug
- **Steps to Reproduce** - Detailed steps to reproduce the issue
- **Expected Behavior** - What you expected to happen
- **Actual Behavior** - What actually happened
- **Environment** - Emacs version, R version, macOS version
- **Error Messages** - Full error messages from `*Messages*` buffer

### Suggesting Features

Feature suggestions are welcome! Please [open an issue](https://github.com/Data-Wise/spacemacs-rstats/issues/new?template=feature_request.md) with:

- **Use Case** - Describe the problem you're trying to solve
- **Proposed Solution** - Your idea for solving it
- **Alternatives** - Other solutions you've considered
- **Additional Context** - Screenshots, examples, or references

### Improving Documentation

Documentation improvements are highly valued:

- **Fix typos or errors** - In README, documentation site, or code comments
- **Add examples** - Show how to use features
- **Improve clarity** - Make instructions easier to follow
- **Add screenshots** - Visual aids for complex workflows

## 💻 Development Workflow

### Setting Up Development Environment

```bash
# Fork and clone your fork
git clone https://github.com/YOUR-USERNAME/spacemacs-rstats.git
cd spacemacs-rstats

# Add upstream remote
git remote add upstream https://github.com/Data-Wise/spacemacs-rstats.git

# Create dev branch
git checkout -b dev
```

### Making Changes

1. **Create a feature branch** from `dev`:
   ```bash
   git checkout dev
   git pull upstream dev
   git checkout -b feature/my-feature
   ```

2. **Make your changes**:
   - Follow existing code style
   - Test your changes thoroughly
   - Update documentation if needed

3. **Test your changes**:
   ```bash
   # Run dependency checker
   ./check-dependencies.sh

   # Test in Emacs
   emacs -Q
   M-x load-file RET ~/.emacs.d/init.el RET

   # Run through TEST-CHECKLIST.md
   ```

4. **Commit your changes**:
   ```bash
   git add .
   git commit -m "Add feature: brief description

   Detailed explanation of changes:
   - What was changed
   - Why it was changed
   - Any breaking changes

   Closes #issue-number"
   ```

5. **Push to your fork**:
   ```bash
   git push origin feature/my-feature
   ```

6. **Create a Pull Request**:
   - Go to the [Pull Requests page](https://github.com/Data-Wise/spacemacs-rstats/pulls)
   - Click "New Pull Request"
   - Select your fork and branch
   - Fill in the PR template
   - Link related issues

### Branch Structure

- `main` - Production-ready code, protected
- `dev` - Active development
- `gh-pages` - Built documentation (auto-deployed)
- `feature/*` - New features
- `fix/*` - Bug fixes
- `docs/*` - Documentation improvements

### Pull Request Guidelines

**Before submitting:**
- [ ] Code follows existing style
- [ ] All tests pass
- [ ] Documentation updated
- [ ] Commit messages are clear
- [ ] PR description is complete

**PR Description should include:**
- Summary of changes
- Motivation and context
- Related issues (use "Closes #123")
- Testing performed
- Screenshots (if UI changes)

**PR will be reviewed for:**
- Code quality and style
- Test coverage
- Documentation completeness
- Backwards compatibility
- Performance impact

## 📝 Code Style Guidelines

### Emacs Lisp

- Follow standard Emacs Lisp conventions
- Use descriptive function and variable names
- Add docstrings to all functions
- Prefix custom functions with `spacemacs-rstats/`
- Use `use-package` for package configuration

**Example:**
```elisp
(defun spacemacs-rstats/my-function (arg)
  "Brief description of what this function does.
ARG is the argument description."
  (interactive "P")
  ;; Implementation
  )
```

### R Scripts

- Follow Tidyverse style guide
- Use styler for formatting
- Add comments for complex logic
- Handle errors gracefully

### Markdown Documentation

- Use ATX-style headers (`#` not `===`)
- Keep lines under 100 characters
- Use code fences with language specification
- Include examples for complex features

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
type(scope): subject

body

footer
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples:**
```
feat(roxygen): add support for multiline parameters

Improved parameter parsing to handle function signatures
that span multiple lines with proper indentation.

Closes #42
```

```
docs: update keybinding reference for macOS

- Clarified Option key is Meta
- Added visual keyboard symbols
- Fixed outdated key sequences
```

## 🧪 Testing Guidelines

### Before Submitting PR

1. **Automated checks:**
   ```bash
   ./check-dependencies.sh
   ```

2. **Manual testing:**
   - Open test files: `emacs test-features.R`
   - Verify each modified feature works
   - Test on clean Emacs instance: `emacs -Q`
   - Check for errors in `*Messages*` buffer

3. **Documentation:**
   - Update relevant `.md` files
   - Update docstrings
   - Add examples if needed
   - Test documentation builds:
     ```bash
     mkdocs serve  # If you have mkdocs installed
     ```

### Test Coverage

- Test new features thoroughly
- Include edge cases
- Test error handling
- Verify integration with existing features

## 📚 Documentation

### Where to Update

- **README.md** - Overview, quick start, badges
- **docs_mkdocs/** - Comprehensive documentation site
- **TUTORIAL.md** - Step-by-step user guide
- **CHEAT-SHEET.md** - Quick reference
- **TROUBLESHOOTING.md** - Common issues
- **Docstrings** - Inline Emacs Lisp documentation

### Documentation Standards

- Use clear, concise language
- Include examples for complex features
- Add screenshots for UI changes
- Update table of contents
- Test all code examples
- Cross-reference related sections

## 🔄 Review Process

1. **Automated checks run** - CI builds documentation
2. **Maintainer reviews** - Code and documentation quality
3. **Feedback provided** - Suggestions for improvements
4. **Revisions made** - Address review comments
5. **Approval** - Maintainer approves PR
6. **Merge** - Squash and merge to main

## 🏷️ Issue Labels

- `bug` - Something isn't working
- `enhancement` - New feature or request
- `documentation` - Improvements to docs
- `good first issue` - Good for newcomers
- `help wanted` - Community help needed
- `question` - Further information requested
- `wontfix` - Will not be implemented
- `duplicate` - Duplicate issue

## 💡 Tips for Contributors

### Getting Started

- Browse [good first issues](https://github.com/Data-Wise/spacemacs-rstats/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22)
- Join discussions to understand priorities
- Ask questions in issues or discussions
- Review existing PRs to understand standards

### Best Practices

- **Keep PRs focused** - One feature/fix per PR
- **Update frequently** - Rebase on latest dev
- **Communicate early** - Open draft PRs for feedback
- **Test thoroughly** - Prevent regressions
- **Document well** - Make features discoverable

### Common Pitfalls to Avoid

- ❌ Large, unfocused PRs
- ❌ Breaking changes without discussion
- ❌ Untested code
- ❌ Missing documentation
- ❌ Unclear commit messages

## 📬 Getting Help

- **Questions** - [GitHub Discussions](https://github.com/Data-Wise/spacemacs-rstats/discussions)
- **Issues** - [GitHub Issues](https://github.com/Data-Wise/spacemacs-rstats/issues)
- **Documentation** - [Website](https://data-wise.github.io/spacemacs-rstats/)

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for contributing to spacemacs-rstats!** 🎉

Your contributions help make R development in Emacs better for everyone.
