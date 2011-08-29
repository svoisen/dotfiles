#!/bin/bash
#
# Sean Voisen <http://sean.voisen.org>

# -------------------------------------------------------------
# Basics
# ------------------------------------------------------------ 

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# stupid simple prompt
export PS1="\w$ "

# custom path
if [ -f ~/.bash_path ]; then
  . ~/.bash_path
fi

# custom (non ls-related) aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# programmatic completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# -------------------------------------------------------------
# Environment
# ------------------------------------------------------------ 

# history settings
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
HISTCONTROL=ignoreboth
HISTFILESIZE=10000
HISTSIZE=10000

# shell options. see bash(1) for details
shopt -s histappend
shopt -s checkwinsize

# -------------------------------------------------------------
# Pager and Editor
# ------------------------------------------------------------ 

HAVE_VIM=$(command -v vim)
HAVE_GVIM=$(command -v gvim)

test -n "$HAVE_VIM" &&
  EDITOR=vim ||
  EDITOR=vi
export EDITOR

if test -n "$(command -v less)" ; then
  PAGER="less -FirSwX"
  MANPAGER="less -FirSwX"
else
  PAGER=more
  MANPAGER=more
fi
export PAGER MANPAGER

# -------------------------------------------------------------
# ls and Colors
# ------------------------------------------------------------ 

LS_COMMON="-hBG"

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi
