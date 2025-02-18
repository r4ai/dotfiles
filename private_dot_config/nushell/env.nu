# env.nu
#
# Installed by:
# version = "0.102.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

use utils.nu command_exists

# carapace-bin
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu


# mise
let mise_path = $nu.default-config-dir | path join mise.nu
^mise activate nu | save $mise_path --force


# completions
def generate_completions [
    completions: list<record<command: string, path: string>>
] {
    $completions
    | par-each {|completion| if (command_exists $completion.command) { $completion } }
    | reduce --fold "" {|completion, acc| $acc + $"use ($completion.path) *\n" }
}

let completions = [
    { command: "bat", path: "nu_scripts/custom-completions/bat/bat-completions.nu" }
    { command: "cargo", path: "nu_scripts/custom-completions/cargo/cargo-completions.nu" }
    { command: "bat", path: nu_scripts/custom-completions/bat/bat-completions.nu }
    { command: "cargo", path: nu_scripts/custom-completions/cargo/cargo-completions.nu }
    { command: "cargo", path: nu_scripts/custom-completions/cargo-loco/cargo-loco-completions.nu }
    { command: "cargo", path: nu_scripts/custom-completions/cargo-make/cargo-make-completions.nu }
    { command: "docker", path: nu_scripts/custom-completions/docker/docker-completions.nu }
    { command: "dotnet", path: nu_scripts/custom-completions/dotnet/dotnet-completions.nu }
    { command: "eza", path: nu_scripts/custom-completions/eza/eza-completions.nu }
    { command: "flutter", path: nu_scripts/custom-completions/flutter/flutter-completions.nu }
    { command: "fsharpc", path: nu_scripts/custom-completions/fsharpc/fsharpc-completions.nu }
    { command: "fsharpi", path: nu_scripts/custom-completions/fsharpi/fsharpi-completions.nu }
    { command: "gh", path: nu_scripts/custom-completions/gh/gh-completions.nu }
    { command: "git", path: nu_scripts/custom-completions/git/git-completions.nu }
    { command: "gradlew", path: nu_scripts/custom-completions/gradlew/gradlew-completions.nu }
    { command: "just", path: nu_scripts/custom-completions/just/just-completions.nu }
    { command: "make", path: nu_scripts/custom-completions/make/make-completions.nu }
    { command: "mysql", path: nu_scripts/custom-completions/mysql/mysql-completions.nu }
    { command: "npm", path: nu_scripts/custom-completions/npm/npm-completions.nu }
    { command: "pnpm", path: nu_scripts/custom-completions/pnpm/pnpm-completions.nu }
    { command: "rg", path: nu_scripts/custom-completions/rg/rg-completions.nu }
    { command: "rustup", path: nu_scripts/custom-completions/rustup/rustup-completions.nu }
    { command: "rye", path: nu_scripts/custom-completions/rye/rye-completions.nu }
    { command: "scoop", path: nu_scripts/custom-completions/scoop/scoop-completions.nu }
    { command: "ssh", path: nu_scripts/custom-completions/ssh/ssh-completions.nu }
    { command: "tar", path: nu_scripts/custom-completions/tar/tar-completions.nu }
    { command: "typst", path: nu_scripts/custom-completions/typst/typst-completions.nu }
    { command: "vscode", path: nu_scripts/custom-completions/vscode/vscode-completions.nu }
    { command: "winget", path: nu_scripts/custom-completions/winget/winget-completions.nu }
    { command: "yarn", path: nu_scripts/custom-completions/yarn/yarn-v4-completions.nu }
    { command: "zellij", path: nu_scripts/custom-completions/zellij/zellij-completions.nu }
    { command: "ghq", path: completions/ghq_completion.nu }
]

(generate_completions $completions) | save -f ($nu.default-config-dir | path join completions.gen.nu)
