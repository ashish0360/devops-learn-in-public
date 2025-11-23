#!/bin/bash
# Auto-restart failing service

service="docker"

if ! systemctl is-active --quiet "$service"; then
    echo "$(date): $service DOWN — restarting"
    systemctl restart "$service"
fi
