#!/bin/bash
# read -p allows prompting user for input on the same line.
# The value entered is stored inside the variable.

read -p "Enter your username: " user
echo "Welcome, $user!"
