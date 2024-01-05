########### alias###########
alias md="mkdir"
alias l="eza -lA --icons"
alias n="nvim"
alias b="bat"
alias lc="lfcd"
alias lg="lazygit"
alias slf="sudo -u $USER lf"
alias t="zellij"
# keybinds
function fish_user_key_bindings
    bind \ce 'fish_commandline_prepend "sudo -E nvim"'
    bind \e\cv 'fish_commandline_prepend "proxychains "'
    bind \e\[1\;3P 'fish_commandline_append " -h|nvim -RMn"'
    bind \e\v 'fish_commandline_append " |wl-copy"'
    # bind \ex 'fish_commandline_prepend "pacman -S --needed"'
    bind \e\ci 'fish_commandline_prepend "sudo pacman -S --needed"'
    bind \e\cy 'fish_commandline_prepend "yay -S --needed"'
    bind -M insert \cp up-or-search
    bind -M insert \cn down-or-search
    bind -M insert \ef forward-word
    bind -M insert \cf forward-char
    # bind -M insert \cr history-pager
    # bind -M defualt \e\[1\;3Q fish_vi_key_bindings
    # bind -M command \e\[1\;3Q fish_default_key_bindings
    for mode in default insert command
        bind -M $mode \c_ accept-autosuggestion execute
        bind -M $mode \e/ 'fish_commandline_prepend "history delete -eC \"";fish_commandline_append "\""'
        # bind -M $mode \e\cq exit
        bind -M $mode \en 'fish_commandline_append "| nvim"'
        bind -M $mode \co lf .
        bind -M $mode \cH backward-kill-word
    end
end
if status is-interactive
    fish_vi_key_bindings
    set -g fish_cursor_insert line
    set -g fish_cursor_default block
    set -g fish_cursor_replace underscore
    # set -g fish_vi_force_cursor
    # Commands to run in interactive sessions can go here
    # if string match -q -- 'tmux*' $TERM
    #     set -g fish_vi_force_cursor 1
    # end
end
########### Prompt and Plugins ########### 
# set pure_enable_single_line_prompt true
# set pure_shorten_prompt_current_directory_length 1
# set --global tide_prompt_min_cols 300
set --global tide_prompt_transient_enabled true
# set --global tide_character_vi_icon_default 
# set --global tide_character_vi_icon_default 
# set --global tide_character_vi_icon_default 
# set --global tide_character_vi_icon_default 󰻃
# set --global tide_character_vi_icon_default 
set --global tide_character_vi_icon_default 
# set --global tide_character_vi_icon_default 󰁎
set --global tide_character_icon 
############ path ###########
fish_add_path home/buzz/.spicetify
########### Variables ###########
set fish_greeting
set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim

###fish fzf
set fzf_preview_file_cmd fzf_pcp_previewer
set fish_fzf_default_opts --cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*"
for temp_mode in fzf_directory_opts fzf_git_log_opts fzf_git_status_opts fzf_history_opts fzf_processes_opts fzf_variables_opts
    set $temp_mode $fish_fzf_default_opts
end
########### Enviromental ###########
export LS_COLORS="$(vivid generate catppuccin-mocha)"
export FZF_DEFAULT_OPTS='--bind "ctrl-y:execute-silent(echo -n $(pwd)/{} | wl-copy)+abort"'
########### Fix ###########
abbr --add dotdot --regex '^\.\.+$' --function multicd
