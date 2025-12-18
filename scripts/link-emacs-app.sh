#!/bin/bash
# Link emacs-plus@30 to /Applications
# Created: 2025-12-10

set -e

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  Link Emacs.app to /Applications                              ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Find emacs-plus@30 installation
CELLAR_PATH="/opt/homebrew/Cellar/emacs-plus@30"

echo "Step 1: Checking for emacs-plus@30 installation..."
if [ ! -d "$CELLAR_PATH" ]; then
    echo -e "${RED}❌ ERROR: emacs-plus@30 not found at $CELLAR_PATH${NC}"
    echo "Please install emacs-plus@30 first:"
    echo "  brew install emacs-plus@30 --without-native-compilation"
    exit 1
fi

# Find version directory
VERSION_DIR=$(ls -1 "$CELLAR_PATH" | head -1)
if [ -z "$VERSION_DIR" ]; then
    echo -e "${RED}❌ ERROR: No version directory found in $CELLAR_PATH${NC}"
    exit 1
fi

EMACS_APP="$CELLAR_PATH/$VERSION_DIR/Emacs.app"
echo -e "${GREEN}✅ Found: $EMACS_APP${NC}"
echo ""

# Check if Emacs.app exists at source
echo "Step 2: Verifying Emacs.app bundle..."
if [ ! -d "$EMACS_APP" ]; then
    echo -e "${RED}❌ ERROR: Emacs.app not found at $EMACS_APP${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Emacs.app bundle verified${NC}"
echo ""

# Check if /Applications/Emacs.app already exists
echo "Step 3: Checking /Applications..."
if [ -e "/Applications/Emacs.app" ]; then
    echo -e "${YELLOW}⚠️  /Applications/Emacs.app already exists${NC}"
    echo ""
    echo "Existing app info:"
    /Applications/Emacs.app/Contents/MacOS/Emacs --version | head -1
    echo ""
    echo -n "Remove existing and create new link? (y/n): "
    read response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo "Removing existing /Applications/Emacs.app..."
        rm -rf "/Applications/Emacs.app"
        echo -e "${GREEN}✅ Removed${NC}"
    else
        echo "Keeping existing app. Exiting."
        exit 0
    fi
fi
echo ""

# Create alias using AppleScript (macOS way)
echo "Step 4: Creating application alias..."
osascript -e "tell application \"Finder\" to make alias file to posix file \"$EMACS_APP\" at posix file \"/Applications\" with properties {name:\"Emacs.app\"}"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Successfully linked Emacs.app to /Applications${NC}"
else
    echo -e "${RED}❌ Failed to create alias${NC}"
    echo ""
    echo "Alternative: Create symbolic link instead"
    echo "  ln -s \"$EMACS_APP\" /Applications/Emacs.app"
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " Verification"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Verify
if [ -e "/Applications/Emacs.app" ]; then
    echo -e "${GREEN}✅ /Applications/Emacs.app exists${NC}"
    echo ""
    echo "Emacs version:"
    /Applications/Emacs.app/Contents/MacOS/Emacs --version | head -1
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  ✅ SUCCESS! Emacs.app is ready to launch                ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "You can now:"
    echo "  1. Launch from Applications: open /Applications/Emacs.app"
    echo "  2. Add to Dock for easy access"
    echo "  3. Set as default editor (if desired)"
    echo ""
    echo "Next: Run the verification script"
    echo "  bash ~/projects/dev-tools/spacemacs-rstats/post-install-verification.sh"
    echo ""
else
    echo -e "${RED}❌ Verification failed${NC}"
    exit 1
fi
