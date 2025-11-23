#!/bin/bash
# Demonstrates C-style for loop and basic arithmetic inside loop

for ((i=1; i<=5; i++)); do
  square=$(( i * i ))
  echo "i=$i, square=$square"
done
