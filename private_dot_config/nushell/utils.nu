export-env {
    $env.command_exists_commands = help commands
    $env.command_exists_mise_commands = ^mise ls --json | from json
    $env.command_exists_last_check = date now
}

# Check if a given command exists
export def --env command_exists [name: string] {
    # refresh the cache every 30 seconds
    if ((((date now) - $env.command_exists_last_check) > 30sec)) {
        $env.command_exists_commands = help commands
        $env.command_exists_mise_commands = ^mise ls --json | from json
        $env.command_exists_last_check = date now
    }

    ((($env.command_exists_commands | where name == $name | length) > 0)
        or (($env.command_exists_mise_commands | get -i $name | length) > 0)
        or ((which $name | length) > 0))
}

# Get the operating system
# 
# Returns: windows | macos | linux
export def get_os []: nothing -> string {
    let os = $env.OS | str downcase
    if ($os | str contains "windows") { return "windows" }
    if ($os | str contains "darwin") { return "macos" }
    "linux"
}
