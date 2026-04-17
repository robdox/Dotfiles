# Brewfile — run `brew bundle --file=./Brewfile` from this repo.
# Optional: `brew bundle cleanup --file=./Brewfile --force` removes anything not listed.
#
# Note: `brew bundle` is now built into Homebrew — the old `homebrew/bundle`
# tap was deprecated and removed, so no `tap` line is needed here.

# ── Core shell tooling ──────────────────────────────────────────────────────
brew "zsh"
brew "starship"        # prompt
brew "mise"            # unified runtime manager (node/python/go/tf)
brew "direnv"          # per-directory envs
brew "atuin"           # searchable/syncable shell history
brew "fzf"             # fuzzy picker
brew "zoxide"          # smarter cd

# ── Modern replacements for core unix ───────────────────────────────────────
brew "eza"             # ls
brew "bat"             # cat
brew "ripgrep"         # grep
brew "fd"              # find
brew "git-delta"       # git pager
brew "jq"              # JSON
brew "yq"              # YAML
brew "tldr"            # man-page tl;dr

# ── Git / GitHub / editors ──────────────────────────────────────────────────
brew "git"
brew "gh"
brew "lazygit"
brew "neovim"          # optional; see PR 4 / README

# ── Unify workflow ──────────────────────────────────────────────────────────
brew "pnpm"
brew "kubectl"
brew "kubectx"         # provides kubectx + kubens
brew "k9s"
brew "stern"           # multi-pod log tailing
brew "helm"
brew "awscli"
brew "postgresql@17"   # psql client only; server runs via docker
brew "redis"           # redis-cli
brew "temporal"        # Temporal CLI (tctl successor)

# ── Casks ───────────────────────────────────────────────────────────────────
cask "font-jetbrains-mono-nerd-font"    # nerd-font glyphs for starship icons
