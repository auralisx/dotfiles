### EXPORT ###
export EDITOR='nvim'
export VISUAL='zeditor'

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace:ignoreboth

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


if [ -d "$HOME/.bin" ] ;
then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
then PATH="$HOME/.local/bin:$PATH"
fi

# Colored `ls` and `grep`
if command -v dircolors >/dev/null 2>&1; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# === Prompt (minimal but informative) ===
PS1='\u@\h:\w\$'
