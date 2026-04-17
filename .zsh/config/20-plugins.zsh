# ~/.zsh/config/20-plugins.zsh — zinit plugin manager.
#
# Replaces antigen. Self-installs to ~/.local/share/zinit on first run.
# If git is missing we silently skip plugin loading — shell still works.

ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
  if command -v git >/dev/null 2>&1; then
    print -P "%F{33}▓▒░ %F{220}Bootstrapping zinit plugin manager…%f"
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone --quiet https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
  fi
fi

if [[ -f $ZINIT_HOME/zinit.zsh ]]; then
  source "$ZINIT_HOME/zinit.zsh"
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit

  # Core plugins — syntax highlighting last so it wraps everything.
  zinit light zsh-users/zsh-autosuggestions
  zinit light zsh-users/zsh-history-substring-search
  zinit light zsh-users/zsh-completions
  zinit light zdharma-continuum/fast-syntax-highlighting

  # Autosuggestion styling — dim grey so it doesn't fight the prompt.
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
fi
