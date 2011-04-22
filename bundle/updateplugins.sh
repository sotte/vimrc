#!/bin/bash
 
git submodule foreach git pull
 
#for dir in *
#do
  #if [ -d "$dir" ]; then
    #echo Updating $dir:
    #cd $dir
    #git pull
    #cd ..
    #echo
  #fi
#done
