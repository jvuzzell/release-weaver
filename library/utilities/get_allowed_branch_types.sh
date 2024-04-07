source "$UTILITIES_DIR/extract_json_array.sh"

export ALLOWED_BRANCH_TYPES=$(extract_json_array "ALLOWED_BRANCH_TYPES" "$ENV_CONFIG_PATH")