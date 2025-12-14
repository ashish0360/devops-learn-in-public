```markdown
# GitHub Basics (Remote Repository Operations)

GitHub is where collaboration and automation happen.

This section covers **core remote operations**.

---

## Cloning a Repository
```bash
git clone <repo-url>

Downloads:
Full codebase
Complete commit history

## Connecting a Remote Repository
git remote add origin <repo-url>

Verify:
git remote -v

## Pushing Changes
git push origin main

Uploads commits to GitHub
Triggers CI/CD pipelines

## Pulling Changes
git pull origin main

Fetches latest changes
Merges into local branch

DevOps Context
Pipelines watch GitHub
Branch protection lives on GitHub
Reviews happen on GitHub

Key Takeaway
GitHub is the collaboration and automation layer on top of Git.
