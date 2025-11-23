#!/bin/bash
# Wait for service to START using until loop

echo "Waiting for nginx..."
until systemctl is-active --quiet nginx; do
  echo "Still starting..."
  sleep 2
done

echo "Nginx is active."
