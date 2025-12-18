# Documentation Standardization - Implementation Plan

**Roadmap for standardizing all Data-Wise documentation**

## 📊 Current State Assessment

### Existing Projects

| Project | Type | Current Docs | Standard Needed |
|---------|------|--------------|-----------------|
| **spacemacs-rstats** | Tool | MkDocs (new) | ✅ Already standard |
| **claude-r-dev** | Framework | MkDocs | Needs update |
| **MediationVerse packages** | R packages | pkgdown (?) | Needs assessment |
| **Other R packages** | R packages | pkgdown (?) | Needs assessment |

## 🎯 Implementation Strategy

### Phase 1: Foundation (Week 1)

**Goal:** Establish shared resources and standards

#### 1.1 Create Shared Configuration Repository

```bash
# Create data-wise/docs-standards repository
gh repo create Data-Wise/docs-standards --public \
  --description "Shared documentation standards for Data-Wise projects"

cd docs-standards

# Add standard files
mkdocs-base.yml           # Shared MkDocs config
_pkgdown-base.yml         # Shared pkgdown config
DOCUMENTATION_STANDARDS.md
R_PACKAGE_DOCS_STANDARDS.md
templates/                # Page templates
  ├── index.md.template
  ├── getting-started.md.template
  ├── configuration.md.template
  └── troubleshooting.md.template
```

**Files to create:**

