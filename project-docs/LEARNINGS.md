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

### 2025-12-09: Claude Quota Tracking System

**Context:** Tracking Claude Pro/Max subscription usage limits.
**Insight:**

- **What Claude Desktop Shows:**
  - Session limit (resets after inactivity) - e.g., 84%
  - Weekly All Models (resets Tuesday ~2 PM) - e.g., 11%
  - Weekly Sonnet Only (resets Tuesday ~8 PM) - e.g., 1%

- **What's NOT Accessible Programmatically:**
  - Claude Desktop doesn't expose quota data via API
  - Claude Code's `/cost` and `/usage` show session info, not account quotas
  - No direct API to Anthropic account usage (web console only)

- **Solution: Manual Tracking System:**
  - Config: `~/.claude/quota-config.json` stores limits and current values
  - Shell command: `claude-quota` or `cq` for quick status
  - Update command: `cq update 84 11 1` (session, weekly-all, weekly-sonnet)
  - Slash command: `/quota` for in-Claude display
  - StatusLine: Shows session % with color coding (green→yellow→orange→red)

- **Commands Created:**
  - `~/.claude/bin/claude-quota` - Main quota script
  - `~/.claude/commands/quota.md` - Slash command template
  - Symlinks: `claude-quota` and `cq` in workflow commands

- **Color Thresholds:**
  - Green: < 50%
  - Yellow: 50-80%
  - Orange: 80-95%
  - Red: > 95%

- **Reset Time Tracking (v2):**
  - Uses **epoch timestamps** for timezone-agnostic calculations
  - Update: `cq update 84 11 1 "1h 29m"` - parses relative time to epoch
  - Display: `⚡84%(1h21m)` - calculates remaining from stored epoch
  - Avoids ISO date string timezone conversion issues

- **SessionStart Hook:**
  - Shows quota automatically when Claude Code starts
  - Configured in `~/.claude/settings.json`:

    ```json
    "hooks": {
      "SessionStart": [{"type": "command", "command": "/Users/dt/.claude/bin/claude-quota"}]
    }
    ```

- **Toggle Command:**
  - `/quota-toggle` slash command or `cqt` shell alias
  - Toggles `.display.show_quota` in `~/.claude/statusline-config.json`
  - **jq gotcha:** Boolean false vs missing value
    - Wrong: `jq -r '.display.show_quota // true'` - treats `false` as falsy
    - Right: `jq -r '.display.show_quota | tostring'` - returns literal "true"/"false"

### 2025-12-10: Claude Code StatusLine Implementation

**Context:** Implementing custom statusLine with Powerlevel10k theme for Claude Code.

**Key Learnings:**

1. **Settings Precedence is Critical:**
   - Project `.claude/settings.local.json` **completely overrides** global `~/.claude/settings.json`
   - No inheritance - must explicitly include all desired settings
   - StatusLine in global settings won't show if project has local settings without it

2. **Update Interval is Optimal:**
   - Claude Code updates statusLine every **300ms** (hardcoded)
   - Only updates during conversation activity (not idle)
   - Cannot be customized, but doesn't need to be - already optimal
   - Perfect balance: responsive but not wasteful

3. **StatusLine and Permissions Are Independent:**
   - StatusLine execution is NOT subject to permission system
   - It's a display feature, not a tool requiring approval
   - Bypass permission mode doesn't affect statusLine
   - Confusion arose because both were in same settings file

4. **Test Suite Value:**
   - 57 comprehensive tests caught configuration issues quickly
   - Visual tests verify actual appearance (colors, icons, layout)
   - Diagnostic script (13 checks) identifies problems in 5 seconds
   - Quick test validates critical functionality instantly

5. **Project Type Detection:**
   - File-based detection works reliably:
     - R package: `DESCRIPTION` with `Package:` field
     - Quarto: `_quarto.yml` or `_quarto.yaml`
     - Emacs: `init.el`
     - Node: `package.json`
     - Python: `pyproject.toml` or `setup.py`
     - MCP: `mcp-server/` dir or "mcp" in path
   - Icons provide instant visual feedback

6. **User Preferences Matter:**
   - Cost display (`💰$X.XX`) removed per user request
   - Lines changed (`+4406/-267`) kept - shows code activity
   - Configuration flexibility important for different users

