# Dotfilesgs

## Quick Setup

```
/bin/bash -c "$(curl -fsSL https://https://raw.githubusercontent.com/r4ai/dotfiles/main/init/base/init.sh)"
```

## Manual Setup

### Install chezmoi

macOS:

```sh
brew install chezmoi
```

ArchLinux:

```sh
paru -S chezmoi
```

windows:

```sh
winget install twpayne.chezmoi
```

with curl:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)"
```

> <https://www.chezmoi.io/install/>

### Setup tab completion

For fish shell:

```sh
chezmoi completion fish --output=~/.config/fish/completions/chezmoi.fish
```

> <https://www.chezmoi.io/reference/commands/completion/>

### Initialize chezmoi

```sh
chezmoi init https://github.com/r4ai/dotfiles.git
```

## WSL Ubuntu setup

### Install ubuntu

インストール可能なディストリビューション一覧を確認する：

```sh
wsl --list --online
```

`ubuntu--22.04`をインストールする：

```sh
wsl --install -d ubuntu-22.04
```

### setup user

新規ユーザーを追加する：

```sh
sudo adduser USER_NAME
```

ユーザに、sudo権限を付与する：

```sh
sudo gpasswd -a USER_NAME sudo
```

作成したユーザーでubuntuが起動するようにする：

```sh
ubuntu2204.exe config --default-user USER_NAME
```

> - [NOTEMITE.com | 【Ubuntu】sudo ユーザーを作成する方法](https://www-creators.com/archives/241)
> - [Zenn.dev | WSLがrootで起動してしまう現象](https://zenn.dev/ohno/articles/48ed2935c5094f)

### Fish shellにする

fishをインストールする：

```sh
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish
```

> <https://launchpad.net/~fish-shell/+archive/ubuntu/release-3>

起動シェルをfishにする：

```bash
chsh -s "$(which fish)"
```

### setup chezmoi

chezmoiをインストールする：

```sh
sh -c "$(curl -fsLS get.chezmoi.io)"
```

`PATH` を通す：

```sh
fish_add_path bin/
```

chezmoi を初期化する：

```sh
chezmoi init https://github.com/YOUR_NAME/DOTFILES_REPO.git
```

クローンしてきた内容を適用する：

```sh
chezmoi apply
```

### install nix

```sh
curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
```

> <https://nix.dev/install-nix>

### install packages

```sh
# starship (prompt)
nix profile install nixpkgs#starship

# gh (github cli)
nix profile install nixpkgs#gh

# bat (cat)
nix profile install nixpkgs#bat

# eza (ls)
nix profile install nixpkgs#eza

# ripgrep (grep)
nix profile install nixpkgs#ripgrep

# fd (find)
nix profile install nixpkgs#fd

# neovim (vim)
nix profile install nixpkgs#neovim
```

## References

- [User guide | chezmoi](https://www.chezmoi.io/user-guide/command-overview/)
- [chezmoi で dotfiles を手軽に柔軟にセキュアに管理する | Zenn](https://zenn.dev/ryo_kawamata/articles/introduce-chezmoi)
