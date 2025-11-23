# Shell Scripting for DevOps — Part 1
Shell Basics, Shebang, Variables, Input & Essential Commands

By Ashish — Learn-in-Public DevOps Journey (Week 2)

---

## Overview

This part covers the foundational building blocks of shell scripting every DevOps engineer needs to know:

- Shebang (`#!/bin/bash`) and portable shebangs
- How to run scripts and permissions
- Variables (user & system)
- Reading interactive input with `read`
- Script arguments (`$0`, `$1`, ...)
- Pipes, filters and basic use of `awk`, `grep`, `wc`
- `set` options for debugging and safe scripting (`set -x`, `set -e`, `set -o pipefail`)

These basics are essential for automation, CI/CD pipelines, cloud init scripts, container entrypoints, and daily operational tasks.

---

## Why learn shell basics?

- Shell scripts automate repetitive admin tasks.
- They are lightweight, available on nearly every Linux host, and ideal for glue-code in pipelines.
- CI/CD runners, cloud-init, and Docker ENTRYPOINTs commonly run shell scripts.

---

## Key Concepts

### Shebang
Use a shebang to tell the kernel which interpreter to use:
```bash
#!/bin/bash
# or portable:
#!/usr/bin/env bash

