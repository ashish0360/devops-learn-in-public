#!/bin/bash
# Demonstrates how exit codes work.

ls /not_there                # this will fail
echo "Exit code: $?"         # prints exit code of previous command

touch file.txt               # success
echo "Exit code: $?"         # prints 0
