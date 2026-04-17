# ~/.zsh/config/80-aliases.zsh — general dev aliases.
#
# Modern `ls` / `cat` / etc. replacements are only aliased when their
# binaries are installed, so the shell stays portable.

# ── git ──────────────────────────────────────────────────────────────────────
alias g='git'
alias gs='git status'
alias gss='git stash save'
alias gsa='git stash apply'
alias gsp='git stash pop'
alias gco='git checkout'
alias gb='git branch'
alias gbl='git branch -l'
alias gc='git commit'
alias gca='git commit -a'
alias gcm='git commit -m'
alias gcan='git commit --amend --no-edit'
alias gp='git push'
alias gpl='git pull --ff-only'
alias gpf='git push --force-with-lease'   # safer than --force
alias gf='git fetch --all --prune'
alias gd='git diff'
alias gdc='git diff --cached'
alias glo='git log --oneline --graph --decorate -20'
alias gla='git log --oneline --graph --decorate --all -40'
alias grh='git reset HEAD'                # unstage
alias gundo='git reset --soft HEAD~1'     # undo last commit, keep changes

# Quick WIP commit (not for sharing — amend/squash before pushing).
gwip() { git add -A && git commit -m "wip: ${*:-save}"; }

# ── ls / cat / find — modern replacements only if installed ──────────────────
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --git'
  alias ll='eza -l --group-directories-first --git --time-style=long-iso'
  alias la='eza -la --group-directories-first --git --time-style=long-iso'
  alias lt='eza --tree --level=2 --group-directories-first'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never'
  alias less='bat'
  export BAT_THEME="Monokai Extended"
fi

if command -v fd >/dev/null 2>&1; then
  # Leave `find` alone, but surface a shorter alias.
  alias f='fd'
fi

# ── Navigation ───────────────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'         # back to previous dir

# ── Process / system ─────────────────────────────────────────────────────────
alias psg='ps aux | grep -v grep | grep -i'
alias ports='lsof -nP -iTCP -sTCP:LISTEN'

# ── Clipboard (pbcopy/pbpaste are macOS native; keep cb/cbpwd for muscle memory) ──
alias cb='pbcopy'
alias cbpwd='pwd | pbcopy'
alias cbssh='pbcopy < ~/.ssh/id_rsa.pub'
