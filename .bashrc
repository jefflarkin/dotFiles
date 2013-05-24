# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoreboth:erasedups

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

# Taken from http://www.opinionatedprogrammer.com/2011/01/colorful-bash-prompt-reflecting-git-status/
function _git_prompt() {
  local git_status="`git status -unormal 2>&1`"
  if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
    if [[ "$git_status" =~ nothing\ to\ commit ]]; then
      local ansi=$GREEN
    elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
      local ansi=$RED
    else
      local ansi=$YELLOW
    fi
    if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
      branch=${BASH_REMATCH[1]}
      #test "$branch" != master || branch=' '
    else
      # Detached HEAD.  (branch=HEAD is a faster alternative.)
      branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
                echo HEAD`)"
    fi
    echo -n '[\['"$ansi"'\]'"$branch"'\[\e[0m\]] '
  fi
}

# Fix from http://wiki.archlinux.org/index.php/Talk:Color_Bash_Prompt
RET_SUCCESS="\[$GREEN\]:)\[$NC\]"
RET_FAILURE="\[$RED\]:(\[$NC\]"
function report_status()
{
  if [[ $? == 0 ]] ; then
    echo -ne $RET_SUCCESS
  else
    echo -ne $RET_FAILURE
  fi
}

if [[ "$PE_ENV" != "" ]] ; then
  export _PS1="\[$GREEN\]\D{%D %I:%M %p} (\$PE_ENV)\n\[$RED\]\u@\h \[$BLUE\]\w\[$NC\]\n\[$BLUE\][\[$NC\]\!\[$BLUE\]]\[$NC\] "
else
  export _PS1="\[$GREEN\]\D{%D %I:%M %p} \n\[$RED\]\u@\h \[$BLUE\]\w\[$NC\]\n\[$BLUE\][\[$NC\]\!\[$BLUE\]]\[$NC\] "
fi
export PS2="\[$NC\]> "
export PROMPT_COMMAND='_face=$(report_status);export PS1="${_PS1}$(_git_prompt)${_face} ";unset _face;'

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
echo -ne "\033]0;${MACHINE}\007"
if [[ "$TERM" = "screen" ]] ; then
  echo -ne "\033k${MACHINE}\033\\"
fi
export GEM_HOME=$HOME/gems/1.9
export RUBYLIB=$HOME/scripts:$GEM_HOME/lib:$RUBYDIR/lib
export PATH=$GEM_HOME/bin:$PATH
export PERL5PATH=$PERL5PATH:$HOME/lib/perl

# Load Architecture and Machine-specific files
if [[ `env | grep -c CRAY` != "0" && -f $HOME/.bashrc.cray_xt  ]] ; then
  if [ ! -d /opt/xmt-tools ] ; then
    . $HOME/.bashrc.cray_xt
  fi
fi

if [ -x $HOME/.rvm/scripts/rvm ] ; then
  source $HOME/.rvm/scripts/rvm
  PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
fi

# Workaround for getting clean zsh
#alias zsh="ssh -t $HOSTNAME /bin/zsh --login"
