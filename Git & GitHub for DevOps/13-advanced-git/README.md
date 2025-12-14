# Advanced Git (DevOps-Oriented Features)

These features are used **carefully**, not daily.

---

## Rebase

```bash
git rebase main

Rewrites commit history to create a clean, linear log.

Use with caution.
Never rebase public branches.


## Cherry-Pick
git cherry-pick <commit-id>

Applies a specific commit to another branch.

Used for:
Hotfixes
Selective backports

## Git Hooks
Scripts that run automatically on Git events:
pre-commit
post-merge

Used for:
Linting
Security checks
Formatting

## Git LFS
Handles large files efficiently.
Used for:
Media files
Large binaries

Key Takeaway
Advanced Git increases power — and risk.
Use intentionally.
