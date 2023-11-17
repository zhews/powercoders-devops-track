#!/usr/bin/env bash

LTIME=`stat -c %Z $1`

while true    
do
   ATIME=`stat -c %Z $1`

   if [[ "$ATIME" != "$LTIME" ]]
   then
       pandoc -t revealjs -s $1 -o $1.html
       LTIME=$ATIME
   fi
   sleep 3
done

