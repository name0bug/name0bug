#!/bin/bash

err_exit() {
    echo $1
    exit $2
}

test "$UID" -eq 0 || err_exit "请使用sudo运行!"

# a="d\n4\n"
# a=$(echo -e "d\n4\n")
# a=$'d\n4\n'

# cat << EOF
# $a
# p
# EOF


fdisk /dev/sda &> /dev/null << EOF
d
4
d
3
d
2
n
p


+30G
t

7
n
p


+4G
EOF

