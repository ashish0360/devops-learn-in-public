#!/bin/bash
# Example combining numeric and string comparisons
# Demonstrates reading input and branching logic

read -p "Enter age: " age
read -p "Are you Indian? (yes/no): " nation

# -ge numeric compare
if [[ $age -ge 18 ]]; then
  echo "You can vote (age $age)"
elif [[ "$nation" == "yes" ]]; then
  echo "You are Indian — you can vote (special rule)"
else
  echo "You cannot vote yet"
fi
