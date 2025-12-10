# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Standard coordination files: `ROADMAP.md`, `LEARNINGS.md`, `KNOWLEDGE_INDEX.md`.
- New directory structure for documentation (`guides/`, `standards/`, `docs_mkdocs/`).
- **Claude Code StatusLine**: Custom Powerlevel10k-inspired statusLine script (`~/.claude/statusline-p10k.sh`).
  - Rainbow theme colors matching P10k (blue directory, green/yellow git status)
  - Powerline separators and gradient edges (`░▒▓`, `▓▒░`)
  - 2-line layout with frame connectors (`╭─`, `╰─`)
  - Git status: branch name, `*` dirty, `⇣n`/`⇡n` behind/ahead, `?n` untracked
  - Dynamic window title: `project-name: state` (Thinking, Ready, etc.)
  - Smart path shortening for deep directories

### Changed

- Moved user guides to `guides/` directory.
- Moved documentation standards to `standards/` directory.

## [2.0.0] - 2025-12-07

### Added

- **MkDocs Support**: Full migration to MkDocs for documentation website.
- **Project Structure**: Consolidated root files into organized subdirectories.

### Changed

- Refactored `PROJECT_STRUCTURE.md` to reflect new layout.
