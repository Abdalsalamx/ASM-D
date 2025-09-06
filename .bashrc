#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1=' \W ❯ '

export PATH="$HOME/.local/bin:$PATH"

for dir in ~/.config/Scripts ~/.config/Scripts/*/; do
    [ -d "$dir" ] && PATH="$dir:$PATH"
done


