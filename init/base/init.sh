#!/usr/bin/env bash

brew_install() {
  to_install_pkgs=()
  for pkg in "$@"; do
    if ! [ "$(command -v "$pkg")" ]; then
      to_install_pkgs+=("$pkg")
    fi
  done

  if [ ${#to_install_pkgs[@]} -gt 0 ]; then
    brew install "${to_install_pkgs[@]}"
  fi
}

reload() {
  exec $SHELL -l
}

# Install brew
if ! [ "$(command -v brew)" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Install mise
brew_install mise
eval "$(mise activate bash)"

# Install deno
mise use -g deno
program=$(
  if [ "$DEV" = "true" ]; then
    echo "./main.ts"
  else
    echo "https://raw.githubusercontent.com/r4ai/dotfiles/main/init/base/src/main.ts"
  fi
)
echo "program: $program"
deno run -A "$program"
