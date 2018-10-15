#!/bin/bash
#
# 描述：结合lvm 做dump备份，能够做快照的增量备份
#
# 请自行研究做以下扩展：
# 不允许删除备份文件
# 如果存储地空间不足，就不干活，警告管理员
# 如果卷组空间不足以创建快照，就不干活，警告管理员
# 把备份结果通知管理员
# 通过定时任务自动执行


# functions
#
# level design
# Mon Tue Wed Thu Fri Sat Sun
# 3   2   5   4   7   6   1
calculate_level()
{
    local l
    day=$(date +%u)
    case $day in
        1)  l=3 ;;
        2)  l=2 ;;
        3)  l=5 ;;
        4)  l=4 ;;
        5)  l=7 ;;
        6)  l=6 ;;
        7)  l=1 ;;
    esac

    echo $l
}

log()
{
    logger -t "$tag" -p "local0.info" "$1"
}

# 前期设计：把关键应用部署到lvm上面，为后面的备份打好基础
# 备份目标
targets=(
/dev/mysql/node1
/dev/mysql/node2
/dev/mysql/node3
)

snapshot_size="10M"
tag="Backup"

# 存储地
dst="/external/backup"
if [ ! -e $dst ];then
    echo "$dst doesn't exist"
    log "Destination $dst doesn't exist"
    exit 1
fi

# 备份级别
if [ -z "$1" ];then
    level=$(calculate_level)
else
    if grep -qE '^0$' <<< $1;then
        level=$1
    elif grep -qE '^[1-9][0-9]*$' <<< $1;then
        level=$1
    else
        echo "$1 is not a valid level"
        echo "Usage: $(basename $0) [LEVEL]"
        exit 1
    fi
fi

# 把数据dump出来
for device in ${targets[*]}
do
    # 创建快照
    bname=${device##*/}
    snapshot="snap-${bname}"

    if lvcreate -n $snapshot -s ${device} -L ${snapshot_size};then
        log "Snapshot created successfully: ${device/$bname/$snapshot}"
    else
        log "Snapshot created failed: ${device/$bname/$snapshot}"
    fi

    # dump 快照
    filename="$(date +%Y%m%d%H%M%S)_${level}_${bname}"
    if dump -${level} -u -f ${dst}/${filename} ${device/$bname/$snapshot}; then
        log "Dump finished successfully: ${device}"
    else
        log "Dump failed: ${device}"
    fi

    # 删快照
    if lvremove -f /dev/mysql/$snapshot; then
        log "Snapshot removed successfully: ${device/$bname/$snapshot}"
    else
        log "Snapshot removed failed: ${device/$bname/$snapshot}"
    fi

done



