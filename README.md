# dotfiles

Personal macOS configuration managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What

- `brewfile` — all Homebrew packages, casks, and taps

## Why

Version-controlled dotfiles mean reproducible, portable setups across machines. New Mac? A few commands and you're back to a known-good state.

## How

**First-time setup on a new machine:**

```sh
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Clone this repo
git clone git@github.com:nottaras/dotfiles.git ~/.dotfiles

# Enter the repo
cd ~/.dotfiles

# Install all packages
brew bundle --file brewfile

# Symlink configs with stow (once you have config directories here)
stow .
```

**Adding a new tool:**

```sh
brew install <tool>
brew bundle dump --force --file brewfile   # update brewfile
```
