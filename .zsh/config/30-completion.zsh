# ~/.zsh/config/30-completion.zsh — compinit + completion styles.

fpath=(
  $HOME/.zsh/completion
  /opt/homebrew/share/zsh/site-functions
  /usr/local/share/zsh/site-functions
  $fpath
)

autoload -Uz compinit
# Regenerate .zcompdump at most once per day.
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit -d "$HOME/.zcompdump"
else
  compinit -C -d "$HOME/.zcompdump"
fi

# Menu-select, case-insensitive, colorized.
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.zsh/cache"
