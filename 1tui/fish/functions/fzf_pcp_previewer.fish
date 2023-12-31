function fzf_pcp_previewer
    echo Preview:
    kitten icat --clear --stdin no --silent --transfer-mode file </dev/null >/dev/tty
    if file --mime-type $argv | grep -qF image/
        kitten icat --clear --transfer-mode=memory --place="$FZF_PREVIEW_COLUMNS"x"$FZF_PREVIEW_LINES"@$(math $COLUMNS+5)x1 --align center --stdin=no -z -1 $argv
    else if file --mime-type $argv | grep -qF text/
        bat --color=always $argv
    else if file --mime-type $argv | grep -qF /directory
        eza -lA --icons --color=always $argv
    else
        file --mime-type $argv
    end
end
