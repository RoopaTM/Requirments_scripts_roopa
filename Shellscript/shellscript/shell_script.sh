#!/bin/bash

#1st Requirement is to create a shell script


: '
Step 1: Take input as either 0 or 1
This part prompts the user to enter a value (either 0 or 1), which is read into the variable "input".
'
echo "Enter 1 to create folder and file, 0 to delete folder:"
read input

: '
Step 2: Conditional check based on input value (0 or 1)
This conditional checks whether the input is 1 or 0, and then performs the respective action.
'

if [ "$input" -eq 1 ]; then
  : '
  If input is 1:
  Create a folder and a file inside it at a specific location
  mkdir -p creates the folder (if it doesn’t exist) and touch creates the file inside the folder.
  '
  mkdir -p /home/roopa/test_directory
  touch /home/roopa/testfile.txt
  echo "Folder and file created successfully."
  
elif [ "$input" -eq 0 ]; then
  : '
  If input is 0:
  Delete the folder(s) present at the specified location.
  rm -rf removes the folder and all its contents recursively.
  '
  rm -rf /path/to/specific/location/myfolder
  echo "Folder deleted successfully."

else
  : '
  Handle invalid input (not 0 or 1):
  This part handles any invalid input by informing the user.
  '
  echo "Invalid input. Please enter 0 or 1."
fi

