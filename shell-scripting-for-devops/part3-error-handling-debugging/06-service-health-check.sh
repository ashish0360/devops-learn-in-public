#!/bin/bash
# Check Nginx service and restart if required.

if systemctl is-active --quiet nginx; then
   echo "Nginx OK"
else
   echo "Nginx DOWN — restarting..."
   sudo systemctl restart nginx
fi
