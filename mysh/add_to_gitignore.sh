#!/bin/bash
ignore_file = "$(git rev-parse --show-toplevel)/.gitignore"
#" Check if the file is in a git repository
if git rev-parse --git-dir >/dev/null 2>&1; then
	# Check if .gitignore file exists
	if [ ! -f "$ignore_file" ]; then
		# Create .gitignore file
		touch $ignore_file
		echo "Created .gitignore file"
	fi

	# Add the file to the git ignore file
	echo "$(realpath $1)" >>$ignore_file
	echo "$1 added to .gitignore"
else
	echo "Not a git repository"
fi
