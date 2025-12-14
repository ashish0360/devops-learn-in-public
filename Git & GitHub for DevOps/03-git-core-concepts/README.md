# Core Git Concepts (Foundation You Must Not Skip)

Before touching advanced commands or workflows, you must understand
the **core building blocks** of Git.

If these are unclear, Git will always feel confusing and dangerous.

---

## Repository

### What It Is
A repository (repo) is a **project directory tracked by Git**.

It contains:
- Your project files
- A hidden `.git/` directory that stores history, metadata, and references

### Why It Matters in DevOps
- Application code lives in repositories
- Infrastructure code (Terraform, Kubernetes YAML) lives in repositories
- CI/CD pipelines always point to a repository

👉 No repository = no version control.

---

## Commit

### What It Is
A commit is a **snapshot of your project at a specific point in time**.

Each commit:
- Has a unique hash (ID)
- Represents a logical change
- Is immutable once created

### DevOps Reality
Commits are used to:
- Trigger pipelines
- Identify what change caused a failure
- Roll back production safely

Bad commits = painful debugging.

---

## Branch

### What It Is
A branch is an **independent line of development**.

Branches allow you to:
- Work on features without breaking production
- Experiment safely
- Fix bugs in isolation

### DevOps Rule
Never work directly on the production branch (`main` / `master`).

Branches exist to **protect stability**.

---

## Merge

### What It Is
A merge combines changes from one branch into another.

Most commonly:
- Feature branch → develop
- Develop → main (production)

### Why Merges Matter
Merges are the moment where:
- Code meets production
- Conflicts appear
- Quality gates are enforced

In DevOps, merges are **controlled events**, not casual actions.

---

## How These Concepts Fit Together

- Repository → container for everything
- Commit → unit of change
- Branch → parallel work
- Merge → controlled integration

Every Git command you learn later operates on **one or more of these concepts**.

---

## What Comes Next

In the next files, we’ll explain:
- How files move inside Git (three-stage workflow)
- How local Git interacts with GitHub (local vs remote)

Do **not** skip them. They remove most Git confusion.
