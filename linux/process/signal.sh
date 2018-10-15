#!/bin/bash

echo $$

myexit() {
    echo "有人给我发了 $i 信号，我不理它..."
}

for i in {1..31}; do
    trap "myexit $i" $i
done

read -p "请输入: " input

