#!/bin/bash

dstfile=$(tempfile)

cat > $dstfile << EOF
http://www.baidu.com/index.html
http://www.baidu.com/1.html
http://post.baidu.com/index.html
http://mp3.baidu.com/index.html
http://www.baidu.com/3.html
http://post.baidu.com/2.html
EOF


while read line; do
    line=${line#*http://}
    line=${line%%/*}
    echo $line
done < $dstfile | sort | uniq -c | sort -rn
