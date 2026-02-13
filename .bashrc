# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
export ANDROID_HOME="/home/virus/Dev/Android/sdk"
export PATH=$PATH:/home/virus/Dev/flutter/bin
export PATH=$PATH:/home/virus/Dev/Android/sdk/platform-tools/
# opencode
export PATH=$PATH:/home/virus/.opencode/bin
. "$HOME/.cargo/env"

# Following line was automatically added by arttime installer
export MANPATH=/home/virus/.local/share/man:$MANPATH
export PATH=/home/virus/.local/bin:$PATH

# for running autoclicker
# export YDOTOOL_SOCKET="$HOME/.ydotool_socket"

export PATH=/home/virus/Scripts:$PATH
export PATH=$PATH:$HOME/.local/share/go/bin

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Make an alias for invoking commands you use constantly
alias p='python'
alias config="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
