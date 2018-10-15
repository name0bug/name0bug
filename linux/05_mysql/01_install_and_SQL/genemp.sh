#!/bin/bash

gensex()
{
    local num sex
    # 0 - 99
    num=$((RANDOM % 100))
    if test $num -gt 49; then
        sex="M"
    else
        sex="F"
    fi
    echo $sex
}

genage()
{
    local age
    # 18 - 65
    age=$((RANDOM % 48 + 18))
    echo $age
}

gensal()
{
    local sal
    sal=$((RANDOM % 31 + 2))
    echo $sal
}

genhiredate()
{
    local year month day
    # 2010 - 2018
    year=$((RANDOM % 9 + 2010))
    month=$((RANDOM % 12 + 1))
    day=$((RANDOM % 28 + 1))
    # 2014-07-31
    printf "%d-%02d-%02d\n" $year $month $day
}

gendeptno()
{
    local deptno
    deptno=$((RANDOM % 10 + 1))
    echo $deptno
}

if [ -z "$1" ];then
    echo "Usage: $(basename $0) <name-list-file>" >&2
    exit 1
fi

file=$1

# use database
echo "use company"

while read ename
do
    sex=$(gensex)
    age=$(genage)
    salary=$(gensal)
    hiredate=$(genhiredate)
    deptno=$(gendeptno)
    echo "insert into emp (ename, sex, age, salary, hiredate, deptno) values ('$ename','$sex','$age','$salary','$hiredate','$deptno');"
done < "$file"
