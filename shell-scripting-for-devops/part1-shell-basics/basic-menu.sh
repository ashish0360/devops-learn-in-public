#!/bin/bash
# A basic interactive menu using case statement.

echo "Menu:"
echo "1. Show date"
echo "2. Show hostname"
echo "3. Show disk usage"

read -p "Choose an option: " opt

# case matches user choice and runs the corresponding command
case $opt in
  1) date ;;       # date command prints system date/time
  2) hostname ;;   # hostname prints system's hostname
  3) df -h ;;      # df -h shows disk usage in human-readable format
  *) echo "Invalid option" ;;
esac
