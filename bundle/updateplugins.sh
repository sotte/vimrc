#!/bin/bash
 
 
for dir in *
do
  if [ -d "$dir" ]; then
    echo Updating $dir:
    cd $dir
    git pull
    cd ..
    echo
  fi
done

