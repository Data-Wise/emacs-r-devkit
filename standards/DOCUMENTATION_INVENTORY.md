# Data-Wise Documentation Inventory

**Comprehensive list of all Data-Wise repositories and their documentation status**

Last Updated: 2025-12-07

---

## 📊 Repository Categories

### MkDocs-Based Documentation (Tools & Frameworks)

| Repository | Current Status | Needs Update | Priority | Notes |
|------------|---------------|--------------|----------|-------|
| **emacs-r-devkit** | ✅ Standardized | No | - | Already follows DOCUMENTATION_STANDARDS.md |
| **claude-r-dev** | ⚠️ Needs Update | Yes | High | Has MkDocs but needs standardization |
| **zsh-claude-workflow** | ❓ Unknown | TBD | Medium | Smart context manager for Claude Code + zsh |
| **examark** | ❓ Unknown | TBD | Low | Markdown to Canvas QTI converter |
| **claude-statistical-research-mcp** | ❓ Unknown | TBD | Medium | MCP server with R tools + 17 Claude skills |

### R Packages - MediationVerse Ecosystem

| Package | Current Status | Needs Update | Priority | Notes |
|---------|---------------|--------------|----------|-------|
| **mediationverse** | ⚠️ Partial | Yes | High | Has _pkgdown.yml, needs full site |
| **medfit** | ⚠️ Partial | Yes | High | Foundation package, has _pkgdown.yml |
| **probmed** | ❓ Unknown | Yes | High | Core package |
| **rmediation** | ❓ Unknown | Yes | High | Core package |
| **medrobust** | ❓ Unknown | Yes | Medium | Core package |
| **medsim** | ❓ Unknown | Yes | Medium | Support package |

### Other R Packages (Non-MediationVerse)

| Package | Current Status | Needs Update | Priority | Notes |
|---------|---------------|--------------|----------|-------|
| **[User to identify]** | ❓ Unknown | TBD | - | Generic R package standards apply |

---

## 🔍 Detailed Status

### 1. emacs-r-devkit ✅

**Status:** Fully standardized

**Documentation:**

- MkDocs with Material theme
- Follows DOCUMENTATION_STANDARDS.md
- Has all required pages
- Cross-project links in place
- Deployed to: <https://data-wise.github.io/emacs-r-devkit/>

**Action Required:** None - serves as reference implementation

---

### 2. claude-r-dev ⚠️

**Status:** Has documentation but needs standardization

**Current State:**

- Uses MkDocs
- Has some documentation pages
- May not follow full standard navigation

**Needs:**

- [ ] Update mkdocs.yml to inherit from mkdocs-base.yml
- [ ] Ensure all required pages present:
  - [ ] Home (index.md)
  - [ ] Getting Started (getting-started.md)
  - [ ] Configuration (configuration.md)
  - [ ] Troubleshooting (troubleshooting.md) - **likely missing**
  - [ ] Contributing (contributing.md)
- [ ] Add standard badges to homepage
- [ ] Include cross-project links to emacs-r-devkit
- [ ] Use standard theme configuration
- [ ] Add feature grid to homepage

**Priority:** High (framework used with emacs-r-devkit)

**Expected URL:** <https://data-wise.github.io/claude-r-dev/>

---

### 3. mediationverse (Meta-package) ⚠️

**Status:** Has _pkgdown.yml, needs full site

**Current State:**

