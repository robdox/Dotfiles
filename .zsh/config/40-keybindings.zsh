# ~/.zsh/config/40-keybindings.zsh — vi mode + sensible emacs shortcuts.

# vi mode for command-line editing. Keep emacs-style movement in insert mode
# so Ctrl-A / Ctrl-E / Ctrl-W still work.
bindkey -v
export KEYTIMEOUT=1   # faster Esc→normal mode transition

# Emacs-style editing in insert mode.
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^W' backward-kill-word
bindkey '^U' backward-kill-line
bindkey '^K' kill-line
bindkey '^Y' yank
bindkey '^?' backward-delete-char      # backspace
bindkey '^[[3~' delete-char            # Del

# Word-wise movement with option-arrow (iTerm2 default).
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[b' backward-word
bindkey '^[f' forward-word

# History substring search (loaded by zinit in 20-plugins).
# Bind up/down arrows and vicmd k/j.
if (( ${+widgets[history-substring-search-up]} )); then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
fi

# Prefix-search fallback if the plugin isn't loaded (shell still usable).
if (( ! ${+widgets[history-substring-search-up]} )); then
  bindkey '^[[A' history-search-backward
  bindkey '^[[B' history-search-forward
fi
