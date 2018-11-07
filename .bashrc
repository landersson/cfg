
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# unset means unlimited
unset HISTSIZE
unset HISTFILESIZE

# appent every command to the external history
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER \
               "$(history 1)" >> ~/.bash_eternal_history'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [[ `uname` == Darwin ]]; then 
    export PS1="\h:\W:>"
else
    export PS1="\[\e[29;1m\]\h:\[\e[0m\]\W:>"
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [[ "$TERM" != "dumb" ]]; then
    if [[ `uname` == "Darwin" ]]; then
        if [ -x /opt/local/bin/gls ]; then
            LS=/opt/local/bin/gls
            DC=/opt/local/bin/gdircolors
            GREP=/opt/local/bin/ggrep
        else
            echo "Darwin: GNU tools not found"
            alias ls="ls -p -G" 
            export LSCOLORs=gxfxcxdxbxegedabagacad
            export LS_COLOrS='ex=01;37'
        fi
    else
        LS="/bin/ls"
        DC=`which dircolors`
        GREP=`which grep`
    fi

    if [ -x $DC ]; then
        test -r ~/.dircolors && eval "$($DC -b ~/.dircolors)" || eval "$($DC -b)"
        alias ls="$LS --color=auto"
        alias grep="$GREP --color=auto"
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi
fi

# config managment
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# functions

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

ldpathadd() {
    if [ -d "$1" ] && [[ ":$LD_LIBRARY_PATH:" != *":$1:"* ]]; then
        LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+"$LD_LIBRARY_PATH:"}$1"
    fi
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# source mac-ports git-completion if found
if [ -f /opt/local//share/git/contrib/completion/git-completion.bash ]; then
    source /opt/local//share/git/contrib/completion/git-completion.bash
fi

export EDITOR=vim

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
if [ -f $HOME/.local/bin/virtualenvwrapper.sh ]; then
    source $HOME/.local/bin/virtualenvwrapper.sh
fi

export PYTHONSTARTUP=$HOME/.pythonrc.py


# run local bashrc if found
if [ -e $HOME/.bashrc.local ]; then
    . $HOME/.bashrc.local 
fi

