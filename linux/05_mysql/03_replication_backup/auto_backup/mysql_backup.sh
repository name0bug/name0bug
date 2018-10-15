#!/bin/bash
:<<'COMMENT'
the server for backup is a slave server, slave server settings:
log-bin=xxyy
log_slave_updates=1

full backup with mysqldump --flush-logs --delete-master-logs --master-data=2 --add-drop-database --add-drop-table --lock-all-tables.
--- mysqldump -h 127.0.0.1 --flush-logs --delete-master-logs --all-databases > db_backup_201410121156.sql ---
incremental backup by backing up the binary logs created since the last backup, use mysqladmin to execute a flush-log before backing the binary log.
--- mysqladmin -h 127.0.0.1 flush-logs ---
all backup files are compressed with xz.
when a full backup is created, all old backups including full and incrementals are deleted.
COMMENT


incrbackup()
{
    :
}

fullbackup()
{
    :
}

log()
{
    :
}

telladmin()
{
    :
}

main()
{
    :
}
