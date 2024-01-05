#!/bin/bash

start_time="$(date +%s%3N)"
total_folders="$(find $1 -mindepth 1 -type d | wc -l)"
top_folders="$(du -h | sort -rh | head -n 5)"
total_files="$(find $1 -type f | wc -l)"
total_conf="$(find -type f -name "*.conf" | wc -l)"
total_text="$(find $1 -type f -exec file {} \; | grep -c "text")"
total_exec="$(find $1 -type f -exec file {} \; | grep -c "executable")"
total_archive="$(find $1 -type f -exec file {} \; | grep -c "archive")"
total_log="$(find $1 -type f -name "*.log" | wc -l)"
total_links="$(find $1 -type l | wc -l)"
top_files="$(du -hs * | sort -rh | head -n 10)"

echo "Total number of folders (including all nested ones) = $total_folders"
echo "TOP 5 folders  of maximum size arranged in descending order (path and size):"
echo "$top_folders" | awk '{printf "%d - %s, %s\n", NR, $2, $1}'
echo "Total number of files = $total_files"
echo "Configuration files (with the .conf extension) = $total_conf"
echo "Text files = $total_text"
echo "Executable files = $total_exec"
echo "Log files (with the .log extension) = $total_log"
echo "Archive files = $total_archive"
echo "Symbolic links = $total_links"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"

echo "TOP 10 executable files of maximum size arranged in descending order (path, size and MD5 hash of file):"
echo "$top_files"  | awk '{printf "%d - %s, %s, %s\n", NR, $2, $1, $NF}'

end_time="$(date +%s%3N)"
runtime=$(((end_time - start_time)))
runtime_sec=$(bc <<< "scale=3; $runtime/1000")
echo "Script execution time (in seconds) = $runtime_sec"