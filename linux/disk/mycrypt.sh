#!/bin/bash

uuid=3a0035bb-ba95-45da-bd66-808ee22fac56
uuid_dir=/dev/disk/by-uuid

# dev_name=$(sudo blkid | grep "$uuid" | awk -F":" '{print $1}')
# dev_name=$(realpath $uuid_dir/$(readlink $uuid_dir/$uuid))
dev_name=$(blkid -U $uuid)
crypt_dev_name=kyo
mount_dir=${1-/mnt}

err_exit() {
    echo $1
    exit $2
}

open() {
    cryptsetup luksOpen $dev_name $crypt_dev_name || return 1
    mount /dev/mapper/$crypt_dev_name  $mount_dir
}

close() {
    umount /dev/mapper/$crypt_dev_name || return 1
    cryptsetup luksClose $crypt_dev_name
}

test "$UID" -eq 0 || err_exit "请使用sudo运行!" 1

test "$mount_dir" = "close" && close || open

