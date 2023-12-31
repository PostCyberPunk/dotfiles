function fzf_pcp_normal
    echo $argv|read -d // apath farg fzarg
    EXTERNAL_COLUMNS=$COLUMNS \
        fd $farg -calways . | fzf --reverse\
        --header="$farg fzarg" $fzarg --ansi \
        --preview='fzf_pcp_previewer {}' \
        --preview-window "right,60%,border-left"
end
# |choose 1&&kitten icat --clear --stdin=no
# bat --color=always {} && kitten icat --clear --stdin=no
# kitten icat --clear --stdin=no && kitten icat --clear --stdin=no
