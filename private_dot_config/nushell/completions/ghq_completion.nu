export def parse_help [msg: string]: string -> record {
    let lines = $msg | lines
    mut cur_section = ""
    mut result = {}
    for $line in $lines {
        try {
            $cur_section = ($line | parse --regex '^(.+):' | str downcase).section.0
        }
        match $cur_section {
            "name" => {
                let value = $line
                    | parse --regex '^\s+(?<name>[^\s]+)\s-\s(?<description>.+)$'
                    | into record
                $result | update name { ...$result.name, ...$value }
            }
            "global options" | "options" => {
                let value = $line
                    | parse --regex ^\s+(?<long>.+?)(?:,\s(?<short>.+?))?\s+(?<description>.+)
                    | into record
                $result | update options [...$result.options, $value]
            }
            "commands" => {
                let value = $line
                    | parse --regex '^\s+(?<name>.+?)(,\s(?<alias>.+?))?\s+(?<description>.+)'
                    | into record
                $result | update commands [...$result.commands, $value]
            }
            _ => {}
        }
    }
    $result
}

# Manage remote repository clones
export extern "ghq" [
    --help(-h)    # show help
    --version(-v) # show version
]

# Clone/sync with a remote repository
export extern "ghq get" [
    --help(-h)                 # show help
    --version(-v)              # show version
    --update, -u               # Update local repository if cloned already (default: false)
    -p                         # Clone with SSH (default: false)
    --shallow                  # Do a shallow clone (default: false)
    --look, -l                 # Look after get (default: false)
    --vcs vcs                  # Specify vcs backend for cloning
    --silent, -s               # clone or update silently (default: false)
    --no-recursive             # prevent recursive fetching (default: false)
    --branch branch, -b branch # Specify branch name. This flag implies --single-branch on Git
    --parallel, -P             # Import parallelly (default: false)
    --bare                     # Do a bare clone (default: false)
    --help, -h                 # show help
]
