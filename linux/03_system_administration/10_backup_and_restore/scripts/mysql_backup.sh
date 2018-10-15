#!/bin/bash

#debug
echo "\$1: $1"
exit


:<<'THIS-IS-COMMENT'
需要备份的文件系统：
/dev/db/mysql --> /dev/db/snap_mysql

存放的位置：
/backup

备份级别的确定
一 二 三 四 五 六 日  
1  2  3  4  5  6  0

运行时间
02:30
THIS-IS-COMMENT

# which file system to backup
src="/dev/db/mysql"

# where to store the backup data
dst="/backup"

# snapshot size
snap_size="50M"

# determine the dump level
get_level()
{
    date +%w
}

log()
{
    logger -t "BACKUP" -p local0.info "$@"
}

if [ $UID -ne 0 ]; then
    log "must be root"
    exit 1
fi

if [ ! -d "$dst" ]; then
    log "$dst not exists"
    exit 1
fi

level=$(get_level)
dev_name=${src##*/}

# 开始干活

#1. 创建快照
# 快照的命名方式: snap_${orig_name}
snap_name="snap_$dev_name"
snap_path_name="${src%/*}/$snap_name"
lvcreate -s "$src" --name "$snap_name" -L "$snap_size"

#2. dump
dump_file="${dev_name}_${level}_$(date +'%Y%m%d%H%M')"
dump -${level}u "$snap_path_name" -f "$dst/$dump_file"

#3. 删除快照
lvremove -f "$snap_path_name"

#4. 记录日志: logger
log "dump finished at $(date)"

