#!/bin/bash
# Command substitution executes a command and stores output in a variable.
# Syntax: VAR=$(command)

DATE=$(date)          # Fetches system date and time
UPTIME=$(uptime -p)   # Shows how long the system has been running

echo "Current date: $DATE"
echo "Uptime: $UPTIME"
