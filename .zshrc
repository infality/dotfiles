export ZSH=/usr/share/oh-my-zsh
export BROWSER=/usr/bin/firefox
PROMPT='%F{cyan}[%n %f%1~%F{cyan}]%#%f '

export HISTCONTROL=ignorespace

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

texedit() { zathura ${1:0:-3}pdf &; nvim "$1"; }
alias bpm="python ~/Programming/python/bpm.py"
alias weather="python ~/Programming/weather/weather.py"
alias xclip="xclip -selection c"
alias win=~/bootWindows.sh
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

bindkey '^[Oc' forward-word
bindkey '^[Od' backward-word
bindkey '^H' backward-delete-word
bindkey '^[[3^' delete-word

plugins=(
archlinux
common-aliases
compleat
copyfile
extract
gitfast
pip
sudo
web-search
)

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:~/.local/bin"
