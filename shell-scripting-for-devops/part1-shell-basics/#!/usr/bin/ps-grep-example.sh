#!/usr/bin/env bash

# Show running processes related to a keyword

read -p "Enter process name: " process

echo "Searching for process: $process"

ps -ef | grep "$process" | grep -v grep