7. **Helper Scripts Reduce Friction:**
   - `add-statusline-to-project` makes setup trivial
   - Automatically handles new vs existing settings
   - Checks for duplicates to avoid mistakes

8. **Documentation is Essential:**
   - Created 4 comprehensive guides (~10,000 words)
   - Users need both quick-start AND deep troubleshooting
   - Visual examples more helpful than text descriptions
   - Separate docs for different audiences (users vs developers)

**Implementation Stats:**

- Development time: ~2 hours
- Files created: 16 (tests + docs)
- Lines of code/docs: ~4,200
- Test coverage: ~95%
- Tests passing: 57/57

**Best Practices Established:**

1. Always include statusLine in project settings if they exist
2. Use helper script for consistency
3. Test visually after changes
4. Document color coding thresholds
5. Provide both quick and comprehensive tests

**Gotchas to Remember:**

- Project settings **override**, not extend
- StatusLine must be in **every** project with local settings
- 300ms is perfect - don't try to "optimize" it
- Window title requires OSC escape sequence
- jq boolean handling: use `tostring`, not `// true` fallback

**Files Created:**

- Test suite: `~/.claude/tests/` (16 files)
- Helper: `~/.claude/bin/add-statusline-to-project`
- Docs: STATUSLINE-WORK-SUMMARY.md, BYPASS-MODE-FIX.md

### 2025-12-10: Auto-Refresh Quota Daemon

**Context:** User wanted quota display to refresh automatically every 5 minutes without manual intervention.

**Insight:**

1. **Solution Architecture:**
   - macOS `launchd` daemon (native scheduler) runs every 300 seconds
   - Bash script reads quota config and checks thresholds
   - Logs all activity with timestamps
   - Shows macOS notifications on threshold breach

2. **Key Implementation Details:**
   - **Plist config:** ~/Library/LaunchAgents/com.user.claude-quota-refresh.plist
   - **Main script:** ~/.claude/bin/quota-refresh.sh (reads config, no external API)
   - **Control script:** ~/.claude/bin/quota-daemon-setup.sh (load/unload/status/logs)
   - **Interval:** 300 seconds (5 minutes) - sufficient for quota monitoring

3. **Important Limitation:**
   - Daemon **reads** quota values from config file
   - Still requires manual update: `cq update SESSION WEEKLY_ALL WEEKLY_SONNET`
   - Claude has no API to programmatically fetch quota
   - Daemon bridges the gap: once you update, it auto-displays every 5 min

4. **Features Implemented:**
   - ✅ Runs silently in background
   - ✅ Auto-starts on system login
   - ✅ Survives system restart
   - ✅ Configurable alert thresholds (70% warn, 90% critical)
   - ✅ Full logging with timestamps
   - ✅ macOS notifications
   - ✅ Easy control commands (load/unload/status/logs)

5. **Workflow Integration:**
   - Check Claude Desktop every few hours
   - Run: `cq update X Y Z`
   - Daemon automatically refreshes display in StatusLine
   - No further action needed until next check

6. **Files Created:**
   - ~/.claude/bin/quota-refresh.sh - Main refresh logic
   - ~/.claude/bin/quota-daemon-setup.sh - Control interface
   - ~/Library/LaunchAgents/com.user.claude-quota-refresh.plist - System config
   - ~/.claude/QUOTA-DAEMON-GUIDE.md - Full documentation
   - ~/.claude/QUOTA-AUTO-REFRESH-SETUP.md - Setup notes

7. **Gotchas:**
   - launchd uses `.plist` XML format (strict syntax)
   - KeepAlive + StartInterval = restarts on failure (good for reliability)
   - Daemon can't directly update config (would need another layer)
   - Logs should be cleaned up manually if they grow large

**Status:** Active and running (loaded at 2025-12-10 11:23)
**Test:** Script verified working, logs showing regular 5-minute checks

### 2025-12-10: Spacemacs Keybinding Analysis & Migration Planning

**Context:** User requested investigation of Emacs keybindings, specifically looking for "space emacs" or SPC leader key configurations. Created comprehensive learning materials for potential Spacemacs migration.

