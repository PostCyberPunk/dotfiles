function fzf_pcp_normal
    EXTERNAL_COLUMNS=$COLUMNS \
        fd $argv -c always . | fzf --reverse \
        --header="$PWD" --ansi \
        --preview='fzf_pcp_previewer {}' \
        --preview-window "right,60%,border-left"
end
