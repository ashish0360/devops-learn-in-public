```markdown
# Git in CI/CD Pipelines (Automation Backbone)

Git is the **trigger mechanism** for CI/CD.

---

## How Git Triggers Pipelines

- Push → build pipeline
- Pull Request → validation checks
- Tag → production release

---

## Typical Flow
Commit → Push → CI → CD → Production


---

## GitOps Concept

Git becomes the **source of truth**:
- Desired state lives in Git
- Tools sync systems to Git state

---

## DevOps Reality

If it’s not in Git:
- It’s not automated
- It’s not reproducible
- It’s not reliable

---

## Key Takeaway

Git controls automation.
CI/CD reacts to Git.
