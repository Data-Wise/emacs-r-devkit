#!/usr/bin/env bash
#
# Run all documentation tests
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "📚 Documentation Test Suite"
echo "============================"
echo ""

cd "$PROJECT_ROOT"

# Test 1: Python documentation tests
echo "Running Python tests..."
python3 tests/test_documentation.py

# Test 2: MkDocs build
echo ""
echo "Testing MkDocs build..."
mkdocs build --strict

# Test 3: Link checker (if available)
if command -v markdown-link-check &> /dev/null; then
    echo ""
    echo "Checking links..."
    find docs_mkdocs -name "*.md" -exec markdown-link-check {} \;
else
    echo ""
    echo "⚠ markdown-link-check not installed, skipping link check"
fi

echo ""
echo "✅ All documentation tests passed!"
