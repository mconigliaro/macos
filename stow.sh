#!/usr/bin/env bash

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")/stow"

brew_prefix=$(brew --prefix)
stow_options="--verbose --no-folding $*" # Use --delete to unstow

# Shell
zsh_path="$brew_prefix/bin/zsh"
if [[ "$SHELL" != "$zsh_path" ]]; then
    sudo chsh -s "$zsh_path" "$USER"
fi

# OpenSSH
if [[ ! -d "$HOME/.ssh" ]]; then
    ssh-keygen -t rsa -b 4096 -o -a 100
fi

# Squid pre-stow
squid_conf="$brew_prefix/etc/squid.conf"
if [[ -e "$squid_conf" && ! -L "$squid_conf" ]]; then
    mv "$squid_conf" "$squid_conf-orig"
fi

# Stow
stow $stow_options --target "$HOME" home
stow $stow_options --target "$brew_prefix" homebrew

# Squid post-stow
if [[ ! -d "$brew_prefix/var/cache/squid/00" ]]; then
    squid -z
fi
brew services restart squid
