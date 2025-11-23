#!/bin/bash
# Deletes log files older than 7 days to prevent disk pressure.

find /var/log -type f -mtime +7 -delete
echo "Old logs cleaned successfully."
