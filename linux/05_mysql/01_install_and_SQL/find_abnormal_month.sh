#!/bin/bash

get_total() {
    local month=$1 year=$2
    cal $month $year | sed 's/_\x08//g' | tail -n +3 | grep -Eo '[0-9]+' | wc -l
}

for year in {1700..1800}
do
    for month in {1..12}
    do
        days=$(get_total $month $year)
        if test "$days" -lt 20; then
            echo "找到了：$year年$month月，只有$days天"
            exit
        else
            echo "已处理 $year-$month，有$days天"
        fi
    done
done
