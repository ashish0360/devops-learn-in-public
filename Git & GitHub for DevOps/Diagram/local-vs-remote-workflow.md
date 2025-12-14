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


---

# ✅ STEP 5: gitflow-workflow.md

```markdown
# Diagram: Gitflow Branching Strategy

## What This Diagram Shows
How professional teams manage releases safely.

## Branch Structure

- main/master → Production
- develop → Integration
- feature/* → New features
- release/* → Pre-production testing
- hotfix/* → Emergency fixes

## Visual Flow

feature → develop → release → master
↓
develop
hotfix → master
→ develop


## Why DevOps Teams Use Gitflow
- Stable production
- Parallel development
- Clean release history
- Safe emergency fixes
