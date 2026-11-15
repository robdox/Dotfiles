#!/usr/bin/env bash
# bootstrap.sh — symlink dotfiles into $HOME and (optionally) install tools.
#
# Usage:
#   ./bootstrap.sh              # symlinks only
#   ./bootstrap.sh --with-brew  # also runs `brew bundle`

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES"

say()  { printf "\033[1;34m▶\033[0m %s\n" "$*"; }
ok()   { printf "\033[1;32m✓\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m!\033[0m %s\n" "$*"; }

link() {
  local src="$1" dest="$2"
  if [[ -L $dest ]]; then
    if [[ $(readlink "$dest") == "$src" ]]; then
      ok "$dest → $src (already linked)"
      return
    fi
    warn "replacing existing symlink at $dest"
    rm "$dest"
  elif [[ -e $dest ]]; then
    warn "backing up existing $dest → ${dest}.bak"
    mv "$dest" "${dest}.bak"
  fi
  ln -s "$src" "$dest"
  ok "$dest → $src"
}

say "Linking top-level dotfiles…"
for f in .zshrc .vimrc .vimrc.bundles .vimrc.local .gitconfig .gitignore_global; do
  [[ -f $DOTFILES/$f ]] && link "$DOTFILES/$f" "$HOME/$f"
done
# .zshrc.local is machine-specific — create empty if missing, but don't overwrite.
if [[ ! -e $HOME/.zshrc.local ]]; then
  touch "$HOME/.zshrc.local"
  ok "created empty ~/.zshrc.local"
fi
# .gitconfig.local holds identity — stub it so git nags you instead of
# silently committing as the wrong person.
if [[ ! -e $HOME/.gitconfig.local ]]; then
  cat > "$HOME/.gitconfig.local" <<'EOF'
# Machine-local git identity (not committed). Included from ~/.gitconfig.
[user]
	# name = Your Name
	# email = you@example.com
EOF
  warn "created ~/.gitconfig.local — fill in [user] name/email"
fi

say "Linking .zsh/ and .vim/ directories…"
link "$DOTFILES/.zsh"  "$HOME/.zsh"
link "$DOTFILES/.vim"  "$HOME/.vim"

say "Linking Starship config…"
mkdir -p "$HOME/.config"
link "$DOTFILES/starship.toml" "$HOME/.config/starship.toml"

say "Linking Neovim config…"
link "$DOTFILES/nvim" "$HOME/.config/nvim"

if [[ "${1:-}" == "--with-brew" ]]; then
  if ! command -v brew >/dev/null 2>&1; then
    warn "Homebrew not installed. Install from https://brew.sh and re-run."
    exit 1
  fi
  say "brew bundle…"
  brew bundle --file="$DOTFILES/Brewfile"
fi

ok "Bootstrap complete. Open a new terminal to load the new config."
echo
echo "Next steps:"
echo "  • Run \`brew bundle --file=$DOTFILES/Brewfile\` to install the modern toolchain."
echo "  • iTerm2 → Settings → Profiles → General → Working Directory"
echo "    → set to \"Reuse previous session's directory\"."
echo "  • Run \`mise use -g node@lts python@3 go@latest\` to seed runtimes (Mason's LSPs need node + go)."
