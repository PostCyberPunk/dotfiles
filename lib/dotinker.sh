#!/bin/bash

# Define usage function
usage() {
	echo "Usage: $0 [-n] [-t target_directory] directory"
	echo "Create symbolic links of every subdirectory in the specified directory to the target directory."
	echo "If the -n option is provided, only print messages and do not create symbolic links or backups."
	echo "If the -t option is provided, use the specified target directory instead of the default directory."
	exit 1
}
# Parse command line options
while getopts ":nt:" opt; do
	case ${opt} in
	n)
		dry_run=true
		echo "Dry run"
		;;
	t)
		if [[! -d $OPTARG ]]; then
			echo "target_dir not exsisted:$OPTARG"
			exit 1
		fi
		target_dir=$OPTARG
		;;
	\?)
		usage
		;;
	esac
done
shift $((OPTIND - 1))
source_directory="$(pwd)/$1"
# Check if Source directory exsisted
if [[ ! -d "$source_directory" ]]; then
	echo "Source not exsisted :$1"
	exit 1
fi
# Set default target directory
if [[ -z "$target_dir" ]]; then
	target_dir="$HOME/.config"
fi

# Check if the number of arguments is correct
if [[ $# -ne 1 ]]; then
	usage
fi

# Create backup directory
create_backup() {
	if [[ -z $need_backup ]]; then
		backup_dir="$(dirname "$target_dir")/dotinker_bakup.$(date +%Y%m%d%H%M%S)"
		if [[ -z "$dry_run" ]]; then
			mkdir "$backup_dir"
		fi
		need_backup=true
	fi
}
create_link() {
	echo "Creating link $target_dir/$(basename "$dir") -> $dir"
	if [[ -z "$dry_run" ]]; then
		ln -s "$1" "$target_dir/$(basename "$1")"
	fi
}

main() {
	echo "Linking $source_directory to $target_dir"
	# Create symbolic links of every subdirectory to the target directory
	find "$source_directory" -mindepth 1 -maxdepth 1 -type d | while read dir; do
		mtarget=$target_dir/$(basename "$dir")
		if [[ -L $mtarget ]]; then
			ltarget=$(readlink -f $mtarget)
			echo "Removing link $mtarget -> $ltarget"
			if [[ -z "$dry_run" ]]; then
				rm $mtarget
			fi
		elif [[ -d $mtarget ]]; then
			create_backup
			echo "Backing up $mtarget to $backup_dir/$(basename "$dir")"
			if [[ -z "$dry_run" ]]; then
				mv "$mtarget" "$backup_dir/$(basename "$dir")"
			fi
		fi
		create_link $dir
	done
}
main
