#!/bin/bash
# This script creates a backup copy of a system file.

src="/etc/hosts"           # source file
backup="/tmp/hosts.backup" # backup location

cp $src $backup            # copy command
echo "Backup created at: $backup"
