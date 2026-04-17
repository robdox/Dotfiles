# Dotfiles

Personal dotfiles — zsh, vim, and friends.

## Install

```sh
cd ~/p && git clone --recursive https://github.com/robdox/Dotfiles.git
cd Dotfiles

# symlink into $HOME
for f in .zshrc .zshrc.local .antigenrc .vimrc .vimrc.bundles .vimrc.local; do
  ln -sf "$PWD/$f" "$HOME/$f"
done
ln -sf "$PWD/.zsh" "$HOME/.zsh"
ln -sf "$PWD/.vim" "$HOME/.vim"

# Open a new shell — antigen will fetch plugins on first run.
```

If `antigen.zsh` is missing inside `antigen/`, you skipped `--recursive`.
Run `git submodule update --init` from the repo root.

## iTerm2: new tabs/splits in the current directory

Out of the box iTerm2 opens every new tab/split at `$HOME`. To inherit the
current shell's working directory:

- **iTerm2 → Settings → Profiles → General → Working Directory**
- Choose **"Reuse previous session's directory"** (apply to your default profile).

This makes `⌘T`, `⌘D`, and `⌘⇧D` all start in the CWD of the current pane.

## Vim

Open `.vimrc.bundles` and run `:PlugInstall` to install plugins.

## Layout

- `.zshrc` / `.zshrc.local` — shell entry + machine-local overrides
- `.antigenrc` — antigen plugin bundle
- `.zsh/config/*` — modular zsh config, loaded by `.zshrc`
- `.zsh/functions/*` — autoloaded helper functions
- `.vimrc` / `.vim/` — vim configuration
