#!/bin/bash
extract_json_array() {
    key=$1
    config_file=$2

    # Extract the line with the array, then use sed and awk to format it into a Bash array
    json_array=$(grep "\"$key\"" "$config_file" | sed -E 's/.*\[(.*)\].*/\1/') 

    # Convert space-separated values to bash array
    IFS=',' read -r -a array <<< "$json_array"

    # Remove quotation marks
    for i in "${!array[@]}"; do
        array[$i]=${array[$i]//\"/}
    done

    # Print modified array
    echo "${array[@]}"
}