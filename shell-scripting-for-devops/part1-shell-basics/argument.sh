#!/bin/bash
# $0 = script name
# $1 = first argument
# $2 = second argument
# $@ = all arguments

echo "Script Name: $0"
echo "Argument 1: $1"
echo "Argument 2: $2"
echo "All Args: $@"

# Example usage:
# ./deploy.sh prod v2
