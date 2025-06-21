_mail=$(gum input --header "Email address for git")
_user=$(gum input --header "User name for git")
git config --global user.name "$_user"
git config --global user.email "$_mail"
