#!/bin/bash

for f in .[a-zA-Z]* ; do
  if [[ $f == ".git"* ]] ; then continue ; fi
  cd $HOME
  if [ -f $f ] ; then
    if [ -f $f.orig ] ; then
      echo "About to replate $f.orig, please remove to continue."
      exit 1
    fi
    mv $f $f.orig
  fi
  ln -s $OLDPWD/$f $f
  cd -
done
cd $HOME
cp $OLDPWD/.gitconfig .
if [ ! -x $HOME/scripts ] ; then
  ln -s $OLDPWD/scripts scripts
fi
if [ ! -d $HOME/src ] ; then mkdir $HOME/src ; fi
for f in $OLDPWD/src/* ; do
  ln -s $f src
done
cd -
