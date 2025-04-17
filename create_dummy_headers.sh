#!/bin/bash

# Check if MODULE.bazel exists in the current directory
if [ ! -f "MODULE.bazel" ]; then
    echo "Error: MODULE.bazel file not found. Please run this script from the project root."
    exit 1
fi

# Create the absl_headers directory if it doesn't exist
mkdir -p absl_headers

# Run the grep command to extract include statements and process them
grep -r -I "^#include.*abseil-cpp" --include="*" open_spiel --no-filename | 
    sed "s/^#include \"\(.*\)\".*/#include \"\1\"/" | 
    sort | 
    uniq | 
    while read -r include_statement; do
        # Extract the file path from the include statement
        file_path=$(echo "$include_statement" | sed 's/#include "\(.*\)"/\1/')
        
        # Remove "open_spiel/abseil-cpp/" from the file path
        clean_path=$(echo "$file_path" | sed 's|open_spiel/abseil-cpp/||')
        
        # Create the directory structure if needed
        dir_path="absl_headers/$(dirname "$file_path")"
        mkdir -p "$dir_path"
        
        # Create the header file with the modified include statement
        modified_statement="#include \"$clean_path\""
        echo "$modified_statement" > "absl_headers/$file_path"
    done
