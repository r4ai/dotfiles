source ~/.config/fish/__get_os_name.fish
source ~/.config/fish/__confirm.fish
if test -e ~/.config/fish/vars.fish
    source ~/.config/fish/vars.fish
else
    set_color red
    echo "Error: ~/.config/fish/vars.fish does not exist."
    echo "       Please create ~/.config/fish/vars.fish and set the variables."
    set_color normal

    if __confirm "Create ~/.config/fish/vars.fish? [y/N] "
        touch ~/.config/fish/vars.fish
    end
end

function fish_greeting
end

# ---VARIABLES---
# $WINDOWS_HOMEが存在するかチェック
if test (__get_os_name -w) = true; and not set -q WINDOWS_HOME
    set_color red
    echo "Error: \$WINDOWS_HOME variable does not exist."
    echo "       Please set the \$WINDOWS_HOME variable to the path of the Windows home directory."
    set_color normal

    if __confirm "Set \$WINDOWS_HOME? [y/N] "
        read -P "Please enter the path of the Windows home directory (e.g. `/mnt/c/Users/r4ai`): " -xg WINDOWS_HOME
        echo "set -x WINDOWS_HOME $WINDOWS_HOME" >>~/.config/fish/vars.fish
    end
end

# ---OS SETTINGS---
switch (__get_os_name)
    case macos
        #* vscode
        fish_add_path PATH "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
        #* homebrew
        eval (/opt/homebrew/bin/brew shellenv)
        #* sed
        alias sed gsed

    case ubuntu arch
        #* homebrew
        if test -e /home/linuxbrew/.linuxbrew/bin/brew
            eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
        end
end

# ---WSL SETTINGS---
if test (__get_os_name -w) = true
    #* Explorer
    if test -e '/mnt/c/WINDOWS/explorer.exe'
        function open
            '/mnt/c/WINDOWS/explorer.exe' $argv
        end
    end

    #* VSCode
    if test -e "$WINDOWS_HOME/AppData/Local/Programs/Microsoft VS Code/bin/"
        fish_add_path PATH "$WINDOWS_HOME/AppData/Local/Programs/Microsoft VS Code/bin/"
    end
end

# ---UNIVERSAL SETTINGS---
#* volta(node.js version manager)
if test -e "$HOME/.volta"
    set -x VOLTA_HOME "$HOME/.volta"
    fish_add_path "$VOLTA_HOME/bin"
end

#* ghcup (haskell version manager)
if test -e "$HOME/.ghcup"; and test -e "$HOME/.cabal"
    set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
    fish_add_path "$HOME/.cabal/bin"
    fish_add_path "$HOME/.ghcup/bin"
end

#* wasmtime
if test -e "$HOME/.wasmtime"
    set -x WASMTIME_HOME "$HOME/.wasmtime"
    fish_add_path "$WASMTIME_HOME/bin"
end

#* pnpm
set -x PNPM_HOME "$HOME/.local/share/pnpm"
if test -e "$PNPM_HOME"
    fish_add_path "$PNPM_HOME"
end

#* pyenv
if type -q pyenv
    set -x PYENV_ROOT $HOME/.pyenv
    pyenv init - | source
end

#* jenv (java version manager)
if type -q jenv
    status --is-interactive; and jenv init - | source
end

#* tabtab
if [ -f ~/.config/tabtab/fish/__tabtab.fish ]
    . ~/.config/tabtab/fish/__tabtab.fish
end

#* opam (ocaml package manager)
if type -q opam
    # see https://github.com/ocaml-community/utop/issues/112#issuecomment-1842108174
    set -x OCAMLPATH $HOME/.opam/default/lib

    eval (opam env)
end

#* pipx (python cli manager)
fish_add_path "$HOME/.local/bin"
if type -q pipx
    register-python-argcomplete --shell fish pipx >~/.config/fish/completions/pipx.fish
end

#* bun
if test -e "$HOME/.bun"
    set --export BUN_INSTALL "$HOME/.bun"
    fish_add_path "$BUN_INSTALL/bin"
end

#* git-ignore
if test -e (git --exec-path)/git-ignore
    source (git ignore --completion fish | psub)
end

#* deno
export DENO_INSTALL="$HOME/.deno"
if test -e "$DENO_INSTALL"
    fish_add_path "$DENO_INSTALL/bin"
end

#* asdf (package manager)
if test -e "$HOME/.asdf"
    source ~/.asdf/asdf.fish
    if not test -e ~/.config/fish/completions
        ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
    end

    #* asdf-java
    if test -e "$HOME/.asdf/plugins/java"
        . ~/.asdf/plugins/java/set-java-home.fish
    end
end

#* mise
if type -q mise
    mise activate fish | source
    fish_add_path "~/.local/share/mise/shims"
end

#* cargo
if [ -d "$HOME/.cargo" ]
    fish_add_path "$HOME/.cargo/bin"
end

#* brew
if test -d (brew --prefix)"/share/fish/completions"
    set -a fish_complete_path (brew --prefix)/share/fish/completions
end
if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -a fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

#* zoxide
if type -q zoxide
    zoxide init fish | source
end

#* atcoder
if type -q atcoder
    source (atcoder completions fish | psub)
end

