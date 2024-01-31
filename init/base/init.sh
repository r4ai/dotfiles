#!/usr/bin/env bash

brew_install() {
  for pkg in "$@"; do
    if ! [ "$(command -v "$pkg")" ]; then
      brew install "$pkg"
    fi
  done
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

# Run init script
program=$(
  if [ "$DEV" = "true" ]; then
    echo "./src/main.ts"
  else
    echo "https://raw.githubusercontent.com/r4ai/dotfiles/main/init/base/src/main.ts"
  fi
)
deno cache --reload "$program"
deno run -A "$program"
