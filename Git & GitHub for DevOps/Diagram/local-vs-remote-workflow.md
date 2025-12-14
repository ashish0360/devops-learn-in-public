# Diagram: Local vs Remote Git Workflow

## What This Diagram Shows
How code moves between a developer’s system and GitHub.

## Local Side
- Working Directory
- Staging Area
- Local Repository

```bash
git add .
git commit -m "Feature completed"

Remote Side
GitHub / GitLab / Bitbucket
git push origin main
git pull origin main

Visual Flow
Edit → Add → Commit → Push → CI/CD
 ← Pull

**## DevOps Context**
Push triggers pipelines
Pull syncs team changes
Remote repo is the single source of truth
