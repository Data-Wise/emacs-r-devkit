# Documentation Standards

**Data-Wise documentation standards and guidelines**

This directory contains comprehensive documentation standards for all Data-Wise projects.

---

## 📋 Files in This Directory

### Primary Standards

1. **[DOCUMENTATION_STANDARDS.md](DOCUMENTATION_STANDARDS.md)**
   - MkDocs documentation standards for tools and frameworks
   - Applies to: spacemacs-rstats, claude-r-dev
   - Features claude-r-dev navigation and content patterns ⭐

2. **[MEDIATIONVERSE_STANDARDS.md](MEDIATIONVERSE_STANDARDS.md)**
   - R package documentation standards (pkgdown)
   - Applies to: ALL Data-Wise R packages
   - Academic Blue (#0054AD) + Litera theme
   - Ecosystem navigation and S7 class patterns

### Supporting Files

3. **[DOCUMENTATION_README.md](DOCUMENTATION_README.md)**
   - Master overview and navigation guide
   - Decision tree for choosing standards
   - Quick start guides
   - Links to all resources

4. **[DOCUMENTATION_INVENTORY.md](DOCUMENTATION_INVENTORY.md)**
   - Repository inventory with status tracking
   - Implementation priorities
   - Progress tracking for all projects

5. **[IMPLEMENTATION_PLAN.md](IMPLEMENTATION_PLAN.md)**
   - 6-week phased rollout plan
   - Detailed steps for each phase
   - Project-specific action items

6. **[mkdocs-base.yml](mkdocs-base.yml)**
   - Shared MkDocs configuration
   - Can be inherited by all MkDocs projects
   - Standard theme, plugins, and extensions

---

## 🎯 Quick Start

### "Which standard should I use?"

**Creating tool/framework documentation (MkDocs)?**
→ Use [DOCUMENTATION_STANDARDS.md](DOCUMENTATION_STANDARDS.md)

**Creating R package documentation (pkgdown)?**
→ Use [MEDIATIONVERSE_STANDARDS.md](MEDIATIONVERSE_STANDARDS.md)

**Need the big picture?**
→ Read [DOCUMENTATION_README.md](DOCUMENTATION_README.md)

---

## 📂 Integration

### With Claude Code

The `data-wise-documentation` skill references these standards:

```bash
# In Claude Code, invoke:
Skill: data-wise-documentation
```

### With Development Workflow

Standards integrate with existing R package development workflow:

```bash
rdoc        # Generate roxygen documentation
rpkgdown    # Build pkgdown site
rpkgpreview # Preview site locally
rdev        # Full development cycle
```

---

## 🔗 Related

**Parent project:** [spacemacs-rstats](../)
**Claude skill:** `~/.claude/skills/data-wise-documentation.md`
**Examples:**
- MkDocs: claude-r-dev, spacemacs-rstats
- pkgdown: mediationverse, medfit

---

**Version:** 2.0 (Simplified)
**Last Updated:** 2025-12-07
**Maintained by:** Data-Wise
