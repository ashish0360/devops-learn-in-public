#!/bin/bash
# Fixes permission denied issues

sudo chown -R $USER:$USER /project
chmod +x /scripts/run.sh

echo "Permissions updated."
