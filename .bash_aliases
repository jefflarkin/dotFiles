ARCH=`uname -s`

if [ "$ARCH" = "Linux" ] ; then
  alias ls='ls --color=auto'
fi

alias cl=clear
alias clls='clear;ls'
alias cd..='cd ..'
alias cd-='cd -'
alias pu='pushd'
alias po='popd'
alias d='dirs'
alias j=jobs
alias ll='ls -l'
alias ltr='ls -ltr'
alias ks=ls
alias mroe=more
alias moer=more
alias head='head -n 25'
alias tail='tail -n 25'
alias tai=tail
alias tf='tail -f'
alias vs="view -"
alias vlast='vi `ls -1t | head -n 1`'
alias clast='cat `ls -1t | head -n 1`'
alias tlast='tail `ls -1t | head -n 1`'
alias llast='less `ls -1t | head -n 1`'
alias last='ls -1t | head -n 1'
alias cdl='cd `ls -1t | head -n 1`'
alias td=todo.sh
alias be='$HOME/downloads/git-todo.py/birdseye.py $TODO_FILE $DONE_FILE'

VIM=`which vim`
if [ -x $VIM ] ; then
  alias vi='vim -X'
fi
alias f.='find . -name $1'
alias :q="echo \"Doh, You're not in vi any more.\""

QSTAT=`which qstat`
if [ -x $QSTAT ] ; then
  alias ql="qstat -u $USER"
fi
