# Branching Strategies (How Teams Avoid Breaking Production)

Branching is not a Git feature for convenience.
It is a **risk-management system** used by DevOps teams.

If everyone works on the same branch, production will break — guaranteed.

---

## Why Branching Exists

Branching allows teams to:
- Develop features independently
- Fix bugs without affecting production
- Experiment safely
- Work in parallel

Without branches:
- Code overwrites happen
- Rollbacks become chaotic
- CI/CD pipelines become unstable

---

## The Production Branch Rule

In professional environments:

❌ Developers do not work directly on `main` / `master`  
✅ Production branches are **protected**

Why?
- Every commit here can trigger deployments
- Mistakes here impact real users

---

## Common Branch Types

### Production Branch
- `main` or `master`
- Always deployable
- Often protected with rules

### Development / Integration Branch
- `develop`
- Where completed work is integrated
- Represents the next release

### Feature Branches
- `feature/login`
- `feature/api`
- Used for new development

### Release Branches
- `release/1.0`
- Final testing before production

### Hotfix Branches
- `hotfix/urgent-bug`
- Emergency fixes for production issues

---

## Why DevOps Engineers Care About Branching

Branching directly affects:
- Deployment safety
- CI/CD pipeline behavior
- Rollback strategies
- Incident recovery

A bad branching strategy creates:
- Merge hell
- Broken releases
- On-call nightmares

---

## Key Takeaway

Branches are not optional.
They are **guardrails for production systems**.

The next file explains **Gitflow**, a structured branching model used by many teams.
