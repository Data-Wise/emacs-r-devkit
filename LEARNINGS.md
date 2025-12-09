# Learnings & Insights

**A collective brain for technical decisions, "gotchas", and patterns.**

Use this file to capture knowledge that doesn't fit into formal documentation but is valuable for the team (and your future self).

---

## 📝 Format

- **Date**: YYYY-MM-DD
- **Topic**: Brief title
- **Context**: What were we trying to do?
- **Insight**: What did we learn? / What was the solution?

---

## 🧠 Brain Dump

### 2025-12-09: GitHub Fine-Grained Tokens

**Context:** Authenticating GitHub CLI with enhanced security.
**Insight:**

- Fine-grained tokens are preferred over Classic tokens.
- Minimum scopes for CLI usually include `Contents: Read and Write`, `Metadata: Read-only`.
- `gh auth login` handles the token exchange flow smoothly.

### 2025-12-09: Data-Wise Ecosystem Research

**Context:** Understanding the relationship between `emacs-r-devkit` and `claude-r-dev`.
**Insight:**

- **Complementary Roles:**
  - `emacs-r-devkit` is the **Environment (IDE)**: Focused on editing, interactive R (ESS), and developer ergonomics.
  - `claude-r-dev` is the **Intelligence (AI)**: Focused on workflow automation (reviews, testing, refactoring) using Claude.
- **Integration Point:** `emacs-r-devkit` is the perfect host for `claude-r-dev` workflows (via terminal or future MCP integration).
- **Shared DNA:** Both enforce specific R package standards (S7, testthat, roxygen2).

### 2025-12-07: MkDocs Material Overrides

**Context:** Moving badges to sidebar.
**Insight:**

- Use `overrides/main.html` to inject content into blocks.
- `{% block content %}` allows prepending or appending to main content.
- CSS grid layout in `extra.css` is needed to handle the sidebar positioning effectively.

### 2025-12-09: GitHub CLI Timeout Issues

**Context:** Creating repos via `gh` CLI for ecosystem infrastructure.
**Insight:**

- **Problem:** `gh repo create` and `gh repo view` commands hung indefinitely.
- **Root Cause:** Likely credential prompt blocking, network latency, or token refresh.
- **Workarounds:**
  1. Use `timeout 10 gh ...` wrapper to enforce time limits.
  2. Create repos manually via GitHub web UI.
  3. Use `gh api` with explicit timeouts for programmatic access.
- **Best Practice:** Always wrap `gh` commands in scripts with timeout protection.

### 2025-12-09: Fine-Grained PAT for Organizations

**Context:** Creating repos under Data-Wise org.
**Insight:**

- Fine-grained PATs need **explicit org permissions** to create repos.
- Required: `Administration: Read and Write` under Organization permissions.
- Listing repos works with `repo` scope, but creating requires `admin:org`.

### 2025-12-09: Complete Ecosystem Inventory via GitHub API

**Context:** Resuming ecosystem integration work, needed full inventory.
**Insight:**

- Used `gh repo list Data-Wise --limit 20 --json name,description,url` with timeout wrapper.
- **20 repositories discovered** across categories:
  - Dev Tools: emacs-r-devkit, claude-r-dev, zsh-claude-workflow, examark
  - AI/MCP: claude-statistical-research-mcp, mediationverse-gemini-extension, r-package-dev-gemini
  - MediationVerse: mediationverse, medfit, probmed, rmediation, medrobust, medsim, missingmed
  - Infrastructure: docs-standards, data-wise (org profile), homebrew-tap
- Key finding: `docs-standards` repo already exists (Phase 1 foundation complete).
