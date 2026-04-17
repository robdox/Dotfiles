# ~/.zsh/config/70-unify.zsh — Unify workflow aliases & helpers.

# ── Repo jump ────────────────────────────────────────────────────────────────
# `u` is the main monorepo. Fall through to zoxide `z <name>` for anything else.
alias u='cd ~/p/unify'
alias dots='cd ~/p/Dotfiles'

# ── pnpm / Turborepo ─────────────────────────────────────────────────────────
alias pi='pnpm install --silent'
alias pb='pnpm build'
alias pt='pnpm test:unit'
alias pti='pnpm test:integration'
alias ptc='pnpm typecheck'
alias pl='pnpm lint'
alias plf='pnpm lint:fix'
alias pfmt='pnpm format'
alias pv='pnpm validate'
alias peg='pnpm env:generate'

# lint:fix + format in one — the canonical "clean up before commit" combo per CLAUDE.md.
alias pclean='pnpm lint:fix && pnpm format'

# `pw @unifygtm/data build` → `pnpm --filter=@unifygtm/data build`.
pw() {
  if (( $# < 2 )); then
    echo "usage: pw <package-filter> <pnpm-args…>" >&2
    return 2
  fi
  pnpm --filter="$1" "${@:2}"
}

# Turbo passthrough (CLAUDE.md already aliases `turbo=pnpm turbo`, preserve it).
alias turbo='pnpm turbo'

# ── Prisma (schema lives in prisma-schema/) ──────────────────────────────────
alias prm='pnpm --filter=prisma-schema migrate'
alias prp='pnpm --filter=prisma-schema prepare-migration'
alias prl='pnpm --filter=prisma-schema lint:migrations'
alias prg='pnpm --filter=prisma-schema generate'

# ── Docker compose (generic) ─────────────────────────────────────────────────
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcr='docker compose restart'
alias dcpl='docker compose pull'
alias dcbu='docker compose build'
alias dclg='docker compose logs -f'
alias dcps='docker compose ps'

# ── Kubernetes ───────────────────────────────────────────────────────────────
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgd='kubectl get deploy'
alias kd='kubectl describe'
alias kl='kubectl logs -f'
alias kex='kubectl exec -it'
alias kx='kubectx'
alias kn='kubens'

# stern (multi-pod log tailing) — scoped to Unify services by default.
alias kst='stern --tail 100'

# ── Helm ─────────────────────────────────────────────────────────────────────
alias hlm='helm'
alias hldt='pnpm helmdt'   # diff-template helper described in CLAUDE.md

# ── GitHub CLI ───────────────────────────────────────────────────────────────
alias ghpc='gh pr create --web'
alias ghpv='gh pr view --web'
alias ghpl='gh pr list'
alias ghpcs='gh pr checks'
alias ghrw='gh run watch'

# ── Shell meta ───────────────────────────────────────────────────────────────
alias reload='exec zsh'
alias zrc='$EDITOR ~/p/Dotfiles/.zshrc'
alias zenv='$EDITOR ~/p/Dotfiles/.zsh/config/00-env.zsh'
alias zuni='$EDITOR ~/p/Dotfiles/.zsh/config/70-unify.zsh'
