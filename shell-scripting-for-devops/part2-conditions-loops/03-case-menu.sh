#!/bin/bash
# Simple interactive menu using case - great for CLI utilities

echo "Choose action:"
echo "1) Start service"
echo "2) Stop service"
echo "3) Status"
read -p "Option: " opt

case "$opt" in
  1) echo "Starting service..."; systemctl start myapp ;;
  2) echo "Stopping service..."; systemctl stop myapp ;;
  3) echo "Service status:"; systemctl status myapp ;;
  *) echo "Invalid option" ;;
esac
