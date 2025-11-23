#!/bin/bash
# Finds files larger than 100MB — used during disk pressure incidents

find / -type f -size +100M 2>/dev/null
