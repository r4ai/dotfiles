function __fish_remove_path_candidates
    set -l seen
    for p in $PATH
        set -l n (path normalize -- $p)
        if test -n "$n"; and not contains -- $n $seen
            set -a seen $n
            echo $n
        end
    end
end

complete -c fish_remove_path -s h -l help -d 'Show help'
complete -c fish_remove_path -f -a '(__fish_remove_path_candidates)' -d 'Directory in $PATH'
