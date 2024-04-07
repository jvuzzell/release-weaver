#!/bin/bash 
current_sprint_file="$RELEASE_DIR/current_sprint.txt"

if [ ! -f "$current_sprint_file" ]; then
    echo "Error: current_sprint.txt does not exist."
    exit 1
fi

cat "$current_sprint_file"  # Print the content of the file
