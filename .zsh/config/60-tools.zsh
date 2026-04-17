# ~/.zsh/config/60-tools.zsh — initialize modern CLI tools if installed.
#
# Every hook is guarded so the shell boots cleanly on a fresh machine.
# Run `bootstrap.sh` (or `brew bundle`) to install the tools themselves.

# ── mise (node, python, go, terraform, …) ────────────────────────────────────
# Modern replacement for nvm / pyenv / tfenv. Lazy-activates per-dir via
# .tool-versions or .mise.toml.
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# ── nvm (fallback, lazy-loaded) ──────────────────────────────────────────────
# If mise isn't installed, fall back to nvm — but lazy-load it so it doesn't
# cost 300–800ms on every shell start.
if ! command -v mise >/dev/null 2>&1 && [[ -s "$HOME/.nvm/nvm.sh" ]]; then
  export NVM_DIR="$HOME/.nvm"
  _nvm_lazy_load() {
    unset -f nvm node npm npx pnpm yarn 2>/dev/null
    \. "$NVM_DIR/nvm.sh"
    [[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"
    "$@"
  }
  for _cmd in nvm node npm npx pnpm yarn; do
    eval "${_cmd}() { _nvm_lazy_load ${_cmd} \"\$@\"; }"
  done
  unset _cmd
fi

# ── fzf (fuzzy finder) ───────────────────────────────────────────────────────
# Provides Ctrl-R history search, Ctrl-T file picker, Alt-C dir picker.
# atuin (below) supersedes Ctrl-R if installed — we let it win.
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh) 2>/dev/null || true
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --cycle'
  if command -v rg >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi
fi

# ── zoxide (smarter cd) ──────────────────────────────────────────────────────
# `z <query>` jumps to any recently-visited directory that matches.
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# ── atuin (shell history) ────────────────────────────────────────────────────
# Rebinds Ctrl-R to a searchable, syncable history UI.
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

# ── direnv (per-directory env) ───────────────────────────────────────────────
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# ── gh (GitHub CLI completion) ───────────────────────────────────────────────
if command -v gh >/dev/null 2>&1; then
  eval "$(gh completion -s zsh)" 2>/dev/null || true
fi

# ── SDKMAN (Java, Kotlin, …) ─────────────────────────────────────────────────
# Must stay late in init per SDKMAN's instructions.
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
