# Branching & Merging (Controlled Collaboration)

Branching and merging are how multiple engineers work on the same codebase
**without breaking each other’s work or production**.

This section focuses on **safe, DevOps-grade usage**.

---

## Listing Branches

```bash
git branch

Shows:

All local branches

The currently active branch

Knowing where you are before making changes is critical.

Creating a New Branch
git branch feature-login


Creates a new branch but does not switch to it.

Switching Branches
git checkout feature-login


Moves you to the specified branch and updates files in your working directory.

Create and Switch (Most Common)
git checkout -b feature-api


Creates a new branch and switches to it immediately.

This is the standard way DevOps engineers start new work.

Deleting Branches
Delete a Merged Branch
git branch -d feature-login


Deletes only if the branch is already merged.

Force Delete
git branch -D feature-login


Deletes the branch regardless of merge status.

Use force delete with caution.

Merging Branches
Basic Merge
git merge feature-login


Merges feature-login into the current branch.

Common Merge Types (Conceptual)

Fast-forward

No divergence

Linear history

No-fast-forward

Always creates a merge commit

Clear branch history

Squash

Combines multiple commits into one

Cleaner production history

DevOps teams choose merge strategy deliberately.

Handling Failed Merges
git merge --abort


Cancels a merge in progress and restores the previous state.

This is a safety escape hatch.

DevOps Reality

Merges are not casual actions.
They often:

Trigger CI/CD pipelines

Deploy to staging or production

Affect multiple teams

That’s why merges usually happen via:

Pull Requests

Code reviews

Automated checks

Key Takeaway

Branching isolates work.
Merging integrates work.

Done correctly, they keep systems stable.
Done poorly, they create outages.
