#!/bin/bash
_mail=$(gum input --header "Email address for git")
_user=$(gum input --header "User name for git")
cat <<EOL >~/.config/git/local.test
[user]
email = $_mail
name = $_user
[credential "https://github.com"]
helper =
helper = !/run/current-system/sw/bin/gh auth git-credential
[credential "https://gist.github.com"]
helper =
helper = !/run/current-system/sw/bin/gh auth git-credential
[url "https://www.github.com/$_user/"]
insteadOf = "ghp:"
[url "git@github.com:$_user/"]
insteadOf = "ghsp:"
EOL
