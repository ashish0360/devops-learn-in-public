#!/bin/bash
# Iterate over log files and print the number of ERROR lines per file

for file in /var/log/*.log; do
  # -f ensures the file exists (in case glob didn't match)
  if [[ -f "$file" ]]; then
    count=$(grep -i "error" "$file" | wc -l)  # count matching lines
    echo "$file : $count errors"
  fi
done
