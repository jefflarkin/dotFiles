# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

if [ -f /etc/bashrc ] ; then 
  . /etc/bashrc
fi
if [ -f $HOME/.todo.cfg ] ; then
  . $HOME/.todo.cfg
fi
if [ -f $HOME/.bash_aliases ] ; then
  . $HOME/.bash_aliases
fi
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
elif [ -f $HOME/scripts/bash_completion ] ; then
  . $HOME/scripts/bash_completion
fi

export CDPATH=.:$HOME:..

#
# Define some colors first: Capitals denote bold
#
red='\e[0;31m'
RED='\e[1;31m'
green='\e[0;32m'
GREEN='\e[1;32m'
yellow='\e[0;33m'
YELLOW='\e[1;33m'
blue='\e[0;34m'
BLUE='\e[1;34m'
magenta='\e[0;35m'
MAGENTA='\e[1;35m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'              # No Color

ARCH=`uname -s`

# Convenience functions for adding to and removing
# from PATH
function append_path
{
  if [ -d $1 ] ; then
    export PATH=$PATH:$1
  fi
}
function remove_path
{
  export PATH=${PATH%%:$1}
}

# disable cores
#ulimit -c 0

EDITOR=vi
VISUAL=vi
PAGER=less
LESS="$LESS -R" #Allow colors
SVN_EDITOR=vim
export EDITOR VISUAL PAGER LESS SVN_EDITOR

append_path $HOME/scripts
append_path $HOME/bin

MACHINE=${HOSTNAME%%[0-9]*}

#report_status()
#{
#  if [[ $? == 0 ]] ; then
#    echo -ne "$GREEN:)$NC"
#  else
#    echo -ne "$RED:($NC"
#      fi
#}
# Fix from http://wiki.archlinux.org/index.php/Talk:Color_Bash_Prompt
RET_SUCCESS="$GREEN:)$NC"
RET_FAILURE="$RED:($NC"

export _PS1="\[\e]2;\u@\h:\w\007\e]1;\h\007\]$RED\u@\h $BLUE\w$NC\n"
export PS2="$NC> "
export PROMPT_COMMAND='if [[ $? -eq 0 ]]; then export PS1="${_PS1}${RET_SUCCESS} "; else export PS1="${_PS1}${RET_FAILURE} "; fi; echo -ne $green ; date +"%x %r"; echo -ne "$NC"'
#export PS1="\[\e]2;\u@\h:\w\007\e]1;\h\007\]\u@\h:\w\n> "

function monitor {
  clear
  echo "Monitoring $*"
  O=`$*`
  echo -n "$O"
  SUM=`echo $O | md5sum`
  while [ 1 -eq 1 ]; do
    sleep 10
    O=`$*`
    TMP=`echo $O | md5sum`
    if [ "$SUM" != "$TMP" ] ; then
      clear
      echo -e "\a$O\a"
      SUM=$TMP
    fi
  done
}

export LOCKPRG=$SHELL

