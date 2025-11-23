#!/bin/bash
# Wait until service is active using until (inverse of while)
# Useful for waiting for cloud VMs or services to start.

echo "Waiting for myservice to become active..."
until systemctl is-active --quiet myservice; do
  echo "myservice not ready; sleeping 3s"
  sleep 3
done
echo "myservice is active"
