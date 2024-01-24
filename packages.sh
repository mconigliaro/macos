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
sudo launchctl config user path /opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

# Install packages
for l in common $LOCATION; do
  brewfile="packages/$l/Brewfile"
  if [[ -e "$brewfile" ]]; then
    brew bundle --file "$brewfile" --no-lock
  fi

  if ! command -v pipenv >/dev/null 2>&1; then
    pip3 install pipenv
  fi
  pipfile_dir="packages/$l"
  if [[ -e "$pipfile_dir/Pipfile" ]]; then
    (
      cd "$pipfile_dir"
      pipenv lock
      pipenv install --system
    )
  fi

  gemfile="packages/$l/Gemfile"
  if [[ -e "$gemfile" ]]; then
    bundle install --gemfile "$gemfile"
  fi

  package_json_dir="packages/$l"
  if [[ -e "$package_json_dir/package.json" ]]; then
    (
      cd "$package_json_dir"
      npm install -g
    )
  fi
done

vagrant plugin install vagrant-proxyconf
