#!/bin/bash

# Enable alias expansion
shopt -s expand_aliases
alias get_current_sprint="$UTILITIES_DIR/get_current_sprint.sh"

output=$(get_current_sprint)

# Capture the exit status of the previous command
exit_status=$?

# Check if the first script encountered an error
if [ $exit_status -ne 0 ]; then
    echo "Error: Unable to get the current sprint."
    exit 1
fi

# Now you can use the $output variable as needed
echo "Current Sprint: $output"
echo ""