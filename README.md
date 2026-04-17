# Dotfiles

My personal dotfiles — zsh, vim, starship, Brewfile.

## Install

```sh
# clone
git clone https://github.com/robdox/Dotfiles.git ~/p/Dotfiles
cd ~/p/Dotfiles

# symlink into $HOME and install the modern toolchain via Homebrew
./bootstrap.sh --with-brew

# open a new terminal — zinit auto-installs on first run
```

`bootstrap.sh` without `--with-brew` only symlinks files. You can run
`brew bundle --file=~/p/Dotfiles/Brewfile` later.

## What's inside

```
.zshrc                         entry point; sources modules below
.zsh/config/00-env.zsh         history / locale / EDITOR / shell options
.zsh/config/10-path.zsh        PATH composition
.zsh/config/20-plugins.zsh     zinit + autosuggestions / syntax-highlighting / history-substring-search
.zsh/config/30-completion.zsh  compinit + completion styles
.zsh/config/40-keybindings.zsh vi-mode + emacs shortcuts + substring search
.zsh/config/50-prompt.zsh      Starship if installed, fallback PS1 otherwise
.zsh/config/60-tools.zsh       conditional init for mise / fzf / zoxide / atuin / direnv / SDKMAN
.zsh/config/70-unify.zsh       Unify workflow aliases (added in PR 3)
.zsh/functions/*               docker / compose helpers
starship.toml                  two-line prompt config → ~/.config/starship.toml
Brewfile                       full toolchain
bootstrap.sh                   symlink installer
```

## Tooling chosen (and why)

| Replaces                | With                    | Why                                               |
| ----------------------- | ----------------------- | ------------------------------------------------- |
| antigen                 | **zinit**               | faster, actively maintained                       |
| zeta-zsh-theme          | **starship**            | single binary, no shim bugs, language-aware       |
| nvm                     | **mise**                | unified: node + python + go + terraform + …       |
| `history \| grep`       | **atuin**               | searchable, syncable shell history                |
| `cd`                    | **zoxide (`z`)**        | jumps to frecent directories                      |
| grep / find / cat / ls  | **rg / fd / bat / eza** | modern, faster, better defaults                   |

If you don't install these, the shell still works — every integration in
`60-tools.zsh` is guarded by `command -v`.

## iTerm2: new tabs/splits in the current directory

- **iTerm2 → Settings → Profiles → General → Working Directory**
- Set to **"Reuse previous session's directory"**.

This makes `⌘T`, `⌘D`, and `⌘⇧D` start in the CWD of the current pane.

## Vim

Open `.vimrc.bundles` and run `:PlugInstall`. A Neovim (kickstart.nvim)
setup is planned as a follow-up PR.

## Updating

```sh
cd ~/p/Dotfiles && git pull
zinit update --all   # if plugins drift
brew bundle          # refresh toolchain
```
