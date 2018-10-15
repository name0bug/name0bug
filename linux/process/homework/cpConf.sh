#!/bin/bash

# find /etc -name "*.conf" | xargs cp -t /tmp/test
#   或
# cp -t /tmp/test $(find /etc/ -name "*.conf")

# 重名问题解决:

err_exit() {
    echo $1
    exit $2
}

get_new_filename() {
    local filename=${1##*/}
    local newname=$filename
    local dstpath=${2}

    while test -e $dstpath/$newname; do
        if test -z ${nameCount[$filename]}; then
            nameCount[$filename]=1
        else
            let nameCount[$filename]++
        fi
        newname=$filename.${nameCount[$filename]}
    done

    echo $newname
}

declare -A nameCount

dstpath=/tmp/test

if test -e "$dstpath"; then
    test -d $dstpath || err_exit "错误: 目标是文件!" 1
else
    mkdir -p $dstpath
fi

for path in $(find /etc/ -type f -name "*.conf" 2> /dev/null); do
    test -r $path || continue

    # filename=$(get_new_filename $path $dstpath)

    cp $path $dstpath/$(get_new_filename $path $dstpath)
done

