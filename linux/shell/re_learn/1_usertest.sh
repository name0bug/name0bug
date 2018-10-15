#!/bin/bash
#
#sha512() {
#	sha6=$(python -c 'import crypt,getpass;pw="$passwd";print(crypt.crypt(pw))')	
##	sha6=$(openssl passwd -1 -salt '123456' "$passwd")
#}
#
#read -p "输入用户：" user
#echo
#read  -s -p "输入密码：" passwd
#sha512 $passwd
#echo
#echo "用户名：$user 密码：$sha6"

#
#a=$(cat /tmp/test | awk -F":" '{print $3}')
#b=1000
#c=0
#while true ; do
#	for i in $a ;do
#		if [ $b -eq $i ] ;then
#		let b++
#		fi
#	done
#	if [ $c -ne $b ] ;then
#	let c=$b
#	else
#	break
#	fi
#done
#echo $b

ping_ip() {
local b=$1
a=${1-9}

for i in $(seq 1 $a) ;do
	p=$(ping -c 1  $b$i > /dev/null |echo $?)
	if [ p -qe 1 ] ;then
	echo $b$i >> /tmp/have_used_ip
	elif [ p -qe 0 ] ; then
	echo $b$i >> /tmp/no_use_ip
	else
	echo "程序错误！"
	fi
done
}

ping_ip 3.3.3.
