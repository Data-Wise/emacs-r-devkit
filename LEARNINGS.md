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

### 2025-12-09: altdoc vs pkgdown for R Package Docs

**Context:** Making MediationVerse docs match MkDocs Material design (zsh-claude-workflow).
**Insight:**

- **altdoc** is a CRAN package that generates Quarto websites for R packages.
- Auto-generates function reference like pkgdown, but outputs to Quarto.
- Setup: `altdoc::setup_docs("quarto_website")`, `altdoc::render_docs()`.
- Benefits: Dark mode, top tabs, modern themes - matches MkDocs look.
- Successfully deployed on `mediationverse` as pilot.

### 2025-12-09: GitHub Projects Kanban for Ecosystem Management

**Context:** Needed cross-repo project tracking.
**Insight:**

- GitHub Projects supports org-level Kanban boards.
- Templates: Board, Table, Roadmap, Kanban (automated), Team planning.
- Kanban template auto-moves items based on PR/issue status.
- Can link multiple repos to one project for cross-repo visibility.

### 2025-12-09: Claude Code Custom StatusLine with Powerlevel10k Theme

**Context:** Customizing Claude Code's statusLine to match terminal Powerlevel10k setup.
**Insight:**

- **StatusLine Configuration:**
  - Claude Code supports custom statusLine via shell scripts in `~/.claude/settings.json`
  - Script receives JSON input via stdin with workspace, model, state info
  - Script outputs formatted text (ANSI colors supported)
  - Window title can be set via `printf '\033]0;title\007'`

- **Key JSON Fields Available:**
  - `.workspace.current_dir` - Current working directory
  - `.workspace.project_dir` - Project root directory
  - `.model.display_name` - Model name (e.g., "Claude 3.5 Sonnet")
  - `.output_style.name` - Output style setting
  - `.state`, `.status`, `.activity` - Claude's current state

- **Powerlevel10k Mapping:**
  - P10k uses ANSI 256 colors: `48;5;N` for background, `38;5;N` for foreground
  - Directory: bg=4 (blue), fg=254 (white)
  - VCS clean: bg=2 (green), VCS modified: bg=3 (yellow)
  - Powerline separators: `\uE0B4` (left arrow), `\uE0B5` (thin separator)
  - Gradient edges: `░▒▓` and `▓▒░`

- **Implementation:** Created `~/.claude/statusline-p10k.sh` with:
  - 2-line layout matching P10k (`╭─` and `╰─` frame connectors)
  - Git status with branch, dirty indicator, ahead/behind counts
  - Dynamic window title: `project-name: Tool: description`
  - Smart path shortening for deep directories

- **Enhanced Features (v2):**
  - Project type detection with icons (R package, Quarto, MCP, Emacs, Node, Python)
  - R package version from DESCRIPTION file
  - Session duration tracking via temp files (`/tmp/claude-session-{id}`)
  - Current time display
  - Tool + description in window title (e.g., `Bash: Running: git status`)

- **Notification System:**
  - macOS native notifications via `osascript`
  - Terminal bell (`\a`) for audio alert
  - Triggers on: working → ready, error states
  - Error notifications include sound ("Basso")
  - State tracking via `/tmp/claude-state-{session_id}`

- **Configuration File:** `~/.claude/statusline-config.json`
  ```json
  {
    "notifications": {
      "enabled": true,
      "on_ready": true,
      "on_error": true,
      "bell": true,
      "macos": true
    }
  }
  ```
  Toggle any setting to `false` to disable that feature.