1. **mkdocs-base.yml** - Shared MkDocs configuration
2. **_pkgdown-base.yml** - Shared pkgdown configuration
3. **templates/** - Standard page templates
4. **README.md** - How to use the standards

#### 1.2 Document Existing Projects

Create inventory of all projects:

```markdown
# Data-Wise Projects Inventory

## Documentation Sites (MkDocs)
- spacemacs-rstats (✅ standardized)
- claude-r-dev (⚠️ needs update)
- [Other projects...]

## R Packages (pkgdown)
- Package 1
- Package 2
- [List all...]
```

### Phase 2: Update Existing MkDocs Sites (Week 2)

**Projects:** claude-r-dev, others

#### For each project:

1. **Backup current site:**
   ```bash
   git checkout -b pre-standardization-backup
   git push origin pre-standardization-backup
   ```

2. **Update mkdocs.yml:**
   ```yaml
   # Option 1: Use INHERIT (if MkDocs 1.5+)
   INHERIT: https://raw.githubusercontent.com/Data-Wise/docs-standards/main/mkdocs-base.yml

   # Option 2: Copy sections manually
   # Copy theme, plugins, markdown_extensions from mkdocs-base.yml
   ```

3. **Standardize navigation:**
   ```yaml
   nav:
     - Home: index.md
     - Getting Started: getting-started.md
     - [Project-specific sections]
     - Configuration: configuration.md
     - Troubleshooting: troubleshooting.md
     - Contributing: contributing.md
   ```

4. **Update pages:**
   - Ensure all required sections present
   - Add standard badges to index.md
   - Use consistent formatting
   - Add cross-project links

5. **Update footer:**
   ```yaml
   extra:
     projects:
       - name: spacemacs-rstats
         url: https://data-wise.github.io/spacemacs-rstats/
         description: Emacs environment for R development
       - name: claude-r-dev
         url: https://data-wise.github.io/claude-r-dev/
         description: AI-powered R package development
       # Add all projects
   ```

6. **Test locally:**
   ```bash
   mkdocs serve
   # Review at http://127.0.0.1:8000/
   ```

7. **Deploy:**
   ```bash
   git checkout -b standardize-documentation
   git add .
   git commit -m "Standardize documentation structure"
   git push origin standardize-documentation
   gh pr create --title "Standardize documentation" \
     --body "Updates documentation to follow Data-Wise standards"
   ```

### Phase 3: Standardize R Packages (Weeks 3-4)

**For each R package:**

#### 3.1 Setup pkgdown

```r
# In R console
usethis::use_pkgdown()
usethis::use_pkgdown_github_pages()
```

#### 3.2 Create `_pkgdown.yml`

```yaml
# Start with base config
url: https://data-wise.github.io/packagename/

template:
  bootstrap: 5
  bootswatch: flatly  # Choose appropriate theme

# Standard navigation
navbar:
  structure:
    left:  [home, intro, reference, articles, news]
    right: [search, github]

# Organize function reference
reference:
  - title: Main Functions
    contents:
      - has_concept("main")
  - title: Helpers
    contents:
      - has_concept("helpers")

# Organize articles
articles:
  - title: Getting Started
    navbar: ~
    contents:
      - packagename
```

#### 3.3 Create Get Started Vignette

```bash
usethis::use_vignette("packagename", title = "Getting Started with packagename")
```

**Content structure:**
1. Installation
2. Quick example
3. Basic usage
4. Next steps

#### 3.4 Update README

- Add standard badges
- Use consistent structure
- Link to pkgdown site
- Add quick example

#### 3.5 Setup GitHub Actions

```bash
usethis::use_github_action("pkgdown")
```

#### 3.6 Organize Functions

Add `@concept` tags to functions:

```r
#' @concept main
#' @concept helpers
#' @concept internal
```

### Phase 4: Create Ecosystem Overview (Week 5)

**For related packages (e.g., MediationVerse):**

#### 4.1 Create Ecosystem Site

```bash
# Create new repository
gh repo create Data-Wise/mediationverse-docs --public

# Use MkDocs for ecosystem overview
mkdocs new mediationverse-docs
```

#### 4.2 Structure

```markdown
# MediationVerse

Ecosystem of R packages for mediation analysis

## Packages

### Core Packages
- **mediator** - Foundation mediation analysis
- **modmed** - Moderated mediation
- **serialmed** - Sequential/serial mediation

### Specialized Packages
- **bayesmed** - Bayesian mediation
- **survmed** - Survival mediation

## Getting Started

Choose your starting point:
- [Simple mediation](packages/mediator/)
- [Moderated mediation](packages/modmed/)
- [Sequential mediation](packages/serialmed/)

## Tutorials

- [Tutorial 1: Basic mediation workflow]
- [Tutorial 2: Complex models]
- [Tutorial 3: Advanced topics]
```

#### 4.3 Link Individual Packages

Each package pkgdown site links to:
- Ecosystem overview
- Related packages
- Cross-package tutorials

### Phase 5: Cross-Project Integration (Week 6)

#### 5.1 Create Project Directory

**On main Data-Wise GitHub org page:**

Create pinned repository: `data-wise/data-wise` (special repo)

**README.md:**
```markdown
# Data-Wise

Organization overview and project directory

## 🛠️ Development Tools

- [spacemacs-rstats](https://data-wise.github.io/spacemacs-rstats/) -
  Professional Emacs environment for R development

- [claude-r-dev](https://data-wise.github.io/claude-r-dev/) -
  AI-powered R package development workflows

## 📦 R Packages

### Statistical Methods
- [Package 1](link) - Description
- [Package 2](link) - Description

### Mediation Analysis (MediationVerse)
- [mediator](link) - Core mediation
- [modmed](link) - Moderated mediation
- [Ecosystem Overview](https://data-wise.github.io/mediationverse/)

## 📚 Documentation

All projects follow [Data-Wise documentation standards](https://github.com/Data-Wise/docs-standards).

## 🤝 Contributing

See individual project contribution guidelines.
```

#### 5.2 Update All Sites

Add to every documentation site:

**Footer navigation:**
```yaml
extra:
  data_wise:
    org_url: https://github.com/Data-Wise
    projects_url: https://github.com/Data-Wise/data-wise
```

**In footer template:**
```html
<div class="md-footer-meta__inner md-grid">
  <p>Part of <a href="https://github.com/Data-Wise">Data-Wise</a> |
     <a href="https://github.com/Data-Wise/data-wise">All Projects</a>
  </p>
</div>
```

### Phase 6: Maintenance & Quality (Ongoing)

#### 6.1 Quarterly Reviews

**Checklist:**
- [ ] Update cross-project links
- [ ] Refresh screenshots
- [ ] Update version badges
- [ ] Check for broken links
- [ ] Sync with latest Material/pkgdown versions
- [ ] Review analytics for improvement areas

#### 6.2 New Project Checklist

When adding new project:

1. [ ] Choose appropriate documentation type (MkDocs/pkgdown)
2. [ ] Use standard configuration
3. [ ] Follow navigation structure
4. [ ] Add to project directory
5. [ ] Add cross-links to all sites
6. [ ] Setup CI/CD
7. [ ] Add standard badges

## 📋 Project-Specific Action Items

### spacemacs-rstats
- ✅ Already standardized
- [ ] Add cross-project links when others updated

### claude-r-dev

**Immediate Actions:**

1. **Update navigation** to match standard:
   ```yaml
   nav:
     - Home: index.md
     - Getting Started: getting-started.md
     - Commands Reference: commands-reference.md
     - Profiles: profiles.md
     - Configuration: config-schema.md
     - Customization: customization-guide.md
     - Tutorials:
         - Overview: tutorials/index.md
         - [Existing tutorials...]
     - Troubleshooting: troubleshooting.md  # ADD
     - Contributing: contributing.md
   ```

2. **Create troubleshooting.md:**
   - Common issues section
   - Error messages guide
   - Link from Getting Started

3. **Add cross-project links:**
   ```yaml
   extra:
     projects:
       - spacemacs-rstats
       - claude-r-dev (current)
       - [other projects]
   ```

4. **Standardize badges:**
   - Ensure all standard badges present
   - Update URLs if needed
   - Check badge appearance

### R Packages (TBD based on your package list)

**For each package:**

1. [ ] Create `_pkgdown.yml` with standard config
2. [ ] Setup pkgdown GitHub Action
3. [ ] Create Get Started vignette
4. [ ] Organize function reference
5. [ ] Update README with standard structure
6. [ ] Add badges
7. [ ] Deploy to gh-pages

## 🎯 Success Metrics

Documentation standardization is complete when:

- [ ] All MkDocs sites use mkdocs-base.yml
- [ ] All R packages have pkgdown sites
- [ ] Navigation is consistent across similar projects
- [ ] All sites cross-link appropriately
- [ ] Project directory exists with all projects
- [ ] All sites have standard badges
- [ ] Documentation follows style guide
- [ ] Users report easy navigation across projects

## 🛠️ Tools & Resources

### Required Tools

```bash
# For MkDocs sites
pip install mkdocs-material mkdocs-minify-plugin

# For R packages
install.packages(c("pkgdown", "usethis", "devtools"))
```

### Helpful Commands

```bash
# Test MkDocs locally
mkdocs serve

# Build and preview pkgdown
pkgdown::build_site()

# Check links
linkchecker http://localhost:8000

# Compare configurations
diff site1/mkdocs.yml site2/mkdocs.yml
```

## 📅 Timeline

| Phase | Duration | Deliverable |
|-------|----------|-------------|
| 1. Foundation | Week 1 | Shared config repo, standards docs |
| 2. Update MkDocs | Week 2 | claude-r-dev + others standardized |
| 3. R Packages | Weeks 3-4 | All packages with pkgdown |
| 4. Ecosystem | Week 5 | MediationVerse overview site |
| 5. Integration | Week 6 | Cross-links, project directory |
| 6. Maintenance | Ongoing | Quarterly reviews |

**Total Initial Effort:** 6 weeks
**Ongoing:** Quarterly reviews + new project setup

## 🚀 Getting Started

**Today:**
1. Review DOCUMENTATION_STANDARDS.md
2. Review R_PACKAGE_DOCS_STANDARDS.md
3. Decide on implementation timeline

**This Week:**
1. Create docs-standards repository
2. Inventory all current projects
3. Prioritize which projects to update first

**Next Week:**
1. Begin Phase 2 (update existing MkDocs sites)
2. Test standardization on one R package

---

**Questions or suggestions?** Open an issue in [docs-standards](https://github.com/Data-Wise/docs-standards/issues)

**Version:** 1.0
**Last Updated:** 2025-12-07
