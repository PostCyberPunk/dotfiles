set fish_greeting
set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim
# alias
alias md="mkdir"
alias l="eza -lA --icons"
alias n="nvim"
alias b="bat"
alias lc="lfcd"
alias lg="lazygit"
alias slf="sudo -u buzz lf"
# keybinds
function fish_user_key_bindings
    bind \ce 'fish_commandline_prepend "sudo -E nvim"'
    bind \e\cv 'fish_commandline_prepend "proxychains"'
    bind \e\cm 'fish_commandline_append " -h|nvim"'
    bind \e\v 'fish_commandline_append " |wl-copy"'
    # bind \ex 'fish_commandline_prepend "pacman -S --needed"'
    bind \e\ci 'fish_commandline_prepend "sudo pacman -S --needed"'
    bind \e\cy 'fish_commandline_prepend "yay -S --needed"'
    bind -M insert \cp up-or-search
    bind -M insert \cn down-or-search
    bind -M insert \cf forward-char
    bind -M insert \ef forward-word
    bind -M insert \cr history-pager
    # bind -M defualt \e\[1\;3Q fish_vi_key_bindings
    # bind -M command \e\[1\;3Q fish_default_key_bindings
    for mode in default insert command
        bind -M $mode \en nvim
        bind -M $mode \co lfcd .
        bind -M $mode \cH backward-kill-word
    end
end
if status is-interactive
    # Commands to run in interactive sessions can go here
end
fish_add_path /home/buzz/.spicetify
