#!/bin/bash
# Demonstrating the meaning of each flag.

set -euo pipefail
# -e = exit on error
# -u = undefined variable error
# -o pipefail = pipeline must succeed

mkdir test_dir
ls test_dir
