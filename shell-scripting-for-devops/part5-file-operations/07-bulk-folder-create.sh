#!/bin/bash
# Creates 10 folders automatically (useful in automation pipelines)

for i in {1..10}; do
    mkdir "folder$i"
done

echo "Created folder1 to folder10"
