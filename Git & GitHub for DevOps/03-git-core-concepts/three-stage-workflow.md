# Git Three-Stage Workflow (The Mental Model That Fixes Git Confusion)

Most Git mistakes happen because people don’t understand **where their files are** at any moment.

This file explains the **three internal stages of Git**.
If you understand this, you understand Git.

---

## The Three Stages of Git

Git internally manages files in **three distinct areas**:

1. Working Directory  
2. Staging Area  
3. Repository  

Every Git command moves files **between these stages**.

---

## 1. Working Directory

### What It Is
The working directory is your **actual project folder** on your system.

This is where:
- You write code
- You edit files
- You delete or modify content

Git is aware of changes here, but **nothing is saved yet**.

### Example
```bash
vim app.py


At this point:
File is modified
Git knows it changed
History is untouched

2. Staging Area
What It Is

The staging area is a temporary holding area.

Think of it as:

A preview of the next commit
A control gate before history is written
Only files added to staging will be committed.

Example
git add app.py


Now Git understands:

“This file should be part of the next commit.”

You are explicitly choosing what becomes history.

3. Repository
What It Is

The repository is where Git stores permanent snapshots of your project.
Once changes are committed:
They become part of history
They get a unique commit hash
They can be referenced forever

Example
git commit -m "Add initial app logic"

This snapshot is now immutable.

How Files Move Between Stages
Working Directory
      ↓ git add
Staging Area
      ↓ git commit
Repository

Command Responsibility
git add → Working Directory → Staging Area
git commit → Staging Area → Repository

No command skips stages by default.
