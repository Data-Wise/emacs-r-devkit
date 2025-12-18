# Data-Wise Documentation Standards Framework

**Complete documentation standardization system for all Data-Wise projects**

This directory contains the comprehensive documentation standards framework covering MkDocs sites, R packages, and the MediationVerse ecosystem.

---

## 📚 Quick Navigation

### Getting Started
**New to the standards?** Start here:
1. Read [DOCUMENTATION_INVENTORY.md](DOCUMENTATION_INVENTORY.md) - See what needs documentation
2. Invoke skill: `data-wise-documentation` - Quick reference guide
3. Choose your standards based on project type (see below)

### Standards by Project Type

| Project Type | Standards Document | Config File | Example |
|--------------|-------------------|-------------|---------|
| **Tools/Frameworks (MkDocs)** | [DOCUMENTATION_STANDARDS.md](DOCUMENTATION_STANDARDS.md) | [mkdocs-base.yml](mkdocs-base.yml) | claude-r-dev ⭐ |
| **R Packages (all)** | [MEDIATIONVERSE_STANDARDS.md](MEDIATIONVERSE_STANDARDS.md) | See examples | mediationverse, medfit |

**Simplified:** Only 2 standards documents (MkDocs for tools, pkgdown for R packages)

---

## 📋 Framework Components

### 1. Standards Documents

#### [DOCUMENTATION_STANDARDS.md](DOCUMENTATION_STANDARDS.md)
**For:** MkDocs-based documentation sites (tools, frameworks)

**Covers:**
- claude-r-dev navigation pattern ⭐ (specialized tutorials dropdown)
- claude-r-dev content formatting ⭐ (Usage → What it does → When to use)
- Material theme configuration
- Page templates (Homepage, Getting Started, Troubleshooting)
- Cross-project navigation
- Minimal, clean styling

**Apply to:**
- claude-r-dev ⭐ (reference implementation)
- spacemacs-rstats
- Future tool/framework projects

**Focus:** Just 2 MkDocs projects - concise and practical

---

#### [MEDIATIONVERSE_STANDARDS.md](MEDIATIONVERSE_STANDARDS.md)
**For:** MediationVerse ecosystem R packages (STRICT standards)

