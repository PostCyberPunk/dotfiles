function _pcmds_commands
    pcmds -h
end

function _pcmds_subcommands
    pcmds -hs $argv[2]
end

complete -f pcmds -n __fish_use_subcommand -a '(_pcmds_commands)'

complete -f pcmds -n '__fish_seen_subcommand_from (_pcmds_commands)' -a '(_pcmds_subcommands (commandline -opc))'