- Has `_pkgdown.yml` with established design system
- Academic Blue (#0054AD) color scheme
- Litera theme
- Ecosystem navigation configured

**Needs:**

- [ ] Create/update README.md following standard structure
- [ ] Create "Getting Started" vignette
- [ ] Set up pkgdown GitHub Action for deployment
- [ ] Organize function reference with @concept tags
- [ ] Create NEWS.md with standard format
- [ ] Add standard badges to README
- [ ] Deploy to: <https://data-wise.github.io/mediationverse/>

**Functions to document:**

- mediationverse_packages()
- mediationverse_update()
- mediationverse_conflicts()

**Priority:** High (meta-package for entire ecosystem)

---

### 4. medfit (Foundation Package) ⚠️

**Status:** Has _pkgdown.yml with MathJax, needs full site

**Current State:**

- Has `_pkgdown.yml` with MathJax configuration
- Uses S7 class system
- Foundation for other packages

**Needs:**

- [ ] Create/update README.md
- [ ] Create "Getting Started" vignette
- [ ] Document S7 classes with @concept s7-classes
- [ ] Document methods with @concept methods
- [ ] Organize function reference
- [ ] Set up pkgdown GitHub Action
- [ ] Deploy to: <https://data-wise.github.io/medfit/>

**Special Requirements:**

- MathJax for mathematical notation
- S7 class documentation
- Technical articles for methodology

**Priority:** High (foundation for ecosystem)

---

### 5. probmed (P_med Effect Size)

**Status:** Unknown

**Expected Needs:**

- [ ] Create `_pkgdown.yml` using MEDIATIONVERSE_STANDARDS.md
- [ ] Use Academic Blue (#0054AD) + Litera theme
- [ ] Include complete ecosystem navigation
- [ ] Create README.md
- [ ] Create "Getting Started" vignette
- [ ] Organize functions with @concept tags
- [ ] Set up pkgdown GitHub Action
- [ ] Deploy to: <https://data-wise.github.io/probmed/>

**Priority:** High (core methodology package)

---

### 6. rmediation (Confidence Intervals)

**Status:** Unknown

**Expected Needs:**

- [ ] Same as probmed (full standardization)
- [ ] Deploy to: <https://data-wise.github.io/rmediation/>

**Priority:** High (core methodology package)

---

### 7. medrobust (Sensitivity Analysis)

**Status:** Unknown

**Expected Needs:**

- [ ] Same as probmed (full standardization)
- [ ] Deploy to: <https://data-wise.github.io/medrobust/>

**Priority:** Medium (specialized package)

---

### 8. medsim (Simulation Infrastructure)

**Status:** Unknown

**Expected Needs:**

- [ ] Same as probmed (full standardization)
- [ ] Deploy to: <https://data-wise.github.io/medsim/>

**Priority:** Medium (support package)

---

## 🎯 Implementation Priority

### Phase 1: High Priority (Immediate)

1. **claude-r-dev** - Standardize MkDocs documentation
2. **mediationverse** - Deploy meta-package site (ecosystem hub)
3. **medfit** - Deploy foundation package site

### Phase 2: Core Packages

4. **probmed** - Effect size package
5. **rmediation** - Confidence intervals package

### Phase 3: Supporting Packages

6. **medrobust** - Sensitivity analysis
7. **medsim** - Simulation infrastructure

---

## 📋 Standard Checklist Template

**For each repository, verify:**

### MkDocs Sites

- [ ] mkdocs.yml inherits from mkdocs-base.yml
- [ ] All required pages present
- [ ] Standard badges on homepage
- [ ] Feature grid/cards on homepage
- [ ] Quick start tabs
- [ ] Cross-project links in footer
- [ ] Standard theme configuration
- [ ] GitHub Action for deployment
- [ ] Deployed to data-wise.github.io

### R Package Sites

- [ ] _pkgdown.yml created with correct standards
- [ ] Academic Blue (#0054AD) for MediationVerse packages
- [ ] Ecosystem navigation (MediationVerse only)
- [ ] README.md with standard structure
- [ ] "Get Started" vignette created
- [ ] Functions organized with @concept tags
- [ ] NEWS.md present
- [ ] Standard badges in README
- [ ] GitHub Action for pkgdown deployment
- [ ] Deployed to data-wise.github.io/packagename

---

## 🔗 Cross-Project Integration

All sites should link to each other:

**MkDocs sites link to:**

- Other MkDocs sites (emacs-r-devkit ↔ claude-r-dev)
- Main MediationVerse hub (if applicable)

**MediationVerse packages link to:**

- All other ecosystem packages (via ecosystem menu)
- Status dashboard
- Development roadmap
- Contributing guide

---

## 📂 Documentation Files Location

**Standards Documentation:**

- MkDocs standards: `/Users/dt/emacs-r-devkit/DOCUMENTATION_STANDARDS.md`
- Shared MkDocs config: `/Users/dt/emacs-r-devkit/mkdocs-base.yml`
- Generic R package standards: `/Users/dt/emacs-r-devkit/R_PACKAGE_DOCS_STANDARDS.md`
- MediationVerse standards: Will move to `/Users/dt/R-packages/active/mediationverse/.github/MEDIATIONVERSE_STANDARDS.md`
- Implementation plan: `/Users/dt/emacs-r-devkit/IMPLEMENTATION_PLAN.md`
- **This inventory:** `/Users/dt/emacs-r-devkit/DOCUMENTATION_INVENTORY.md`

**Skill File:**

- `/Users/dt/.claude/skills/data-wise-documentation.md`

---

## 🚀 Quick Start for Each Type

### To Standardize a MkDocs Site

```bash
cd ~/path/to/project

# Update mkdocs.yml
# Add: INHERIT: https://raw.githubusercontent.com/Data-Wise/emacs-r-devkit/main/mkdocs-base.yml

# Ensure all required pages exist
touch docs_mkdocs/troubleshooting.md  # if missing

# Build and preview
mkdocs serve

# Deploy
mkdocs gh-deploy
```

### To Create pkgdown Site for MediationVerse Package

```bash
cd ~/R-packages/active/packagename

# Copy _pkgdown.yml from mediationverse or medfit as template
cp ~/R-packages/active/mediationverse/_pkgdown.yml .

# Customize for this package
# Update site_url, package name, etc.

# In R console:
library(usethis)
use_vignette("packagename", title = "Getting Started with packagename")
use_github_action("pkgdown")

# In terminal:
rdoc        # Generate roxygen documentation
rpkgdown    # Build site
rpkgpreview # Preview locally
```

---

## ❓ Questions for User

To complete this inventory, please identify:

1. **claude-r-dev location:** Where is this repository located?
2. **Other tool repositories:** Are there other tool/framework repos besides emacs-r-devkit and claude-r-dev?
3. **Other R packages:** Are there R packages outside the MediationVerse ecosystem?
4. **Repository access:** Do all these repositories exist in Data-Wise GitHub organization?
5. **Current URLs:** Which packages already have GitHub Pages deployed?

---

## 📊 Progress Tracking

**Overall Status (as of 2025-12-09):**

- ✅ **Completed:** 1/20 repositories (5%) - emacs-r-devkit
- ⚠️ **In Progress:** 3/20 repositories (15%) - claude-r-dev, mediationverse, medfit
- ❓ **Needs Assessment:** 16/20 repositories (80%)

**Discovered Ecosystem (20 repos):**

- **Dev Tools:** emacs-r-devkit, claude-r-dev, zsh-claude-workflow, examark
- **AI/MCP:** claude-statistical-research-mcp, mediationverse-gemini-extension, r-package-dev-gemini
- **MediationVerse:** mediationverse, medfit, probmed, rmediation, medrobust, medsim, missingmed
- **Other R:** regression, causal-inference
- **Infrastructure:** docs-standards, data-wise, homebrew-tap
- **Learning:** mixtape (fork)

**Next Actions:**

1. ✅ Inventory complete via GitHub API
2. Update claude-r-dev documentation
3. Deploy mediationverse and medfit pkgdown sites
4. Standardize remaining MediationVerse packages

---

**Version:** 1.0
**Last Updated:** 2025-12-07
**Maintained By:** Data-Wise Organization
