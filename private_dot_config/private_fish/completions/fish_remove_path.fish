function __fish_remove_path_candidates
    set -l seen
    for p in $argv
        if test -n "$p"; and not contains -- $p $seen
            set -a seen $p
            echo $p
        end
    end
end

complete -c fish_remove_path -s h -l help -d 'Show help'
complete -c fish_remove_path -f -a '(__fish_remove_path_candidates $PATH)' -d 'Directory in $PATH'
complete -c fish_remove_path -f -a '(__fish_remove_path_candidates $fish_user_paths)' -d 'Directory in $fish_user_paths'
