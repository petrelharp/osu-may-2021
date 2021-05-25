#!/bin/bash

USAGE="
    $0 (name of file to look for figures in)
"

if [ $# -ne 1 ]
then
    echo "$USAGE"
    exit 1
fi

FILE="$1"
# the first directories have priority
SOURCEDIRS="/home/peter/teaching/talks/temp /home/peter/teaching/talks/ist-oct-2020 /home/peter/teaching/talks/reed-aug-2020 /home/peter/teaching/talks/uo-oct-2019 /home/peter/teaching/talks/france-may-2019 /home/peter/teaching/talks/idaho-march-2019 /home/peter/teaching/talks/madison-sept-2018"

FIGS="$(grep "\!\[" $FILE  | sed -e 's/.*(//' | sed -e 's/).*//')"
FIGS="$FIGS $(grep "src=" $FILE  | sed -e 's/.*src="//' | sed -e 's/".*//')"
FIGS="$FIGS $(grep "data-background-image" $1 | sed -e "s/.*=[\"']//" | sed -e "s/['\"].*//")"
MISSING=""

for x in $FIGS
do 
    if [ -e $x ]
    then
        echo "."
    elif [ -e ${x%.png}.pdf ]
    then
        echo "making $x"
        make $x
    else
        MISSING="$MISSING $x"
        echo $x
    fi
done


for SOURCEDIR in $SOURCEDIRS
do
    for x in $(echo $MISSING)
    do 
        if [ ! -e $x ]
        then
            if [ -e ${SOURCEDIR}/$x ]
            then
                mkdir -p $(dirname $x)
                cp ${SOURCEDIR}/$x $(dirname $x)
            elif [ -e $SOURCEDIR/$(basename ${x%.png}.pdf) ]
            then
                mkdir -p $(dirname $x)
                cp $SOURCEDIR/$(basename ${x%.png}.pdf) $(dirname $x) 
            fi
        fi
    done
done
