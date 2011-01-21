#!/bin/bash
 
 
for dir in *
do
  if [ -d "$dir" ]; then
    echo Updating $dir:
    echo cd $dir
    cd $dir
    echo git pull
    git pull
    echo cd ..
    cd ..
    echo
    #yay, we get matches!
  fi
done

