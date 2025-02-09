#!/bin/bash

# Create two files
touch file1.txt
touch file2.txt

# Use flock to acquire a lock on each file before writing
(flock 200; echo "Process 1 writing to file1" > file1.txt) & 
(flock 201; echo "Process 2 writing to file2" > file2.txt) &

# Wait for both processes to finish
wait

# Print the contents of both files
cat file1.txt
cat file2.txt

# Explanation:
# The `flock` command acquires an exclusive lock on a file descriptor.  The process ID 200 and 201 are used to ensure that each process locks a different file. 
# This prevents both processes from writing to the same file simultaneously, thereby eliminating the race condition.