**Insight:**

1. **Current Setup Analysis:**
   - GNU Emacs 30.2 (Homebrew emacs-plus)
   - emacs-plus has **no special keybindings** - identical to vanilla Emacs with macOS patches
   - Current config uses non-standard modifier mapping: Command=Meta, Option=Super
   - Total ~25 custom keybindings organized under `C-c r` (R development) and `C-c o` (Obsidian)

2. **Critical Issue Discovered:**
   - **Modifier key documentation mismatch** between `init.el` and documentation
   - `init.el` configured: `Command` = `Meta`, `Option` = `Super`
   - All documentation stated: `Option` = `Meta` (standard Emacs convention)
   - This contradiction meant all keybinding instructions were incorrect

3. **Spacemacs Research Findings:**
   - Spacemacs uses **Space (SPC)** as leader key in Normal mode (Vim-style)
   - Mnemonic organization: `SPC f` (files), `SPC b` (buffers), `SPC p` (projects)
   - Built on Evil mode (Vim emulation) + extensive which-key integration
   - Default modifier mapping: `Option` = `Meta`, `Command` = `Super`
   - ESS layer provides R development support via `SPC m` prefix

4. **Learning Materials Created:**
   - **01-SPACEMACS-GUIDE.md** (~600 lines) - Philosophy, comparison, macOS integration
   - **02-LEARNING-CURRICULUM.md** (~800 lines) - 28-day modular curriculum with daily lessons
   - **03-CHEAT-SHEETS.md** (~400 lines) - Printable weekly reference cards
   - **00-QUICK-START.md** (~250 lines) - Step-by-step installation guide
   - Total: ~2,680 lines of comprehensive documentation

5. **Curriculum Structure:**
   - **Week 1:** Vim basics (modal editing, hjkl, editing commands)
   - **Week 2:** Spacemacs navigation (SPC system, file/buffer/window mgmt)
   - **Week 3:** R development workflow (ESS, custom functions, package dev)
   - **Week 4:** Advanced features (macros, text objects, Magit)
   - Each day: 15-30 minute lessons with R-focused examples
   - Progressive difficulty with practice exercises and self-assessment

6. **Migration Plan Revised:**
   - **Recommended:** Switch to traditional modifier mapping (Option=Meta)
   - **Rationale:** Aligns with Spacemacs defaults, community standards, all tutorials
   - **Week 0:** Update modifiers, practice 2-3 days, backup config
   - **Week 1-4:** Follow structured curriculum
   - **Expected productivity:** 50% (Week 1-2) → 120%+ (Month 2+)

7. **Custom Function Integration:**
   - All emacs-r-devkit functions can be mapped to Spacemacs style
   - Example mapping: `SPC m r r` → `insert-roxygen-skeleton`
   - Shorter alternative: `,` as major-mode leader (`, r r` same as `SPC m r r`)
   - Can create custom Spacemacs layer for emacs-r-devkit

8. **Alternative Approach:**
   - Gradual migration possible via Evil + General.el
   - Adds Space leader and modal editing to existing config
   - Less dramatic change than full Spacemacs
   - Lighter weight but fewer community features

**Documentation Created:**

- `guides/keybinding-analysis/` (3 files):
  - `KEYBINDING-SUMMARY.md` - Current keybinding reference
  - `ENHANCEMENT-PLAN.md` - Spacemacs migration roadmap
  - `README.md` - Directory overview
- `guides/spacemacs-learning/` (5 files):
  - `00-QUICK-START.md` - Installation quick-start
  - `01-SPACEMACS-GUIDE.md` - Comprehensive introduction
  - `02-LEARNING-CURRICULUM.md` - 28-day curriculum
  - `03-CHEAT-SHEETS.md` - Printable references
  - `README.md` - Directory overview

**Key Decisions:**

1. Recommend switching to Option=Meta (traditional Emacs)
2. Focus on full Spacemacs migration (not gradual)
3. 4-week structured learning approach
4. R development workflow as primary use case

**Expected Learning Timeline:**

- Day 1-7: Frustrating (Vim basics)
- Day 8-14: Clicking (SPC system)
- Day 15-21: Breakthrough (R workflow restored)
- Day 22-28: Mastery (faster than before)
- Month 2+: Never going back

