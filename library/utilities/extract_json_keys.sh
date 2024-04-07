 #!/bin/bash
extract_json_keys() {
    json_file=$1 
    
    # Using awk to extract JSON keys
    awk -F'"' '/":/{print $2}' "$json_file"
}