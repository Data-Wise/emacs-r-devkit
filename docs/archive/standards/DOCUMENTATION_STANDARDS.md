# MkDocs Documentation Standards

**Standards for Data-Wise tool and framework documentation sites**

This document covers MkDocs-based documentation for development tools and frameworks (spacemacs-rstats, claude-r-dev).

**For R packages:** See [MEDIATIONVERSE_STANDARDS.md](MEDIATIONVERSE_STANDARDS.md)

---

## 🎯 Scope

**Applies to:**
- spacemacs-rstats (Emacs configuration)
- claude-r-dev (AI development framework)
- Future tool/framework projects

**Uses:** MkDocs with Material theme

---

## 📋 Navigation Structure

### Standard Pattern (⭐ claude-r-dev style)

```yaml
nav:
  - Home: index.md
  - Getting Started: getting-started.md
  - Commands Reference: commands-reference.md  # or Features/API
  - Profiles: profiles.md                      # if applicable
  - Configuration: configuration.md
  - Customization: customization.md            # if applicable
  - Tutorials:                                 # dropdown for specialized paths
      - Overview: tutorials/index.md
      - [Domain 1]: tutorials/domain1.md
      - [Domain 2]: tutorials/domain2.md
  - Troubleshooting: troubleshooting.md        # NEW - add this!
  - Contributing: contributing.md
```

**Key Features:**
- Clear progression: Getting Started → Features → Advanced → Tutorials
- Specialized tutorials dropdown for domain-specific learning paths
- Descriptive labels ("Commands Reference" not just "Reference")
- Configuration vs Customization separation (schema vs user guide)

---

## 🎨 Theme & Styling

### Shared Configuration

**Inherit from mkdocs-base.yml:**

```yaml
INHERIT: ./mkdocs-base.yml

site_name: Your Project Name
site_description: One-line description
site_url: https://data-wise.github.io/project-name/

# Add project-specific navigation here
```

**mkdocs-base.yml provides:**
- Material theme with dark/light mode
- Standard markdown extensions
- Navigation features (instant loading, search, code copy)
- Cross-project links in footer

### Color Schemes

**Development tools:** `primary: indigo, accent: purple` (default)

---

## 📄 Page Templates

### Homepage (index.md)

```markdown
# Project Name

**One-line value proposition**

[![License](badge)](link)
[![Docs](badge)](link)
[![Stars](badge)](link)

---

## ✨ Features

- Feature 1
- Feature 2
- Feature 3

## 🚀 Quick Start

```bash
# Installation
command here
```

## 📚 Documentation

- [Getting Started](getting-started.md)
- [Commands Reference](commands-reference.md)
- [Configuration](configuration.md)

## 🤝 Contributing

See [Contributing Guide](contributing.md)

## 📄 License

MIT © Data-Wise
```

---

### Getting Started

**Required sections:**
1. Prerequisites
2. Installation (with tabs for multiple options)
3. First Steps / Quick Tutorial
4. Verification
5. Next Steps

**Format:**
```markdown
## Installation

### Option 1: Recommended

```bash
# One-liner installation
command here
```

### Option 2: Manual

Step-by-step instructions...

## Verification

```bash
# Test command
command --version
```
```

---

### Commands/Features Reference

**Use claude-r-dev pattern:**

```markdown
### command_name

**Usage:**
```bash
command_name [arguments]
```

**What it does:**
- Step 1 of behavior
- Step 2 of behavior
- Step 3 of behavior

**When to use:**
Practical context explaining the use case.

**Example:**
```bash
# Concrete example with inline comments
command_name "specific argument"
```

---

### Another Command

[Repeat structure...]

---

## Quick Reference

| Command | Purpose |
|---------|---------|
| command1 | Brief description |
| command2 | Brief description |
```

**Why this works:**
- Scannable with bold labels
- Progressive disclosure: Usage → Behavior → Context → Example
- Quick reference table at end for scanning

---

### Troubleshooting

**Required sections:**
```markdown
# Troubleshooting

## Quick Diagnosis

Run this command to check common issues:
```bash
diagnostic-command
```

## Installation Issues

### Symptom: Error message here

**Cause:** Explanation

**Solution:**
```bash
fix-command
```

## Runtime Issues

[Similar structure...]

## Getting Help

- Check [GitHub Issues](link)
- See [Contributing Guide](contributing.md)
```

---

## ✍️ Content Style

### Writing Guidelines

- **Headings:** Sentence case
- **Code blocks:** Always specify language
- **Voice:** Second person ("you")
- **Tense:** Present tense for features, imperative for instructions
- **Admonitions:** Use sparingly (claude-r-dev minimizes for cleaner look)

### Code Examples

**With inline comments:**
```bash
# Install dependencies
npm install

# Run development server
npm run dev
```

**Tabs for alternatives:**
```markdown
=== "macOS"
    ```bash
    brew install tool
    ```

=== "Linux"
    ```bash
    apt install tool
    ```
```

---

## 🔗 Cross-Project Integration

### Footer Links

All sites link to other Data-Wise projects:

```yaml
extra:
  projects:
    - name: spacemacs-rstats
      description: Professional Emacs environment for R package development
      url: https://data-wise.github.io/spacemacs-rstats/
    - name: claude-r-dev
      description: AI-powered R package development with Claude Code
      url: https://data-wise.github.io/claude-r-dev/
```

---

## 🌟 Reference Implementations

### claude-r-dev ⭐
**URL:** https://data-wise.github.io/claude-r-dev/

**Exemplifies:**
- Excellent navigation with specialized tutorials dropdown
- Clean content formatting (Usage → What it does → When to use → Example)
- Descriptive menu labels
- Minimal admonitions
- Quick reference tables

**Use as reference when:** Creating framework/workflow documentation

---

### spacemacs-rstats
**URL:** https://data-wise.github.io/spacemacs-rstats/

**Exemplifies:**
- Complete standard structure
- Feature grid on homepage
- Comprehensive troubleshooting guide
- Configuration and customization documentation

**Use as reference when:** Creating tool/configuration documentation

---

## ✅ Checklist

For each MkDocs site:

- [ ] Inherits from mkdocs-base.yml
- [ ] All required pages (Home, Getting Started, Configuration, **Troubleshooting**, Contributing)
- [ ] Standard badges on homepage
- [ ] Cross-project links in footer
- [ ] Deployed to data-wise.github.io/project-name
- [ ] Follows claude-r-dev content formatting pattern
- [ ] Quick reference tables where applicable
- [ ] Minimal admonitions (clean appearance)

---

## 🚀 Quick Start

### To create new MkDocs site:

```bash
# Create project
mkdocs new project-name
cd project-name

# Copy mkdocs-base.yml from spacemacs-rstats
cp ~/spacemacs-rstats/mkdocs-base.yml .

# Update mkdocs.yml
cat > mkdocs.yml <<'EOF'
INHERIT: ./mkdocs-base.yml

site_name: Project Name
site_url: https://data-wise.github.io/project-name/

nav:
  - Home: index.md
  - Getting Started: getting-started.md
  # Add sections following claude-r-dev pattern
EOF

# Create required pages
cd docs_mkdocs
touch getting-started.md configuration.md troubleshooting.md contributing.md

# Build and preview
mkdocs serve
```

---

**Version:** 2.0 (Simplified)
**Last Updated:** 2025-12-07
**Focus:** MkDocs sites only (2 projects)
**For R packages:** Use MEDIATIONVERSE_STANDARDS.md
