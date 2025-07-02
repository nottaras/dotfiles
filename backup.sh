#!/bin/bash

rm -rf homebrew zsh vscode hammerspoon

# Backup Homebrew
mkdir -p homebrew
brew list --formula > homebrew/brew-formulas.txt
brew list --cask > homebrew/brew-casks.txt

# Backup Zsh
mkdir -p zsh
cp ~/.zshrc zsh/.zshrc
cp ~/.p10k.zsh zsh/.p10k.zsh

# Backup VSCode
mkdir -p vscode
cp ~/Library/Application\ Support/Code/User/settings.json vscode/settings.json
cp ~/Library/Application\ Support/Code/User/keybindings.json vscode/keybindings.json
cp -r ~/Library/Application\ Support/Code/User/snippets vscode/snippets
cp -r ~/.vscode/custom vscode
code --list-extensions > vscode/extensions.txt

# Backup Hammerspoon
mkdir -p hammerspoon
cp ~/.hammerspoon/init.lua hammerspoon/init.lua