# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

dir=$HOME/.zprofile.d
if [[ -d "$dir" && -n "$(ls -A "$dir")" ]]; then
    for f in "$dir"/*; do
        source "$f";
    done
fi
