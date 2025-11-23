#!/bin/bash
# Replace environment value inside config file

sed -i 's/ENV=dev/ENV=prod/g' config.yaml
echo "Updated config.yaml"
