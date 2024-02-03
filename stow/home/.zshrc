# Aliases
alias reload="exec zsh --login"

# Autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Completions
FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
autoload -Uz compinit
compinit

# Syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Starship
eval "$(starship init zsh)"

# iTerm2
iterm2_shell_integration=$HOME/.iterm2_shell_integration.zsh
if [[ -e "$iterm2_shell_integration" ]]; then
    source "$iterm2_shell_integration"
fi

# Key bindings
bindkey -e
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# History
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

dir=$HOME/.zshrc.d
if [[ -d "$dir" && -n "$(ls -A "$dir")" ]]; then
    for f in "$dir"/*; do
        source "$f";
    done
fi
