read -p "(1)Use git-credential-oauth or (2)git-credential-manager" choice
read -p "User:" uname
read -p "email:" umail

git config --global user.name $uname
git config --global user.email $umail
git config --global init.defaultBranch main

if [[ choice = 2 ]]; then
	############gcm
	yay -S --needed git-credential-manager
	git-credential-manager configure
	git config --global credential.credentialStore cache
	git config --global credential.cacheOptions "--timeout 3600"
	# git config --global credential.helper git-credential-manager
	echo "use git-credential-manager"
else
	############gco
	yay -S --needed git-credential-oauth
	git-credential-oauth configure
	echo "use git-credential-oauth"
fi
