function _my_navi
    set -l current_prompt (commandline -cp)

    set -l output (navi --path '~/.config/navi/cheats' --print)

    if test -n "$output"
        # add a space if the prompt does not end with one (unless the prompt is an implicit cd, e.g. '\.')
        string match -q -r '.*( |./)$' -- "$current_prompt" || set output " $output"
        commandline -i "$output"
    end
    commandline -f repaint
end
