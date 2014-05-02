#!/bin/bash

test=$1

if [ $test == 5 ]
  then
    echo "Yay you typed 5"
  else
    echo "Fuck you talking bout! Why did you type $@"
fi
