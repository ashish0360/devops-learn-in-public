#!/bin/bash
# Make backup of config file safely

set -euo pipefail

src="/etc/hosts"
backup="/tmp/hosts.backup"

cp "$src" "$backup"
echo "Backup stored at $backup"
