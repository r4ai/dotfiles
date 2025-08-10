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

    for arg in $argv
        if set -l index (contains -i "$arg" $PATH)
            set -e PATH[$index]
            echo "Removed "$arg" from the \$PATH"
        end

        if set -l index (contains -i "$arg" $fish_user_paths)
            set -e fish_user_paths[$index]
            echo "Removed "$arg" from the \$fish_user_paths"
        end
    end
end
