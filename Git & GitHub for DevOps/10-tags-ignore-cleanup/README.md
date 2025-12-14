```markdown
# Tags, Ignore & Cleanup (Release Control and Hygiene)

This section covers **release marking** and **repository cleanliness**.

---

## Tags (Release Markers)

Tags mark exact points in history — usually production releases.

### Create Annotated Tag
```bash
git tag -a v1.0 -m "Production release"

## View Tag
git show v1.0

Tags are used for:
Rollbacks
Audit
CI/CD release triggers

## .gitignore (Prevent Tracking Files)
.gitignore tells Git which files should never be tracked.

Example:
*.log
node_modules/
.env

Used to ignore:
Logs
Dependencies
Secrets
Local config files

## Cleaning Untracked Files
Dry Run
git clean -n

## Delete Untracked Files
git clean -f
Be careful, this deletes files permanently.

Key Takeaway

Tags control releases.
.gitignore protects repositories.
Clean repos reduce deployment risk.
