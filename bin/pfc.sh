#!/bin/sh

if test -f objfile
    then rm objfile
fi

case $# in
    1)  
        if test -f $1  
            then 
                pfccomp $1 listing objfile
            else echo pfc: file $1 not found
        fi
        if test -f objfile
            then pint objfile listing 
        fi ;;
    *)  echo Usage: pfc file
esac
