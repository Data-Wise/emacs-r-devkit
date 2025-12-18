# StatusLine Quick Start Guide

**2-Minute Setup for Claude Code StatusLine**

---

## ✅ Already Configured

Your Claude Code statusLine is **fully set up and working**!

**What you see:**
```
╭─ ░▒▓ 📁 project-name  branch ▓▒░
╰─ Sonnet 4.5 │ HH:MM │ ⏱ 2m │ +XXX/-XX │ ⚡84% W:11%
```

---

## 🚀 If You Don't See It

### For New Projects

**Option 1: Project has NO local settings** → StatusLine works automatically ✅

**Option 2: Project HAS `.claude/settings.local.json`** → Add statusLine:

```bash
cd /path/to/your/project
add-statusline-to-project
```

Then restart Claude Code:
```bash
/exit
claude
```

---

## 📊 What the StatusLine Shows

| Element | Meaning | Example |
|---------|---------|---------|
| 📦 | R package | From DESCRIPTION file |
| 📓 | Quarto project | Has _quarto.yml |
| ⚙️ | Emacs config | Has init.el |
| 🟢 | Node.js project | Has package.json |
| 🐍 | Python project | Has pyproject.toml |
| 🔌 | MCP server | Has mcp-server/ |
| main | Git branch | Current branch |
| * | Dirty repo | Uncommitted changes |
| ⇡2 | Ahead | 2 commits ahead of remote |
| ⇣3 | Behind | 3 commits behind remote |
| HH:MM | Current time | Updates every 300ms |
| ⏱ 2m | Session duration | Time in this session |
| +156 | Lines added | Green = added |
| -23 | Lines removed | Red = removed |
| ⚡84% | Session quota | Orange = high (80-95%) |
| W:11% | Weekly quota | Green = low (<50%) |

---

## 🎨 Color Coding

**Quota:**
- 🟢 Green: < 50% (safe)
- 🟡 Yellow: 50-80% (moderate)
- 🟠 Orange: 80-95% (high)
- 🔴 Red: > 95% (critical)

---

## 🔧 Update Quota

```bash
# Show current quota
cq

# Update quota (session, weekly-all, weekly-sonnet)
cq update 84 11 1

# With reset time
cq update 84 11 1 "1h 30m"
```

---

## 🧪 Test It

```bash
# Quick sanity check (10 checks, 5 seconds)
~/.claude/tests/quick-test.sh

# See visual output with all colors
~/.claude/tests/test-visual-statusline.sh

# Full diagnostic (13-point check)
~/.claude/tests/diagnose-statusline.sh
```

---

## 📁 File Locations

**Configuration:**
- Global: `~/.claude/settings.json`
- Project: `.claude/settings.local.json`
- StatusLine script: `~/.claude/statusline-p10k.sh`
- Quota config: `~/.claude/quota-config.json`

**Helper:**
- `add-statusline-to-project` - Add to any project

**Tests:**
- `~/.claude/tests/` - Complete test suite

**Docs:**
- `STATUSLINE-WORK-SUMMARY.md` - Implementation details
- `~/.claude/tests/README.md` - Test documentation
- `~/.claude/tests/BYPASS-MODE-FIX.md` - Troubleshooting

---

## ❓ Troubleshooting

**Problem:** StatusLine not showing

**Solution 1:** Check if project has local settings
```bash
ls .claude/settings.local.json
# If exists: add-statusline-to-project
```

**Solution 2:** Restart Claude Code
```bash
/exit
claude
```

**Solution 3:** Run diagnostic
```bash
~/.claude/tests/diagnose-statusline.sh
```

---

## 💡 Update Interval

**Question:** How often does statusLine update?

**Answer:** Every **300ms** (0.3 seconds)
- Built into Claude Code (cannot change)
- Only updates during conversation activity
- Optimal for performance and responsiveness

---

## 🎯 Quick Reference

```bash
# Show quota
cq

# Update quota
cq update 84 11 1

# Add to project
add-statusline-to-project

# Quick test
~/.claude/tests/quick-test.sh

# Full diagnostic
~/.claude/tests/diagnose-statusline.sh
```

---

**Everything is configured and ready to use!** 🚀

See `STATUSLINE-WORK-SUMMARY.md` for complete details.
