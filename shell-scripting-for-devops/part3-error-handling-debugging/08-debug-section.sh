#!/bin/bash
# Partial debugging using set +x / -x

echo "Non-debug section"
set -x       # start debug
ls -l
pwd
set +x       # stop debug
echo "Continuing normal execution"
