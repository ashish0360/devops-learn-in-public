# Git Repository Lifecycle (From Folder to Versioned Project)

Every Git-managed project starts the same way:
with a normal folder that is turned into a repository.

Understanding this lifecycle prevents confusion later.

---

## What is a Git Repository?

A Git repository is a directory that Git actively tracks.

When a folder becomes a repository:
- Git starts tracking file changes
- History becomes available
- Git commands become usable

---

## Initializing a Repository

### Command
```bash
git init

What This Does

Creates a hidden .git/ directory

Initializes Git metadata

Converts the folder into a Git repository

At this point:
No files are tracked yet
No commits exist

The .git/ Directory (Important)

The .git/ directory contains:
Commit history
Branch references
Configuration
HEAD pointer
This directory is Git.

❌ Deleting .git/ removes all history
✅ Keeping it preserves the entire project timeline

Checking Repository State
Command
git status

What It Shows
Untracked files
Modified files
Staged files
Current branch

This command answers:
“What is the current state of my repository?”
DevOps engineers run git status constantly.

Typical Repository Lifecycle
Create folder
     ↓
git init
     ↓
Add files
     ↓
Stage changes
     ↓
Commit history
     ↓
Connect to remote
     ↓
Push to GitHub

Why This Matters in DevOps
Infrastructure repositories start this way
Application repositories start this way
CI/CD pipelines assume this lifecycle
Misunderstanding repository initialization leads to:
Broken remotes
Confusing histories
Failed pipelines

Key Takeaway
A Git repository is not magic.
It is simply a folder with a .git/ directory.

Understand that, and Git becomes predictable.
