#! ---LOAD CONFIG FILES---
source ~/.config/fish/env.fish
source ~/.config/fish/fish_greeting.fish
source ~/.config/fish/__get_os_name.fish
source ~/.config/fish/vars.fish


#! ---PROMPT/THEME settings---
set -g fish_prompt_pwd_dir_length 0 # prompt_pwdを省略させない
export BAT_THEME="TwoDark"
if type -q starship
    starship init fish | source
end


#! ---ALIAS SETTING---
#* eza, exa, ls
if type -q eza
    alias l 'eza -F --icons'
    alias ll 'eza -laF --icons'
    alias lll 'eza -lF --icons'
    alias lt 'eza -laT --icons'
else if type -q exa
    alias l 'exa -F --icons'
    alias ll 'exa -laF --icons'
    alias lll 'exa -lF --icons'
    alias lt 'exa -laT --icons'
else
    alias l ls
    alias ll 'ls -la'
    alias lll 'ls -l'
    if type -q tree
        alias lt tree
    end
end

#* NeoVim
if type -q nvim
    alias vi nvim
    alias vim nvim
end

#* Python
abbr py python3
alias att atcoder-tools
if type -q poetry
    alias penv 'source (poetry env info --path)/bin/activate.fish'
end

#* Node.js
if type -q volta
    abbr nvm volta
end

#* Git
if type -q git
    abbr g git
    abbr gs 'git status'
    abbr ga 'git add'
    abbr gaa 'git add .'
    abbr gcm 'git commit -m'
end

#* Silicon, Carbon (Code to Image)
if type -q silicon
    alias carbon silicon
    abbr carbon 'carbon -f HackGen'
    abbr silicon 'silicon -f HackGen'
end

#* SSH
abbr ssh-keygen 'ssh-keygen -t rsa -b 4096 -o -a 100'
abbr ssh-keygen-ed 'ssh-keygen -t ed25519'

#* topgrade (update all)
if type -q topgrade
    alias upgrade "topgrade --disable conda system"
end

#* ATCODER
if type -q oj
    abbr atcoder-test "oj test -c 'python3 ./main.py' -d ./tests"
end
if type -q acc
    abbr atcoder-submit "acc submit main.py"
    abbr atcoder-download "acc new"
end

#* YOUTUBE DL
if type -q yt-dlp
    function youtube-dlp
        switch $argv[1]
            case -h --help
                echo "usage: youtube-dlp [music|video] [\"URL\"]"
            case -v --version
                yt-dlp --version
            case music
                yt-dlp -x -f "ba[ext=webm]" --audio-format mp3 "$argv[2]"
            case video
                yt-dlp -f "bv[ext=mp4]+ba[ext=m4a]" --merge-output-format mp4 "$argv[2]"
        end
    end
end

#* paru (Arch Linux AUR)
if type -q paru
    abbr yay paru
    abbr yay-update 'paru -Syu'
    abbr paru-update 'paru -Syu'
end

#* yay (Arch Linux AUR)
if type -q yay
    abbr yay-update 'yay -Syu'
end

#* Task
if type -q go-task
    alias task go-task
end

#* Docker
if type -q docker
    abbr d docker
    abbr de "docker container exec --rm -it"
    abbr dc "docker compose"
    abbr dcb "docker compose build"
    abbr dcu "docker compose up -d"
    abbr dcd "docker compose down"
    abbr dce "docker compose exec"
    abbr dcl "docker compose log"
end

#* lazygit
if type -q lazygit
    abbr lg lazygit
end

#* Nix (NixOS, Nixpkgs)
if type -q nix
    abbr nix-install "nix profile install nixpkgs#"
end
