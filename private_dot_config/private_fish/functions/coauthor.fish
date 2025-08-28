function coauthor --description "Generate Co-Authored-By lines from GitHub usernames"
    set -l help "Usage:
  coauthor <github-username> [<github-username> ...]

Examples:
  coauthor octocat
  coauthor octocat defunkt

Usage:
  git commit -m 'feat: add some feature' -m (coauthor octocat)

Generates 'Co-Authored-By' trailers suitable for git commit."

    # Validate arguments
    if test (count $argv) -eq 0
        echo $help
        return 0
    end
    if contains -- -h $argv; or contains -- --help $argv
        echo $help
        return 0
    end

    # Ensure required commands are available
    if not type -q gh
        echo "Error: gh (GitHub CLI) not found" >&2
        return 1
    end
    if not type -q jq
        echo "Error: jq not found" >&2
        return 1
    end

    # Process each user
    for user in $argv
        set data (gh api "users/$user" --jq '{id: .id, name: .name, email: .email, login: .login}')
        set id (echo $data | jq -r '.id')
        set name (echo $data | jq -r '.name')
        set email (echo $data | jq -r '.email')
        set login (echo $data | jq -r '.login')

        if test -z "$name" -o "$name" = null
            set name $login
        end
        if test -z "$email" -o "$email" = null
            if test -z "$id" -o "$id" = null
                set email "$login@users.noreply.github.com"
            else
                set email "$id+$login@users.noreply.github.com"
            end
        end

        echo "Co-Authored-By: $name <$email>"
    end
end
