# keybinds
if status is-login
    if test -e ~/.config/fish/extra_login.fish
        source ~/.config/fish/extra_login.fish
    end
end
function fish_user_key_bindings
    bind \e\cv 'fish_commandline_prepend "proxychains "'
    bind \e\[1\;3P 'fish_commandline_append " -h|nvim -RMn"'
    bind \e\v 'fish_commandline_append " |wl-copy"'
    bind \e\ci 'fish_commandline_prepend "sudo pacman -S --needed"'
    bind \e\cy 'fish_commandline_prepend "yay -S --needed"'
    bind -M insert \cp up-or-search
    bind -M insert \cn down-or-search
    bind -M insert \ef forward-word
    bind -M insert \cf forward-char
    for mode in default insert command
        bind -M $mode \ce 'fish_commandline_prepend "sudo -E nvim"'
        bind -M $mode \c_ accept-autosuggestion execute
        bind -M $mode \e/ 'fish_commandline_prepend "history delete -eC \"";fish_commandline_append "\""'
        bind -M $mode \en 'fish_commandline_append "| nvim"'
        bind -M $mode \co 'set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint'
        bind -M $mode \cH backward-kill-word
    end

    # navi
    bind -M insert \eg _navi_smart_replace
    bind -M insert \cg _my_navi
    # bind -M issert \cg 'navi;'
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
    ########### alias###########
    alias p="fish --private"
    alias md="mkdir"
    alias l="eza -lA --icons"
    alias n="nvim"
    alias b="bat"
    alias lc="lfcd"
    alias lg="lazygit"
    alias slf="sudo -u $USER lf"
    alias zj="zellij"
    ########### Prompt and Plugins ###########
    ########### Variables ###########
    set fish_greeting
    ###fish fzf
    set fzf_preview_file_cmd fzf_pcp_previewer
    set fish_fzf_default_opts --cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*"
    for temp_mode in fzf_directory_opts fzf_git_log_opts fzf_git_status_opts fzf_history_opts fzf_processes_opts fzf_variables_opts
        set $temp_mode $fish_fzf_default_opts
    end
    ########### Fix ###########
    abbr --add dotdot --regex '^\.\.+$' --function multicd
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
# set --global tide_character_icon 
set --global tide_character_icon 
############ path ###########
fish_add_path ~/.spicetify
fish_add_path ~/.cargo/bin
########### Variables ###########
set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim

########### Enviromental ###########
set -gx LS_COLORS "$(vivid generate catppuccin-mocha)"
set -gx MANPAGER "nvim -c 'Man!'"
set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#313244,label:#CDD6F4"
