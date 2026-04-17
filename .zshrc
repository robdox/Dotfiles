# Rob's .zshrc — modular.
#
# Load order (all modules are optional; shell boots even if absent):
#   00-env           history, locale, EDITOR, colors
#   10-path          PATH composition (pnpm, SDKMAN, etc.)
#   20-plugins       zinit + syntax highlighting / autosuggestions / etc.
#   30-completion    compinit
#   40-keybindings   vi-mode + history-substring-search
#   50-prompt        Starship if installed, otherwise vanilla PS1 fallback
#   60-tools         mise, fzf, zoxide, atuin, direnv, gh — conditional
#   70-unify         pnpm / turbo / prisma / docker / k8s / helm aliases
#   99-local         ~/.zshrc.local, ~/.aliases
#
# Each file is a thin module — read them in ~/.zsh/config/.

export DOTFILES="${DOTFILES:-$HOME/p/Dotfiles}"

echo "Loading Rob's .zshrc"

# Source ~/.zsh/config/*.zsh in numeric order (globs sort lexicographically).
if [[ -d $HOME/.zsh/config ]]; then
  for _module in $HOME/.zsh/config/*.zsh(N); do
    source "$_module"
  done
  unset _module
fi

# Autoloaded helper functions (docker helpers, etc.)
if [[ -d $HOME/.zsh/functions ]]; then
  for _fn in $HOME/.zsh/functions/*(N); do
    source "$_fn"
  done
  unset _fn
fi

# Machine-local overrides — last so they win.
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local
[[ -f $HOME/.aliases ]] && source $HOME/.aliases
