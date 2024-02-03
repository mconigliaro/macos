export EDITOR=vim
export PATH=$HOME/.local/bin:$PATH

# AWS
export AWS_SDK_LOAD_CONFIG=true # aws-sdk-js

# GitHub CLI
export GITHUB_TOKEN="$(<$HOME/.config/github/token)"

# Homebrew
export HOMEBREW_GITHUB_API_TOKEN="$GITHUB_TOKEN"
export HOMEBREW_NO_AUTO_UPDATE=1

# Ruby
# FIXME: This should probably use a system location
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH=$GEM_HOME/bin:$PATH

# ShellCheck
export SHELLCHECK_OPTS="-e SC1090"

dir=$HOME/.zshenv.d
if [[ -d "$dir" && -n "$(ls -A "$dir")" ]]; then
    for f in "$dir"/*; do
        source "$f";
    done
fi
