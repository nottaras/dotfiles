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
mkdir -p vscode
cp /Users/taras/Library/Application\ Support/Code/User/settings.json vscode/settings.json
cp /Users/taras/Library/Application\ Support/Code/User/keybindings.json vscode/keybindings.json
cp -r /Users/taras/Library/Application\ Support/Code/User/snippets vscode/snippets

# Backup IntelliJ Idea
