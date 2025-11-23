#!/bin/bash
# Demonstrates function returning status and using it for control flow

check_file() {
  local f="$1"
  if [[ -f "$f" ]]; then
    return 0
  else
    return 2  # non-zero means failure
  fi
}

file="/etc/hosts"
if check_file "$file"; then
  echo "$file exists"
else
  echo "$file missing (status $?)"
fi
