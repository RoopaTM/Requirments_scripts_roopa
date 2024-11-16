#!/bin/bash

echo "Enter 1 to create a folder and a file, or 0 to delete the folder:"
read input_value

# Define the location where the folder should be created or deleted
TARGET_DIR="/home/roopa/Task"  

# Check the input value and perform actions accordingly
if [ "$input_value" -eq 1 ]; then
    
    echo "Creating folder and file at $TARGET_DIR"
    
    mkdir -p "$TARGET_DIR"
    
    # Create a file inside the directory
    echo "This is a test file." > "$TARGET_DIR/testfile.txt"
    
    echo "Folder and file created successfully."
    
elif [ "$input_value" -eq 0 ]; then
    # Delete folder(s) if input is 0
    echo "Deleting folder(s) at $TARGET_DIR"
    
    # Check if the directory exists
    if [ -d "$TARGET_DIR" ]; then
        # Remove the directory and all its contents
        rm -rf "$TARGET_DIR"
        echo "Folder deleted successfully."
    else
        echo "No folder found at $TARGET_DIR to delete."
    fi
else
    echo "Invalid input! Please enter either 0 or 1."
fi

