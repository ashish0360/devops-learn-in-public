#!/bin/bash
# systemctl is-active --quiet checks if a service is running.
# Useful for health checks and auto-restart scripts.

if systemctl is-active --quiet nginx; then
    echo "Nginx is running"
else
    echo "Nginx is DOWN — restarting..."
    sudo systemctl restart nginx
fi
