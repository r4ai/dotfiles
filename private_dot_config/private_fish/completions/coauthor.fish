# Completion for `coauthor` function: suggest GitHub contributor usernames
# Requires: gh (GitHub CLI), jq

function __coauthor_contributors --description 'List contributor GitHub usernames for current repo'
    # gh がなければ何もしない
    type -q gh; or return 1

    # 現在のリポジトリ owner/name を取得
    set -l owner (gh repo view --json owner --jq '.owner.login' 2>/dev/null)
    set -l repo (gh repo view --json name  --jq '.name' 2>/dev/null)
    test -n "$owner"; and test -n "$repo"; or return 1

    # Contributors を取得（ページネーション対応）
    # GitHub username だけを出力
    gh api "repos/$owner/$repo/contributors" \
        --paginate \
        --jq '.[].login' 2>/dev/null | sort -u
end

# disable file name completion for this command entirely
complete -c coauthor -f

# -h / --help の補完
complete -c coauthor -s h -l help -d 'Show help'

# 引数位置で username 候補を提示（-h/--help が付いていない場合のみ）
complete -c coauthor -n 'not __fish_seen_argument -s h help' \
    -a '(__coauthor_contributors)' \
    -d 'GitHub contributor username (current repo)'
