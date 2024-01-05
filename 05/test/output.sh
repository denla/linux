#!/bin/bash

total_folders="$(find $1 -mindepth 1 -type d | wc -l)"
top_folders="$(du -h | sort -rh | head -n 5)"

echo "Total number of folders (including all nested ones) = $total_folders"
echo "TOP 5 folders  of maximum size arranged in descending order (path and size):"
echo "$top_folders" | awk '{printf "%d - %s, %s, %s\n", NR, $2, $1, $NF}'