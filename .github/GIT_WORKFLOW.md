# Git Workflow

**IMPORTANT: Always work on `dev` branch for development.**

## Branch Strategy

- **`main`** - Protected production branch (stable releases only)
- **`dev`** - Active development branch (all work happens here)
- **`feature/*`** - Optional feature branches (merge to dev)

## Standard Workflow

### 1. Start New Work

```bash
# Always start from dev
git checkout dev
git pull origin dev

# Optional: Create feature branch
git checkout -b feature/my-feature
```

### 2. During Development

```bash
# Make changes
# Run tests
./tests/run_all_tests.sh

# Commit frequently
git add .
git commit -m "type: description"
```

### 3. Push to Dev

```bash
# If on feature branch, merge to dev first
git checkout dev
git merge feature/my-feature --no-ff

# Push dev
git push origin dev
```

### 4. Merge to Main (When Ready)

```bash
# Only when feature is complete and tested
git checkout main
git merge dev --no-ff
git push origin main

# Return to dev
git checkout dev
```

## Commit Message Format

Follow [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` New features
- `fix:` Bug fixes
- `docs:` Documentation only
- `test:` Adding/updating tests
- `chore:` Maintenance, dependencies
- `refactor:` Code restructuring

## Testing Before Merge

**Always run full test suite before merging to main:**

```bash
cd tests
./run_all_tests.sh
```

Expected: 59/59 tests passing

## Current Status

- `dev`: Active development (work here)
- `main`: Protected (merge only when ready)

---

**Remember: Never commit directly to main. Always work on dev.**