**Covers:**
- **Established Design System:**
  - Academic Blue (#0054AD) - REQUIRED
  - Litera bootswatch theme - REQUIRED
  - Inter/Montserrat/Fira Code fonts - REQUIRED
- **Standard Navigation:**
  - Ecosystem menu linking all packages - REQUIRED
  - Status menu with roadmap/contributing - REQUIRED
- **S7 Class System:**
  - S7 class documentation patterns
  - Method documentation with `@concept` tags
- **MathJax Configuration:**
  - For packages with mathematical notation
- **Integration with Workflow:**
  - Works with rdoc, rpkgdown, rdev, rpkgcommit aliases
  - Documented deployment process

**Apply to:**
- mediationverse (meta-package)
- medfit (foundation)
- probmed, rmediation, medrobust (core packages)
- medsim (support package)

---

### 2. Configuration Files

#### [mkdocs-base.yml](mkdocs-base.yml)
**Shared MkDocs configuration** for all tool/framework documentation sites

**Usage:**
```yaml
# In project mkdocs.yml
INHERIT: ./mkdocs-base.yml  # or remote URL

site_name: Your Project Name
# ... project-specific configuration
```

**Provides:**
- Material theme with dark/light mode
- Standard markdown extensions
- Navigation features (instant loading, search, code copy)
- Cross-project links in footer

---

### 3. Planning & Implementation

#### [IMPLEMENTATION_PLAN.md](IMPLEMENTATION_PLAN.md)
**6-week phased rollout plan** for standardizing all documentation

**Phases:**
1. **Foundation** (Week 1) - Create shared resources
2. **Update MkDocs Sites** (Week 2) - Standardize claude-r-dev and others
3. **R Packages** (Weeks 3-4) - Deploy pkgdown sites for all packages
4. **Ecosystem Overview** (Week 5) - Create MediationVerse hub (optional)
5. **Integration** (Week 6) - Cross-links and project directory
6. **Maintenance** (Ongoing) - Quarterly reviews

**Includes:**
- Detailed steps for each phase
- Project-specific action items
- Success metrics
- Tools and helpful commands

---

#### [DOCUMENTATION_INVENTORY.md](DOCUMENTATION_INVENTORY.md)
**Complete repository inventory** with status tracking

**Tracks:**
- All Data-Wise repositories (MkDocs + R packages)
- Current documentation status (✅ ⚠️ ❓)
- What needs to be done for each repository
- Implementation priorities (High/Medium)
- Progress tracking

**Repositories Identified:**
- **MkDocs:** spacemacs-rstats ✅, claude-r-dev ⚠️
- **MediationVerse:** mediationverse, medfit, probmed, rmediation, medrobust, medsim
- **Others:** TBD by user

---

### 4. Claude Code Skill

#### ~/.claude/skills/data-wise-documentation.md
**Quick-reference skill** for documentation work

**Invoke with:** Skill tool when working on documentation

**Provides:**
- Decision tree (MkDocs vs pkgdown vs MediationVerse)
- Standard templates (navigation, roxygen, badges)
- Integration with development workflow
- Checklists for each documentation type
- Links to detailed standards documents

---

## 🚀 Quick Start Guides

### To Standardize a MkDocs Site

```bash
cd ~/path/to/project

# 1. Update mkdocs.yml to inherit base config
cat >> mkdocs.yml <<'EOF'
INHERIT: https://raw.githubusercontent.com/Data-Wise/spacemacs-rstats/main/mkdocs-base.yml
EOF

# 2. Ensure required pages exist
required_pages="getting-started.md configuration.md troubleshooting.md contributing.md"
for page in $required_pages; do
  [ ! -f "docs_mkdocs/$page" ] && touch "docs_mkdocs/$page"
done

# 3. Build and preview
mkdocs serve

# 4. Deploy
mkdocs gh-deploy
```

### To Create pkgdown Site for MediationVerse Package

```bash
cd ~/R-packages/active/packagename

# 1. Copy template _pkgdown.yml
cp ~/R-packages/active/mediationverse/_pkgdown.yml .
# Edit: update site_url, package name, specific articles

# 2. In R console
R -e "
library(usethis)
use_vignette('packagename', title = 'Getting Started with packagename')
use_github_action('pkgdown')
"

# 3. Build and preview
rdoc        # Generate roxygen documentation
rpkgdown    # Build pkgdown site
rpkgpreview # Preview at http://127.0.0.1:8000

# 4. Deploy (via GitHub Actions or manual)
# GitHub Actions will deploy on push to main
```

---

## 📊 Current Status

**Framework Status:** ✅ Complete
- All standards documents created
- Shared configurations in place
- Integration with existing workflow
- Implementation plan defined
- Skill file created

**Implementation Status:** 📋 Ready to Begin
- Inventory complete
- Priorities identified
- Templates available
- Awaiting user decision to start rollout

---

## 🎯 Common Use Cases

### "I'm creating a new R package in MediationVerse"

1. Read: [MEDIATIONVERSE_STANDARDS.md](MEDIATIONVERSE_STANDARDS.md)
2. Copy `_pkgdown.yml` from mediationverse package
3. Use Academic Blue (#0054AD) + Litera theme
4. Include ecosystem navigation menu
5. Follow roxygen templates for S7 classes

### "I'm creating a new tool/framework project"

1. Read: [DOCUMENTATION_STANDARDS.md](DOCUMENTATION_STANDARDS.md)
2. Inherit from: [mkdocs-base.yml](mkdocs-base.yml)
3. Create required pages (Getting Started, Config, Troubleshooting)
4. Add cross-project links
5. Deploy to data-wise.github.io

### "I need to update existing documentation"

1. Check status in: [DOCUMENTATION_INVENTORY.md](DOCUMENTATION_INVENTORY.md)
2. Find what's missing for your project
3. Follow relevant standards document
4. Use implementation plan for step-by-step guidance

### "I'm documenting a function in MediationVerse package"

1. Use roxygen template from MEDIATIONVERSE_STANDARDS.md
2. Add appropriate `@concept` tag (main, helpers, s7-classes, methods)
3. Reference other functions with `[function_name()]`
4. Run `rdoc` to regenerate documentation
5. Preview with `rpkgpreview`

---

## 🔗 Integration Points

### With Existing Workflow

The standards integrate seamlessly with your existing aliases:

```bash
# Development cycle (includes documentation generation)
rdev        # doc → test → check

# Documentation-specific
rdoc        # Generate roxygen docs
rpkgdown    # Build pkgdown site
rpkgpreview # Preview site locally

# Git workflow (includes documentation)
rpkgcommit "message"  # doc → test → style → commit
```

### With Existing Standards

- **r-package-development.md skill:** Development workflow and testing
- **data-wise-documentation.md skill:** Documentation structure and content
- **mediationverse/_pkgdown.yml:** Reference implementation
- **medfit/_pkgdown.yml:** MathJax example

---

## 📁 File Locations

**Standards (in spacemacs-rstats):**
```
/Users/dt/spacemacs-rstats/
├── DOCUMENTATION_README.md          # This file (overview)
├── DOCUMENTATION_STANDARDS.md       # MkDocs standards (2 projects)
├── MEDIATIONVERSE_STANDARDS.md      # R package standards (6+ packages)
├── IMPLEMENTATION_PLAN.md           # Rollout plan
├── DOCUMENTATION_INVENTORY.md       # Repository inventory
└── mkdocs-base.yml                  # Shared MkDocs config
```

**Simplified:** Only 2 main standards files

**Skill:**
```
/Users/dt/.claude/skills/
└── data-wise-documentation.md       # Quick reference skill
```

**Examples:**
```
/Users/dt/spacemacs-rstats/            # MkDocs example
/Users/dt/R-packages/active/mediationverse/_pkgdown.yml  # MediationVerse example
/Users/dt/R-packages/active/medfit/_pkgdown.yml          # MathJax example
```

---

## ✅ Quality Standards

Every documentation site should have:

**MkDocs Sites:**
- [ ] Inherits from mkdocs-base.yml
- [ ] All required pages (Home, Getting Started, Config, Troubleshooting, Contributing)
- [ ] Standard badges on homepage
- [ ] Feature grid or cards
- [ ] Cross-project links
- [ ] Deployed to data-wise.github.io

**R Package Sites (Generic):**
- [ ] _pkgdown.yml with standard structure
- [ ] Get Started vignette
- [ ] Functions organized with @concept tags
- [ ] Standard badges in README
- [ ] NEWS.md
- [ ] GitHub Action for deployment

**MediationVerse Packages (Additional):**
- [ ] Academic Blue (#0054AD) color
- [ ] Litera bootswatch theme
- [ ] Inter/Montserrat/Fira Code fonts
- [ ] Complete ecosystem navigation menu
- [ ] Status menu
- [ ] S7 classes documented with @concept s7-classes
- [ ] MathJax configured (if needed)
- [ ] Cross-links to all ecosystem packages

---

## 🛠️ Maintenance

### When Adding New Project

1. Add to DOCUMENTATION_INVENTORY.md
2. Classify project type (MkDocs/pkgdown/MediationVerse)
3. Apply appropriate standards
4. Add cross-project links to all sites
5. Update skill if new patterns emerge

### Quarterly Review

- Update cross-project links
- Refresh screenshots in docs
- Check for broken links
- Sync with latest Material/pkgdown versions
- Review analytics for improvement areas

---

## 📖 Additional Resources

**Related Skills:**
- `r-package-development.md` - R package development workflow
- `data-wise-documentation.md` - Documentation quick reference

**External Documentation:**
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- [pkgdown](https://pkgdown.r-lib.org/)
- [Roxygen2](https://roxygen2.r-lib.org/)
- [S7 OOP System](https://rconsortium.github.io/OOP-WG/)

---

## 🎯 Next Steps

**Ready to implement?** See [IMPLEMENTATION_PLAN.md](IMPLEMENTATION_PLAN.md)

**Need quick reference?** Invoke skill: `data-wise-documentation`

**Want to see what needs work?** Check [DOCUMENTATION_INVENTORY.md](DOCUMENTATION_INVENTORY.md)

**Starting new documentation?** Use the decision tree in the skill or this README

---

**Framework Version:** 1.0
**Last Updated:** 2025-12-07
**Maintained By:** Data-Wise Organization
**Contact:** Documentation questions → spacemacs-rstats issues
