#!/bin/bash
# Demonstrate running background jobs

echo "Starting background task..."
sleep 10 &
echo "Background PID: $!"

wait
echo "Task finished"
