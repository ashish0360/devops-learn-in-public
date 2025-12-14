# Stashing & Undoing Changes (Saving Work and Recovering Safely)

In real DevOps work, you often need to:
- Switch tasks suddenly
- Fix production issues
- Undo mistakes safely

This section covers **how to pause work and recover without panic**.

---

## Stashing Changes

Stashing temporarily saves uncommitted work.

```bash
git stash

Use when:
You need to switch branches quickly
Your work is incomplete
You don’t want to commit yet

## Viewing Stashes
git stash list
Shows all saved stashes.

## Restoring Stashed Work
git stash apply
Restores the latest stash but keeps it saved.

git stash pop
Restores and removes the stash.

## Undoing Changes (Local Only)
Soft Reset
git reset --soft <commit-id>
Moves HEAD
Keeps changes staged

## Mixed Reset (Default)
git reset --mixed <commit-id>
Unstages changes
Keeps files

## Hard Reset (Dangerous)
git reset --hard <commit-id>
Deletes changes permanently
Use hard reset only when absolutely sure.

## Reverting Commits (Safe for Teams)
git revert <commit-id>

Creates a new commit that undoes a previous commit.
Preferred in:
Shared repositories
Production environments

## Reflog (Lifesaver)
git reflog

Shows every movement of HEAD.
Used to:
Recover lost commits
Undo accidental resets

## Key Takeaway
Reset rewrites history.
Revert preserves history.

In DevOps, safety beats convenience.
