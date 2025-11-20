# https://blog.sa2taka.com/post/git-hub-pr-comments/
function pr-comments --description "まとめてPRコメントを表示する"
    # 最新のPR番号とリポジトリ名を取得
    set -l pr_number (gh pr view --json number -q .number)
    set -l repo (gh repo view --json owner,name -q '"\(.owner.login) \(.name)"')
    set -l owner (echo $repo | awk '{print $1}')
    set -l name (echo $repo | awk '{print $2}')

    # GraphQLで未解決スレッドのみ取得
    set -l graph_query '
query($owner:String!, $name:String!, $number:Int!){
  repository(owner:$owner, name:$name){
    pullRequest(number:$number){
      reviewThreads(first:100){
        nodes{
          id
          isResolved
          path
          line
          originalLine
          comments(first:100){
            nodes{
              id
              body
              createdAt
              replyTo{id}
              author{login}
            }
          }
        }
      }
    }
  }
}'

    # jqクエリ: 未解決スレッドのみ整形
    set -l jq_query '
.data.repository.pullRequest.reviewThreads.nodes
| map(select(.isResolved | not))
| map({
    thread_id: .id,
    file: .path,
    line: (.line // .originalLine // 0),
    comments: (.comments.nodes | sort_by(.createdAt) | map({
      id: .id,
      user: .author.login,
      body: .body,
      created_at: .createdAt,
      is_reply: (.replyTo != null)
    }))
  })
| sort_by(.file, .line)
'

    gh api graphql -F owner=$owner -F name=$name -F number=$pr_number -f query="$graph_query" \
        | jq -r "$jq_query" \
        | jq -r '
.[] |
"📁 \(.file):\(.line)",
"🧵 スレッドID: \(.thread_id)",
(.comments[] |
  if .is_reply then
    "  └─ 💬 \(.user): \(.body)"
  else
    "  🟢 \(.user): \(.body)"
  end
),
""
'
end
