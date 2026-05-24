# 手動セットアップ手順

`init.sh` が自動で行う処理を手動で実行する場合の手順。

## 1. Homebrew のインストール

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"  # Linux
# eval "$(/opt/homebrew/bin/brew shellenv)"             # macOS (Apple Silicon)
```

## 2. mise のインストールと有効化

```sh
brew install mise
eval "$(mise activate bash)"
```

## 3. chezmoi・deno のインストール

```sh
mise use -g chezmoi
mise use -g deno
```

## 4. Homebrew パッケージのインストール

```sh
brew update
brew install \
  git gh zoxide bat eza fzf ripgrep fd lazygit \
  xh hyperfine dust bottom silicon pueue procs \
  monolith starship neovim fish chezmoi ghq
brew cleanup
```

## 5. chezmoi の初期化と適用

```sh
chezmoi init https://github.com/r4ai/dotfiles.git
chezmoi apply
```

## 6. Fish の設定

### vars.fish の作成

```sh
touch ~/.config/fish/vars.fish
```

### WSL の場合: Windows ホームディレクトリの設定

```sh
echo "set -x WINDOWS_HOME /mnt/c/Users/<username>" >> ~/.config/fish/vars.fish
```

### Fish をデフォルトシェルに設定

```sh
# fish のパスを /etc/shells に登録
which fish | sudo tee -a /etc/shells

# デフォルトシェルを変更
chsh -s "$(which fish)"
```

## 7. fisher とプラグインのインストール

```sh
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fish -c "fisher install r4ai/my_fish_functions"
fish -c "fisher install decors/fish-ghq"
```

## 8. シェルの再起動

```sh
exec fish -l
```
