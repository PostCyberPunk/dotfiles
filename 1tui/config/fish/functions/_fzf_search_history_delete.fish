function _fzf_search_history_delete --description "Delete selected when serach history"
    set -f commands_selected (string replace --regex $time_prefix_regex '' $argv|string collect)
    builtin history delete -eC $commands_selected
end
