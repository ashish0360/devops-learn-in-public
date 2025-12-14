# Version Control Basics (DevOps Foundation)

This section builds the **foundation of everything that follows**.
If you don’t understand version control deeply, Git commands will feel random and unsafe.

---

## What is Version Control?

### Definition
Version control is a system that tracks changes in files over time so you can:
- See who changed what and when
- Collaborate with multiple people safely
- Roll back to a previous working state when something breaks

In simple words:
> Version control = time machine + collaboration system for code.

---

## Why Version Control is Critical for DevOps

In DevOps, version control is **not optional**. It is the backbone of automation.

### 1. Infrastructure Must Be Traceable
- Terraform, CloudFormation, Kubernetes YAML — all are code
- Every change must be tracked, reviewed, and auditable
- Git provides a complete history of infrastructure changes

---

### 2. CI/CD Pipelines Depend on Git
- Pipelines are triggered by Git events:
  - `push`
  - `pull request`
  - `merge`
  - `tag`
- Without Git, CI/CD cannot exist

---

### 3. Rollbacks Must Be Fast and Safe
- Production breaks happen
- Git allows you to:
  - Revert commits
  - Roll back releases
  - Restore known-good states quickly

In DevOps, **rollback speed = downtime reduction**.

---

### 4. Teams Work in Parallel
- Multiple engineers work on the same codebase
- Version control prevents overwriting each other’s work
- Branching enables safe parallel development

Without version control:
- Manual copying
- Broken deployments
- No accountability

---

## DevOps Reality Check

If your infrastructure or application code is **not in Git**:
- It is not auditable
- It is not reproducible
- It is not production-ready

That’s why Git is considered the **single source of truth** in DevOps.

---

## Key Takeaway

Version control is not a Git feature.  
Git is a tool that **implements version control correctly at scale**.

Everything else in this repository builds on this idea.
