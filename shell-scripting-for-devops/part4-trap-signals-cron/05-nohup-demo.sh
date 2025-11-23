#!/bin/bash
# Demonstrate nohup to keep process alive after logout

nohup bash -c "while true; do echo 'Running...'; sleep 2; done" &
echo "Process started with nohup. Output: nohup.out"
