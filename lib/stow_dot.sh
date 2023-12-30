get_path() {
	path="$(pwd)/$1"
}
restore_to_dot() {
	get_path $1
	mv $path/.config $path/dot-config && echo "Restored"
}
apply_to_dot() {
	get_path $1
	mv $path/dot-config $path/.config && echo "Applied"
}

if [[ -z $1 ]]; then
	echo "Need argument!"
	exit
elif [[ -n $1 ]]; then
	echo "Stow Dot:$1"
fi

read -p "(A)pply(.) or (R)estore(dot-)" choice
if [[ $choice = [aA] ]]; then
	apply_to_dot $1
elif [[ "$choice" = [rR] ]]; then
	restore_to_dot $1
else
	echo "wrong choice exited"
fi
