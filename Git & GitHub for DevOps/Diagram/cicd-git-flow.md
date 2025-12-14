# Diagram: Git in CI/CD Pipeline

## What This Diagram Shows
How Git events control CI/CD pipelines.

## Flow

Code Commit
↓
Git Push
↓
CI Pipeline (Build + Test)
↓
CD Pipeline (Deploy)
↓
Production



## Git Triggers Used
- Push → build pipeline
- Pull Request → validation checks
- Tag → production release

## Why This Matters
Git is not just storage.
Git is the **control switch** of DevOps automation.
