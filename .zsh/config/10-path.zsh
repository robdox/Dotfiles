# ~/.zsh/config/10-path.zsh — PATH composition.
#
# We prepend things we want to win over system binaries, then let downstream
# tools (mise, pnpm, SDKMAN) add their own shims.

typeset -U path PATH  # keep PATH entries unique

# Local project binaries first (node_modules/.bin/ is the classic JS perk).
path=(
  ./bin
  ./node_modules/.bin
  $HOME/.bin
  $HOME/.local/bin
  /opt/homebrew/bin
  /opt/homebrew/sbin
  /usr/local/bin
  /usr/local/sbin
  $path
)

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
[[ -d $PNPM_HOME ]] && path=($PNPM_HOME $path)

# Go (if installed via homebrew or official)
[[ -d "$HOME/go/bin" ]] && path=($path "$HOME/go/bin")

# Cargo
[[ -d "$HOME/.cargo/bin" ]] && path=($path "$HOME/.cargo/bin")

export PATH