**Gotchas to Remember:**

- Week 1 is hardest - modal editing takes time
- Update modifier keys BEFORE installing Spacemacs
- Backup everything before migration
- Print cheat sheets for desk reference
- Practice daily (15-30 min) beats weekend marathons
- Custom functions need explicit loading in ~/.spacemacs

**Files Modified:**

- Created 8 new documentation files (~2,680 lines)
- No code changes to init.el yet (pending user decision)

### 2025-12-10: Troubleshooting Google Workspace Gemini Extension

**Context:** Diagnosing and fixing startup errors with the `google-workspace` extension in the Gemini CLI.
**Insight:**

- **Symptom:** Extension failed to start with connection errors.
- **Root Cause:**
  - Missing `package.json` in the extension directory preventing standard `npm install`.
  - Missing `jsdom` dependency in `node_modules`.
- **Resolution:**
  - Uninstalled the corrupted extension: `gemini extensions uninstall google-workspace`.
  - Reinstall is the recommended fix (vs manual patching) to ensure file integrity.
- **Key Takeaway:** Extension corruption can occur where metadata files are missing. Always check file structure (`ls -la`) before attempting manual repairs. Uninstall/reinstall is cleaner.

### 2025-12-10: Spacemacs Migration & Emacs Compilation Issues

**Context:** Migrating from vanilla Emacs to Spacemacs on macOS.
**Insight:**

- **Issue:** `emacs-plus@30` failed to compile/launch due to a dependency mismatch with `tree-sitter` (v0.26 vs v0.25).
- **Resolution:** Switched to `emacs-mac` (RailwayCat) via Homebrew Cask. This provides a pre-built binary, avoiding local compilation errors.
- **Key Config:** Updated `zshrc` to point `PATH`, `EDITOR`, and `VISUAL` to the `emacs-mac` location.
- **Spacemacs:** Cloned `develop` branch to `~/.emacs.d`.
- **Config:** Created a robust `.spacemacs` template enabling `ess`, `lsp`, `git`, and `projectile` layers.

### 2025-12-10: Spacemacs Installation Troubleshooting

**Context:** Finalizing Spacemacs setup after migration.
**Insight:**

- **Errors:** `wrong-type-argument package-desc nil` during package install.
- **Cause:** Corrupted ELPA metadata/cache from interrupted initial launch.
- **Fix:** "Nuclear" cleanup required: `rm -rf ~/.emacs.d/elpa ~/.emacs.d/.cache` followed by a fresh Emacs launch.
- **Projectile:** Spacemacs (develop branch) includes Projectile in core; explicit layer declaration might be redundant if it triggers "unknown layer" warning.

### 2025-12-13: Emacs R Development Kit Enhancement Plan

**Context:** Analysis of emacs-r-devkit project for creating a comprehensive enhancement plan.
**Insight:**

- **Critical Issue:** Spacemacs configuration installed but not properly configured - R development workflow is broken
- **Empty user-config section** in Spacemacs configuration causing functions not to load
- **Documentation promises functionality** that doesn't exist in current config
- **Enhancement Plan Developed** with 5 phases:
  1. **Phase 1: Critical Fixes** (Week 1) - Port functions to Spacemacs, configure keybindings, verify workflow (CRITICAL)
  2. **Phase 2: Optimization** (Week 2) - Enhanced ESS config, performance optimization, custom layer (HIGH)
  3. **Phase 3: Documentation** (Week 2-3) - Update docs, migration guide, integrate learning materials (MEDIUM)
  4. **Phase 4: Advanced Features** (Week 3-4) - Hydra menus, MediationVerse integration, Claude AI integration (LOW)
  5. **Phase 5: MCP Integration** (Week 5-6) - Obsidian Knowledge Manager MCP, Emacs IDE MCP server (FUTURE)

- **Time Investment:** 66-105 hours over 6 weeks
- **ROI:** Fixes currently broken R workflow, enables productive R development, foundation for AI integration
- **Key Realization:** Need to prioritize fixing broken functionality before adding new features
- **Success Metrics:** All custom functions working, complete R workflow tested, no functionality regression from vanilla config