#!/usr/bin/env bash
# create-test-fixtures.sh
# Creates mock environments for testing installation scripts

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
FIXTURES_DIR="$PROJECT_ROOT/tests/fixtures"

echo "Creating test fixtures..."
echo ""

# Clean old fixtures
if [[ -d "$FIXTURES_DIR" ]]; then
    echo "Removing old fixtures..."
    rm -rf "$FIXTURES_DIR"
fi

mkdir -p "$FIXTURES_DIR"

# 1. Fresh system (nothing installed)
echo "1. Creating 'fresh' fixture (no Emacs, no Spacemacs)..."
mkdir -p "$FIXTURES_DIR/fresh"
cat > "$FIXTURES_DIR/fresh/README.md" << 'EOF'
# Fresh System Fixture

Simulates a completely fresh macOS system with:
- No Emacs
- No Spacemacs
- No configuration

Expected health level: 4 (NOT_INSTALLED)
EOF

# 2. Emacs only (no Spacemacs)
echo "2. Creating 'emacs-only' fixture..."
mkdir -p "$FIXTURES_DIR/emacs-only/bin"
cat > "$FIXTURES_DIR/emacs-only/bin/emacs" << 'EOF'
#!/bin/bash
echo "GNU Emacs 30.0.50"
EOF
chmod +x "$FIXTURES_DIR/emacs-only/bin/emacs"
cat > "$FIXTURES_DIR/emacs-only/README.md" << 'EOF'
# Emacs Only Fixture

Simulates system with:
- Emacs installed
- No Spacemacs
- No configuration

Expected health level: 4 (NOT_INSTALLED)
EOF

# 3. Fully installed (complete setup)
echo "3. Creating 'installed' fixture..."
mkdir -p "$FIXTURES_DIR/installed/.emacs.d"
touch "$FIXTURES_DIR/installed/.emacs.d/init.el"
cat > "$FIXTURES_DIR/installed/.emacs.d/init.el" << 'EOF'
;; Spacemacs initialization
(defun spacemacs/init ()
  "Initialize Spacemacs")
EOF

cat > "$FIXTURES_DIR/installed/.spacemacs" << 'EOF'
;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; spacemacs-rstats configuration

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-configuration-layers
   '(ess
     auto-completion
     syntax-checking
     lsp)))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-distribution 'spacemacs))
EOF

mkdir -p "$FIXTURES_DIR/installed/.emacs.d/bin"
cat > "$FIXTURES_DIR/installed/.emacs.d/bin/export-gui-path.sh" << 'EOF'
#!/bin/bash
# Mock helper script
echo "Exporting PATH for GUI Emacs"
EOF
chmod +x "$FIXTURES_DIR/installed/.emacs.d/bin/export-gui-path.sh"

cat > "$FIXTURES_DIR/installed/README.md" << 'EOF'
# Fully Installed Fixture

Simulates complete installation:
- Emacs installed
- Spacemacs installed
- spacemacs-rstats configuration
- Helper scripts

Expected health level: 0 (HEALTHY) or shows "Already Installed"
EOF

# 4. Conflicting Emacs versions
echo "4. Creating 'conflicting' fixture..."
mkdir -p "$FIXTURES_DIR/conflicting/bin"
for version in emacs emacs-29 emacs-30 emacs-plus; do
    cat > "$FIXTURES_DIR/conflicting/bin/$version" << 'EOF'
#!/bin/bash
echo "GNU Emacs 30.0.50"
EOF
    chmod +x "$FIXTURES_DIR/conflicting/bin/$version"
done

cat > "$FIXTURES_DIR/conflicting/README.md" << 'EOF'
# Conflicting Emacs Fixture

Simulates system with:
- Multiple Emacs installations
- Version conflicts

Expected: Pre-flight should offer to clean up
EOF

# 5. Corrupted installation
echo "5. Creating 'corrupted' fixture..."
mkdir -p "$FIXTURES_DIR/corrupted/.emacs.d"
cat > "$FIXTURES_DIR/corrupted/.emacs.d/init.el" << 'EOF'
;; Corrupted Spacemacs init
(defun spacemacs/init ()
  (error "Corrupted"))
EOF

cat > "$FIXTURES_DIR/corrupted/.spacemacs" << 'EOF'
;; Corrupted .spacemacs
(defun dotspacemacs/layers ()
  ;; Missing closing paren
  (setq-default
   dotspacemacs-configuration-layers
   '(ess
EOF

cat > "$FIXTURES_DIR/corrupted/README.md" << 'EOF'
# Corrupted Installation Fixture

Simulates corrupted installation:
- Spacemacs present but broken
- Invalid .spacemacs syntax

Expected health level: 2-3 (NEEDS_REPAIR or NEEDS_REINSTALL)
EOF

# 6. Spacemacs without our config
echo "6. Creating 'spacemacs-vanilla' fixture..."
mkdir -p "$FIXTURES_DIR/spacemacs-vanilla/.emacs.d"
cat > "$FIXTURES_DIR/spacemacs-vanilla/.emacs.d/init.el" << 'EOF'
;; Spacemacs initialization
(defun spacemacs/init ()
  "Initialize Spacemacs")
EOF

cat > "$FIXTURES_DIR/spacemacs-vanilla/.spacemacs" << 'EOF'
;; Vanilla Spacemacs configuration (no spacemacs-rstats)
(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-configuration-layers
   '(emacs-lisp)))
EOF

cat > "$FIXTURES_DIR/spacemacs-vanilla/README.md" << 'EOF'
# Vanilla Spacemacs Fixture

Simulates:
- Spacemacs installed
- No spacemacs-rstats configuration

Expected health level: 3 (NEEDS_REINSTALL) or 1 (NEEDS_UPDATE)
EOF

# Create master README
cat > "$FIXTURES_DIR/README.md" << 'EOF'
# Test Fixtures

Mock environments for testing installation scripts without affecting the real system.

## Fixtures

1. **fresh/** - Fresh system (nothing installed)
2. **emacs-only/** - Emacs but no Spacemacs
3. **installed/** - Complete spacemacs-rstats installation
4. **conflicting/** - Multiple Emacs versions
5. **corrupted/** - Broken installation
6. **spacemacs-vanilla/** - Spacemacs without our config

## Usage

```bash
# Set HOME to fixture
export HOME="$PWD/tests/fixtures/fresh"

# Run health check
./scripts/health-check.sh

# Run pre-flight
./scripts/health-check.sh --pre-flight
```

## Testing

```bash
# Run fixture tests
./tests/test_with_fixtures.sh
```
EOF

echo ""
echo "✓ Test fixtures created in $FIXTURES_DIR"
echo ""
echo "Fixtures:"
echo "  1. fresh/              - Fresh system"
echo "  2. emacs-only/         - Emacs only"
echo "  3. installed/          - Complete installation"
echo "  4. conflicting/        - Multiple Emacs versions"
echo "  5. corrupted/          - Broken installation"
echo "  6. spacemacs-vanilla/  - Vanilla Spacemacs"
echo ""
