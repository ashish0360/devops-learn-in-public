# Git Installation & Initial Configuration

Before using Git in any real project, it must be:
1. Installed correctly
2. Configured with proper identity

Skipping this step leads to broken commits and audit issues later.

---

## Verify Git Installation

Check whether Git is installed:

```bash
git --version

If Git is installed, this command prints the version.
If not, install Git using your OS package manager.

Configure User Identity (Mandatory)

Git attaches author information to every commit.
This is not optional in professional environments.

Set Username
git config --global user.name "Ashish"

Set Email
git config --global user.email "ashish@email.com"

These values appear in:
Commit history
Code reviews
Audit logs
CI/CD metadata

Verify Configuration
git config --list

Look for:
user.name
user.email

Why This Matters in DevOps
Commits must be traceable to individuals
Production changes require accountability
Audits rely on commit metadata
Incorrect or missing identity:
Breaks compliance
Causes confusion in teams
Looks unprofessional

Key Takeaway
Git installation is easy.
Correct Git configuration is critical.
Always configure Git before starting any project.
