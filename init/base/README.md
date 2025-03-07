# 自動環境構築スクリプト

ある程度リソースが潤沢な Ubuntu or MacOS 向け

- Package manager: Homebrew
- Shell: Fish

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/r4ai/dotfiles/main/init/base/init.sh)"
```

## このスクリプトが行うこと

1. Homebrew, mise をインストールする。
2. mise を使って、chezmoi, deno をインストールする。
3. Homebrew を使って、[packages.ts](./src/packages.ts)にあるパッケージを全てインストールする。
4. `chezmoi init`を実行し、Fish shell を既定のシェルにする
5. fisher をインストールし、fisher で以下をインストールする。
   - r4ai/my_fish_functions
   - decors/fish-ghq
