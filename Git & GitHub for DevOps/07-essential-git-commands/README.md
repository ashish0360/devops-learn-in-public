# Essential Git Commands (Commands You Use Every Day)

This section covers the **core Git commands** that form 80–90% of real-world Git usage.

Master these and Git becomes predictable and safe.

---

## Creating Files

```bash
touch file.txt

Creates a new file in the working directory.

Checking Repository Status
git status


Shows:
Untracked files
Modified files
Staged files
Current branch

This is the most-used Git command.

## Staging Changes
Stage a Specific File
git add file.txt

Stages only the specified file.

Stage All Changes
git add .


Stages all modified and new files.

Staging is a deliberate action, not automatic.

Committing Changes
git commit -m "Initial commit"


Creates a snapshot of staged changes.
# Good Commit Messages:
Short
Descriptive
Explain why, not just what
# Bad commits cause:
Debugging pain
Confusing history
Risky rollbacks

Viewing Commit History
# Full History
git log

# Compact View
git log --oneline


Shows:
Commit hashes
Commit messages
Commit order

# Viewing a Specific Commit
git show <commit-id>

Displays:
Changes introduced by the commit
Files affected
Author information
Used heavily during debugging and incident analysis.

DevOps Usage Context
These commands are used when:
Preparing deployments
Investigating failures
Reviewing infrastructure changes
Auditing production incidents

Key Takeaway
If you only remember one workflow, remember this:
Edit → Status → Add → Commit → Push


Everything else builds on these commands.
