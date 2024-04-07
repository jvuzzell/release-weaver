#!/bin/bash

source "$UTILITIES_DIR/extract_json_string_attr.sh"
source "$UTILITIES_DIR/extract_json_array.sh"

# Use the path from the environment variable, or default to a known location
CONFIG_FILE="${ENV_CONFIG_PATH:-/default/path/to/env_config.json}"

# Check if the JSON configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file not found: $CONFIG_FILE"
    exit 1
fi

# Load and export the environment variables from the JSON file
export PROJECT_TITLE=$(extract_json_string_attr "PROJECT_TITLE" "$CONFIG_FILE")
export TARGET_REPOSITORY=$(extract_json_string_attr "TARGET_REPOSITORY" "$CONFIG_FILE")
export TARGET_REMOTE_NAME=$(extract_json_string_attr "TARGET_REMOTE_NAME" "$CONFIG_FILE")
export DEFAULT_BRANCH=$(extract_json_string_attr "DEFAULT_BRANCH" "$CONFIG_FILE")
export JIRA_BOARD_ID=$(extract_json_string_attr "JIRA_BOARD_ID" "$CONFIG_FILE")
export ALLOWED_BRANCH_TYPES=$(extract_json_array "ALLOWED_BRANCH_TYPES" "$CONFIG_FILE")