# ~/.zsh/config/50-prompt.zsh — Starship if installed, otherwise a simple
# two-line fallback so a fresh Mac still has a usable prompt.

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
else
  autoload -Uz vcs_info
  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:git:*' formats ' %F{green}%b%f'
  precmd() { vcs_info }
  setopt PROMPT_SUBST
  PROMPT='%F{blue}%~%f${vcs_info_msg_0_}
%(?.%F{green}❯%f.%F{red}❯%f) '
fi
