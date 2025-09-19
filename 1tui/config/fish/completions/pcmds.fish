function _pcmds_commands
    pcmds -h
end

function _pcmds_subcommands
    pcmds -hs $argv[2]
end

function _pcmds_list_themes
    pcmds theme list_themes
end

complete -f pcmds -n __fish_use_subcommand -a '(_pcmds_commands)'

complete -f pcmds -n '__fish_seen_subcommand_from (_pcmds_commands)' -a '(_pcmds_subcommands (commandline -opc))'

# complete -f pcmds -n '__fish_seen_argument set' -a '(_pcmds_list_themes)'
