#!/bin/bash
# This script creates a project directory structure.
# Very useful for DevOps project bootstrapping.

read -p "Enter project name: " project
read -p "Enter environment (dev/stage/prod): " env

echo "Creating project directory structure..."

mkdir -p "$project/$env/logs"     # -p creates nested folders
touch "$project/$env/config.yaml" # new config file

echo "Project structure created:"
tree "$project"                   # prints folder tree structure (install via apt install tree)
