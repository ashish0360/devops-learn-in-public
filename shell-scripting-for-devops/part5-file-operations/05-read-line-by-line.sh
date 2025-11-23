#!/bin/bash
# Reads a file line-by-line — useful for CSV, logs, manifests

while read line; do
    echo "Line: $line"
done < sample.txt
