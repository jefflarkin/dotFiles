#!/bin/bash

for f in .[a-zA-Z]* ; do
  if [[ $f == ".git"* ]] ; then continue ; fi
  cd ..
  if [ -x $f ] ; then
    mv $f $f.orig
  fi
  ln -s $OLDPWD/$f $f
  cd -
done
cd ..
cp $OLDPWD/.gitconfig .
ln -s $OLDPWD/scripts scripts
ln -s $OLDPWD/src src
cd -
