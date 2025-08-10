function fish_remove_path --description 'Remove one or more directories from PATH and fish_user_paths'
    set -l usage 'usage: fish_remove_path DIR [DIR ...]'
    argparse h/help -- $argv
    or begin
        echo $usage >&2
        return 2
    end

    if set -q _flag_help
        echo $usage
        echo 'Removes given directories (normalized) from $PATH and universal $fish_user_paths.'
        return 0
    end

    if test (count $argv) -eq 0
        echo $usage >&2
        return 2
    end

    # Normalize targets
    set -l targets (path normalize -- $argv)

    # Filter helper
    function __fish_rmpath_filter --no-scope-shadowing
        set -l out
        for p in $argv
            if not contains -- (path normalize -- $p) $targets
                set -a out $p
            end
        end
        echo $out
    end

    # Update PATH (exported)
    set -gx PATH (__fish_rmpath_filter $PATH)

    # Update fish_user_paths (universal, persists)
    if set -q fish_user_paths
        set -U fish_user_paths (__fish_rmpath_filter $fish_user_paths)
    end
end
