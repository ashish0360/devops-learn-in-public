#!/bin/bash
# Creates files based on names inside list.txt

for name in $(cat list.txt); do
    touch "$name.txt"
done
