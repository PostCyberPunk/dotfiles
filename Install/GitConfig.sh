read -p "(0)None (1)Use git-credential-oauth or (2)git-credential-manager" choice
read -p "Initialize gitconfig?(y/N)" use_preset
if [[ $use_preset = [Yy] ]]; then
	read -p "User:" uname
	read -p "email:" umail

	if [[ ! -z $uname ]]; then
		git config --global user.name $uname
	fi
	if [[ ! -z $jmail ]]; then
		git config --global user.email $umail
	fi
	git config --global init.defaultBranch main
	git config --global pull.rebase true
	git config --global core.editor "nvim"
fi

if [[ choice -eq 2 ]]; then
	############gcm
	yay -S --noconfirm --needed git-credential-manager-core-bin
	git config --global --unset-all credential.helper
	git-credential-manager configure
	git config --global credential.credentialStore cache
	git config --global credential.cacheOptions "--timeout 36000"
	# git config --global credential.helper git-credential-manager
	echo "use git-credential-manager"
elif [[ choice -eq 1 ]]; then
	############gco
	yay -S --noconfirm --needed git-credential-oauth
	git-credential-oauth configure
	echo "use git-credential-oauth"
else
	echo "No Choice for git credential helper Exited"
fi
