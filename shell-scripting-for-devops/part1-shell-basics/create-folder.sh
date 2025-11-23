#!/bin/bash

# read = ask user for folder name
read -p "Enter folder name: " folder

# [[ -d "name" ]] checks if the directory exists
if [[ -d "$folder" ]]; then
    echo "Folder already exists."
else
    mkdir "$folder"  # creates the folder
    echo "Folder '$folder' created successfully."
fi
