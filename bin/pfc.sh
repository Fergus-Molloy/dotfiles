#!/bin/sh

p=$PWD
if test -f objfile
    then rm objfile
fi

case $# in
    1)  
        if test -f $1  
            then 
                $p/pfccomp $1 listing objfile
            else echo pfc: file $1 not found
        fi
        if test -f objfile
            then $p/pint objfile listing 
        fi ;;
    *)  echo Usage: pfc file
esac
