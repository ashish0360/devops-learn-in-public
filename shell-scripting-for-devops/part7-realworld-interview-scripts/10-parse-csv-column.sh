#!/bin/bash
# Print a CSV column by index (1-based). Handles simple CSVs (no quoted commas).
# Usage: ./10-parse-csv-column.sh file.csv 3
set -euo pipefail

FILE="${1:-}"
COL="${2:-}"

if [[ -z "$FILE" || -z "$COL" ]]; then
  echo "Usage: $0 <file.csv> <column-number>"
  exit 2
fi

awk -F',' -v col="$COL" 'NR>1 {print $col}' "$FILE"
