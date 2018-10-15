#!/bin/bash

keys=$1
cache_dir=/tmp/test/rpm_cache

find_keys() {
    for filename in $(ls $cache_dir) ; do
        egrep -l "$keys" $cache_dir/$filename &
    done
}

init() {
    rpm_dir=/opt/Packages

    for rpmfile in $(ls $rpm_dir); do
        touch $cache_dir/$rpmfile
        rpm -qlp $rpm_dir/$rpmfile 2> /dev/null > $cache_dir/$rpmfile
    done
}

if test ! -e $cache_dir ; then
    mkdir -p $cache_dir
    init
fi

find_keys


