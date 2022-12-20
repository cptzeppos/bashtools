#!/bin/bash

# Check if a directory was specified
if [ $# -eq 0 ]
then
  echo "Error: No directory specified."
  exit 1
fi

# Set the directory to search
dir=$1

# Find all duplicate files in the specified directory
duplicates=$(find "$dir" -type f -printf "%T@ %p\n" | sort -n | uniq -D -w30 | cut -f2- -d" ")

# Iterate over the list of duplicate files
for file in $duplicates
do
  # Get the oldest file among the duplicates
  oldest=$(ls -t "$file" | tail -1)

  # Remove all duplicate files except for the oldest one
  for duplicate in "$file"*
  do
    if [ "$duplicate" != "$file$oldest" ]
    then
      rm "$duplicate"
    fi
  done
done
