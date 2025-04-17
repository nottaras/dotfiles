#!/bin/bash

# Backup Homebrew
mkdir -p homebrew
brew list --formula > homebrew/brew-formulas.txt
brew list --cask > homebrew/brew-casks.txt

# Backup Zsh
mkdir -p zsh
cp ~/.zshrc zsh/.zshrc
cp ~/.p10k.zsh zsh/.p10k.zsh

# Backup VSCode
cp -r ~/.vscode/custom vscode

# Backup Hammerspoon

mkdir -p hammerspoon
cp -r ~/.hammerspoon hammerspoon
