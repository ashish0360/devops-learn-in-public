#!/bin/bash
# Demonstrates functions returning status codes for safety.

create_dir() {
   mkdir "$1"
}

if ! create_dir "newfolder"; then
   echo "Failed to create folder — exiting."
   exit 1
fi

echo "Folder created successfully"
