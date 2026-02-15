# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source modular config files
source ~/.config/zsh/shell
source ~/.config/zsh/aliases
source ~/.config/zsh/functions
source ~/.config/zsh/init
source ~/.config/zsh/envs

# History settings (can keep here or move to shell)
HISTFILE=~/.histfile
HISTSIZE=32768
SAVEHIST=32768
setopt autocd

# Emacs-style keybindings
bindkey -e

# Completion system
zstyle :compinstall filename '/home/virus/.zshrc'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case-insensitive completion
autoload -Uz compinit
compinit

# Key bindings (equivalent to bash inputrc)
# Arrow keys for history search
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

