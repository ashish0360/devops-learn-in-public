#!/bin/bash
# Catch SIGINT (Ctrl+C) and handle it gracefully.

trap "echo 'Ctrl+C detected — stopping safely'; exit" SIGINT

while true; do
    echo "Running..."
    sleep 1
done
