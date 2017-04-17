#!/bin/bash

for f in .[a-zA-Z]* ; do
  if [[ $f == ".git"* ]] ; then continue ; fi
  cd $HOME
  if [ -f $f ] ; then
    mv $f $f.orig
  fi
  ln -s $OLDPWD/$f $f
  cd -
done
cd $HOME
cp $OLDPWD/.gitconfig .
ln -s $OLDPWD/scripts scripts
if [ ! -d $HOME/src ] ; then mkdir $HOME/src ; fi
for f in $OLDPWD/src/* ; do
  ln -s $f src
done
cd -
