#!/bin/bash
#
# Sean Voisen <http://sean.voisen.org>

# -------------------------------------------------------------
# Basics
# -------------------------------------------------------------

# custom path
if [ -f ~/.bash_path ]; then
  . ~/.bash_path
fi

# library paths
export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"

# if not running interactively, don't do anything else
[ -z "$PS1" ] && return

# vi editing mode
set -o vi

: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

# autocomplete known hosts
: ${HOSTFILE=~/.ssh/known_hosts}

# default umask
umask 0022

# -------------------------------------------------------------
# External Includes
# -------------------------------------------------------------

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
# -------------------------------------------------------------

# history settings
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
HISTCONTROL=ignoreboth
HISTFILESIZE=10000
HISTSIZE=10000

# shell options. see bash(1) for details
shopt -s histappend
shopt -s checkwinsize

# -------------------------------------------------------------
# Prompt
# -------------------------------------------------------------

RED="\[\033[0;31m\]"
BROWN="\[\033[0;33m\]"
GREY="\[\033[0;97m\]"
BLUE="\[\033[0;34m\]"
PS_CLEAR="\[\033[0m\]"
SCREEN_ESC="\[\033k\033\134\]"

if [ "$LOGNAME" = "root" ]; then
  COLOR1="${RED}"
  COLOR2="${BROWN}"
  P="#"
else
  COLOR1="${BLUE}"
  COLOR2="${BROWN}"
  P="\$"
fi

prompt_bw() {
  PS1="\w${P} "
  PS2="> "
}

prompt_color() {
  PS1="${COLOR2}\w${COLOR1}${P}${PS_CLEAR} "
  PS2="${COLOR1}>${PS_CLEAR} "
}

prompt_bw

# -------------------------------------------------------------
# Pager and Editor
# -------------------------------------------------------------

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
# ------------------------------------------------------------- 

dircolors="$(type -P gdircolors dircolors | head -1)"
test -n "$dircolors" && {
  COLORS=/etc/DIR_COLORS
  test -e "/etc/DIR_COLORS.$TERM" && COLORS="/etc/DIR_COLORS.$TERM"
  test -e "$HOME/.dircolors" && COLORS="$HOME/.dircolors"
  test ! -e "$COLORS"
  eval `$dircolors --sh $COLORS`
}
unset dircolors

LS_COMMON="-hBG"
test -n "$LS_COMMON" &&
alias ls="command ls $LS_COMMON"

# -------------------------------------------------------------
# rvm
# -------------------------------------------------------------

[[ -s "/Users/svoisen/.rvm/scripts/rvm" ]] && source "/Users/svoisen/.rvm/scripts/rvm"

# -------------------------------------------------------------
# git
# -------------------------------------------------------------

source ~/git-completion.bash