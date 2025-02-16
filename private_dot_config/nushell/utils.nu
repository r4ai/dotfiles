# Check if a given command exists
export def command_exists [name: string] {
    (help commands | where name == $name | length) > 0
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
