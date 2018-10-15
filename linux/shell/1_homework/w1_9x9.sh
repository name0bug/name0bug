#!/bin/bash

i=1
while [ $i -lt 10 ] ; do
    j=1
    while [ $j -le $i ]; do
        # if [ $j -eq 1 ]; then
            # printf "%d x %d = %d " $j $i $[i * j]
        # else
            # printf "%d x %d = %-2d " $j $i $[i * j]
        # fi

        # [ $j -eq 1 ] && f="%d x %d = %d " || f="%d x %d = %-2d "
        # printf "$f" $j $i $[i * j]


        printf "$([ $j -eq 1 ] && echo "%d x %d = %d "  \
                            || echo "%d x %d = %-2d ")" $j $i $[i * j]

        let j++
    done
    echo
    let i++
done



i=1
until [ $i -ge 10 ] ; do
    j=1
    until [ $j -gt $i ]; do
        printf "$([ $j -eq 1 ] && echo "%d x %d = %d "  \
                            || echo "%d x %d = %-2d ")" $j $i $[i * j]

        let j++
    done
    echo
    let i++
done



