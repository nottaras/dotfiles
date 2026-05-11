# Starship
eval "$(starship init zsh)"

# Neovim
export EDITOR="$(which nvim)"
export VISUAL="$(which nvim)"

# Homebrew
export PATH=/opt/homebrew/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Zinit
source ~/.local/share/zinit/zinit.git/zinit.zsh
zinit ice depth=1

# Zinit plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit light junegunn/fzf
zinit light wfxr/forgit
# zinit light direnv/direnv.zsh-hook

# jEnv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
