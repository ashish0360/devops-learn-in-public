#!/bin/bash
# Extract all ERROR entries from logs and save into errors.txt

grep -i "error" app.log > errors.txt
echo "Extracted errors to errors.txt"
