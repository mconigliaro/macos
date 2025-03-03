#!/usr/bin/env bash

set -eu

LOCATION=$1

# Install Homebrew
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [[ $(uname -m) == 'x86_64' && ! -e /opt/homebrew ]]; then
  sudo ln -s /usr/local /opt/homebrew
fi
compaudit | xargs chmod g-w

# Install packages
for l in common $LOCATION; do
  brewfile="packages/$l/Brewfile"
  if [[ -e "$brewfile" ]]; then
    brew bundle --file "$brewfile" --no-lock
  fi
done

vagrant plugin install vagrant-proxyconf
