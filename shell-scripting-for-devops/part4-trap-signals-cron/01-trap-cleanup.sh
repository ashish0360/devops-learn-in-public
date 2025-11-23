#!/bin/bash
# Uses trap to ALWAYS run cleanup (even on Ctrl+C)

tmp="/tmp/myapp.tmp"
trap "echo 'Cleaning...'; rm -f $tmp" EXIT

touch $tmp
echo "Temp file created at $tmp"

sleep 5
echo "Done."
