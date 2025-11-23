#!/bin/bash
# Print Fibonacci series up to N (provided as argument)
# Usage: ./10-interview-fibonacci.sh 10

n="${1:-10}"  # default to 10 if not provided

a=0
b=1
echo "Fibonacci up to $n terms:"
for ((i=0;i<n;i++)); do
  echo "$a"
  fn=$((a + b))
  a=$b
  b=$fn
done
