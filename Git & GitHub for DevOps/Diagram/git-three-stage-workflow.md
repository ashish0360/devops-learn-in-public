# Diagram: Git Three-Stage Workflow

## What This Diagram Shows
How files move inside Git before becoming permanent history.

## Stages

### Working Directory
- You write and edit code here
- Changes are not yet saved in Git

### Staging Area
- You select what should be committed
- Acts as a control gate

### Repository
- Permanent history storage
- Each commit has a unique hash

## Visual Flow

Working Directory
↓ git add
Staging Area
↓ git commit
Repository


## Why This Matters in DevOps
- Prevents accidental commits
- Enables clean, controlled deployments
- Explains 90% of Git confusion

