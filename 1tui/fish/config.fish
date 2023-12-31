set fish_greeting
set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim
########### alias###########
alias md="mkdir"
alias l="eza -lA --icons"
alias n="nvim"
alias b="bat"
alias lc="lfcd"
alias lg="lazygit"
alias slf="sudo -u $USER lf"
alias t="tmux"
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
        bind -M $mode \en 'fish_commandline_prepend | nvim'
        bind -M $mode \co lfcd .
        bind -M $mode \cH backward-kill-word
    end
end
if status is-interactive
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
set --global tide_character_vi_icon_default 
set --global tide_character_icon 
set fzf_preview_file_cmd fzf_pcp_previewer
############ path ###########
fish_add_path home/buzz/.spicetify
########### Variables ###########
# set LS_COLORS "$(vivid generate catppuccin-mocha)"
########### Enviromental ###########
export LS_COLORS="$(vivid generate catppuccin-mocha)"
########### Fix ###########
fish_vi_key_bindings
set -g fish_cursor_insert line
set -g fish_cursor_default block
set -g fish_cursor_replace underscore
