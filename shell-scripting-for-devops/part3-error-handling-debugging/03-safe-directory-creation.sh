#!/bin/bash
# Safe directory creation with proper handling.

set -euo pipefail

dir="demo"

if [[ -d "$dir" ]]; then
  echo "Directory exists"
else
  mkdir "$dir"
  echo "Created directory: $dir"
fi
