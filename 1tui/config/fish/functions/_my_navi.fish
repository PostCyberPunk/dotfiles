function _my_navi
    set -l current_process (commandline -p | string trim)
    if test -z "$current_process"
        commandline -i (navi --path '~/.config/navi/cheats' --print)
    end

    commandline -f repaint
end
