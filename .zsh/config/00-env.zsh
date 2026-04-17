# ~/.zsh/config/00-env.zsh — environment basics.

# Colors / locale
autoload -U colors && colors
export CLICOLOR=1
export LC_ALL="${LC_ALL:-en_US.UTF-8}"
export LANG="${LANG:-en_US.UTF-8}"

# Editor
export VISUAL=vim
export EDITOR=$VISUAL
export PAGER=less
export LESS="-R"

# History — bigger, deduped, shared across panes.
HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000
setopt INC_APPEND_HISTORY SHARE_HISTORY EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS
setopt HIST_EXPIRE_DUPS_FIRST HIST_VERIFY

# Nice defaults
setopt AUTO_CD             # bare dir path cds into it
setopt AUTO_PUSHD          # `cd` maintains a directory stack
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt EXTENDED_GLOB       # (N) (^) (.) etc.
setopt INTERACTIVE_COMMENTS
setopt NOTIFY
unsetopt BEEP
unsetopt CORRECT_ALL       # command CORRECT is fine; correcting every arg is not
setopt CORRECT

# Erlang shell history (kept from previous config; harmless).
export ERL_AFLAGS="-kernel shell_history enabled"
