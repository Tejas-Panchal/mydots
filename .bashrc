# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
export ANDROID_HOME="/home/virus/Dev/Android/sdk"
export PATH="/home/virus/Dev/flutter/bin:$PATH"

# Make an alias for invoking commands you use constantly
# alias p='python'

# opencode
export PATH=/home/virus/.opencode/bin:$PATH
. "$HOME/.cargo/env"

alias config="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
