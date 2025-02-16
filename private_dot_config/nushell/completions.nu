use utils.nu command_exists

let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}

let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -i 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        __zoxide_z | __zoxide_zi => $zoxide_completer
        _ => $carapace_completer
    } | do $in $spans
}

$env.config.completions.external = {
    enable: true
    completer: $external_completer
}

if (command_exists carapace) {
    use nu_scripts/custom-completions/bat/bat-completions.nu *
}
if (command_exists cargo) {
    use nu_scripts/custom-completions/cargo/cargo-completions.nu *
}
if (command_exists cargo-loco) {
    use nu_scripts/custom-completions/cargo-loco/cargo-loco-completions.nu *
}
if (command_exists cargo-make) {
    use nu_scripts/custom-completions/cargo-make/cargo-make-completions.nu *
}
if (command_exists docker) {
    use nu_scripts/custom-completions/docker/docker-completions.nu *
}
if (command_exists dotnet) {
    use nu_scripts/custom-completions/dotnet/dotnet-completions.nu *
}
if (command_exists eza) {
    use nu_scripts/custom-completions/eza/eza-completions.nu *
}
if (command_exists flutter) {
    use nu_scripts/custom-completions/flutter/flutter-completions.nu *
}
if (command_exists fsharpc) {
    use nu_scripts/custom-completions/fsharpc/fsharpc-completions.nu *
}
if (command_exists fsharpi) {
    use nu_scripts/custom-completions/fsharpi/fsharpi-completions.nu *
}
if (command_exists gh) {
    use nu_scripts/custom-completions/gh/gh-completions.nu *
}
if (command_exists git) {
    use nu_scripts/custom-completions/git/git-completions.nu *
}
if (command_exists gradlew) {
    use nu_scripts/custom-completions/gradlew/gradlew-completions.nu *
}
if (command_exists just) {
    use nu_scripts/custom-completions/just/just-completions.nu *
}
if (command_exists make) {
    use nu_scripts/custom-completions/make/make-completions.nu *
}
if (command_exists mysql) {
    use nu_scripts/custom-completions/mysql/mysql-completions.nu *
}
if (command_exists npm) {
    use nu_scripts/custom-completions/npm/npm-completions.nu *
}
if (command_exists pnpm) {
    use nu_scripts/custom-completions/pnpm/pnpm-completions.nu *
}
if (command_exists rg) {
    use nu_scripts/custom-completions/rg/rg-completions.nu *
}
if (command_exists rustup) {
    use nu_scripts/custom-completions/rustup/rustup-completions.nu *
}
if (command_exists rye) {
    use nu_scripts/custom-completions/rye/rye-completions.nu *
}
if (command_exists scoop) {
    use nu_scripts/custom-completions/scoop/scoop-completions.nu *
}
if (command_exists ssh) {
    use nu_scripts/custom-completions/ssh/ssh-completions.nu *
}
if (command_exists tar) {
    use nu_scripts/custom-completions/tar/tar-completions.nu *
}
if (command_exists typst) {
    use nu_scripts/custom-completions/typst/typst-completions.nu *
}
if (command_exists vscode) {
    use nu_scripts/custom-completions/vscode/vscode-completions.nu *
}
if (command_exists winget) {
    use nu_scripts/custom-completions/winget/winget-completions.nu *
}
if (command_exists yarn) {
    use nu_scripts/custom-completions/yarn/yarn-v4-completions.nu *
}
if (command_exists zellij) {
    use nu_scripts/custom-completions/zellij/zellij-completions.nu *
}
