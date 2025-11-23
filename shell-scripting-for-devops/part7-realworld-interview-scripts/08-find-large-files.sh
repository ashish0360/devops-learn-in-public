#!/bin/bash
# Find files larger than specified size (MB). Usage: ./08-find-large-files.sh 100
set -euo pipefail

SIZE_MB="${1:-100}"
find / -type f -size +"${SIZE_MB}"M -printf '%s\t%p\n' 2>/dev/null | sort -nr | head -n 30
