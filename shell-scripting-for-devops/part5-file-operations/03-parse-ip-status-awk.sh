#!/bin/bash
# Extract client IP and HTTP status code from access logs

awk '{print $1, $9}' access.log
