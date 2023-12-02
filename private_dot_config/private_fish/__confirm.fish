function __confirm
    argparse -n __get_os_name -x 'p,h' \
        p/prompt \
        h/help -- $argv
    or return 1

    set -l help_msg "Description: Confirm the action

Usage: confirm [OPTIONS] [PROMPT_STR]

Example:
    confirm \"Are you sure?\" && echo \"Yes\"
    confirm --prompt \"echo \"Are you sure?\"\" && echo \"Yes\"
"
    function fish_greeting
    end
    if set -lq _flag_help
        echo $help_msg
        return 0
    else if set -lq _flag_prompt
        set -l prompt (eval $argv[1])
        read -p $prompt -l confirm
        if [ $confirm = 'y' -o $confirm = 'Y' ]
            return 0
        end
        return 1
    else
        set -l prompt $argv[1]
        read -P $prompt -l confirm
        if [ $confirm = 'y' -o $confirm = 'Y' ]
            return 0
        end
        return 1
    end
end
