# dotfiles

Personal macOS configuration managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

- `amethyst/` — Amethyst window manager config
- `aws/` — AWS CLI config
- `brew/` — Homebrew packages, casks, and taps
- `claude/` — Claude settings
- `config/` — `~/.config` (nvim, karabiner, linearmouse, starship)
- `git/` — gitconfig
- `mac-library/` — macOS Library (Amethyst, Bruno, Ghostty)
- `obsidian/` — Obsidian vault config
- `sdkman/` — SDKMAN config
- `shell/` — zshrc, scripts (claude quick ask, work launcher)

## Manual installs (not available in Homebrew)

- [GoodLinks](https://goodlinks.app) — link manager
- [Perplexity](https://www.perplexity.ai) — AI search
- [Things 3](https://culturedcode.com/things/) — task manager
- [Toggl Track](https://toggl.com/track/) — time tracking

## Why

Version-controlled dotfiles mean reproducible, portable setups across machines. New Mac? A few commands and you're back to a known-good state.

## How

**First-time setup on a new machine:**

```sh
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Clone this repo
git clone git@github.com:nottaras/dotfiles.git ~/.dotfiles

# Install all packages
brew bundle --file ~/.dotfiles/brew/brewfile

# Symlink configs
cd ~/.dotfiles
stow amethyst aws brew claude config git mac-library sdkman shell

# Obsidian (symlink manually into vault)
ln -sf ~/.dotfiles/obsidian/.obsidian ~/Obsidian/Vault/.obsidian
```

**Adding a new tool:**

```sh
brew install <tool>
brew bundle dump --force --file ~/.dotfiles/brew/brewfile
```
