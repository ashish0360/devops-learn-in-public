#!/bin/bash
# set -e : exit the script immediately if any command fails
# set -x : print each command before executing it (debug mode)
# set -o pipefail : fail if any command in a pipeline fails

set -exo pipefail

echo "Starting task..."
mkdir test-folder     # Creates a folder
ls -l test-folder     # Lists the folder with details
echo "Completed!"
