#!/bin/bash
# Delete logs older than 7 days

find /var/log -type f -mtime +7 -delete
echo "Old logs cleaned"
