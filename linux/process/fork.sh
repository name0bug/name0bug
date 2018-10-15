#!/bin/bash

MAX=100

do_work() {
    local i=1 name=${1-kyo}

    while [ $i -lt $MAX ] ; do
        echo -e "\033[31;1m $name \033[0m do work $i"
        sleep 1
        let i++
    done
}

create_child() {
    do_work &
}

trap "create_child" 17

create_child

read
