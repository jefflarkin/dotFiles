# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_dups
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
alias .=source
autoload colors
colors
# set some colors
for COLOR in RED GREEN YELLOW WHITE BLACK CYAN BLUE; do
  eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
  eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
PR_RESET="%{${reset_color}%}";

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
source $HOME/.zsh/functions/git.zsh

precmd(){
  if [[ "$PE_ENV" != "" ]] ; then
    local pe="($PE_ENV%)"
  fi
  local smiley="%(?,%{$fg[green]%}:%)%{$reset_color%},%{$fg[red]%}:(%{$reset_color%})"
  PROMPT="$PR_GREEN%W %t $pe
$PR_RED%n@%m $PR_BLUE%~
%B[%b$PR_RESET%!$PR_BLUE%B]%b$PR_RESET%_ $smiley "
  RPROMPT="$(git_prompt_info)"
}

DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups

CDPATH=.:$HOME:..
EDITOR=vi
VISUAL=vi
PAGER=less
SVN_EDITOR=vim
MACHINE=${HOST%[0-9]*}
PATH=$PATH:$HOME/bin:$HOME/scripts

source $HOME/.bash_aliases
[[ -s '/usr/local/lib/rvm' ]] && source '/usr/local/lib/rvm'
