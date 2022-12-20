#!/bin/bash

# Check if a directory was provided as an argument
if [ $# -eq 0 ]
then
  # If no argument was provided, use the current directory
  dir="./"
else
  # Use the directory provided as an argument
  dir="$1"
fi

# Find all files in the specified directory
find "$dir" -type f | while read file
do
  # Check if there are any other files with the same content
  if [ $(find "$dir" -type f -exec cmp "$file" {} \; | wc -l) -gt 1 ]
  then
    # If there are, remove all but the oldest file
    oldest_file=$(find "$dir" -type f -exec cmp "$file" {} \; | awk -F: '{print $1}' | sort | head -n 1)
    find "$dir" -type f -exec cmp "$file" {} \; | awk -F: '{print $1}' | grep -v "$oldest_file" | xargs rm
  fi
done
