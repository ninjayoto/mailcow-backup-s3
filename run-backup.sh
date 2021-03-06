#!/bin/sh

DATE=`date '+%Y-%m-%d_%H:%M:%S'`

echo "--> Running Backup..."

mysqldump --default-character-set=utf8mb4 -u${DBUSER} -p${DBPASS} -h mysql ${DBNAME} > /mysqldump.sql
tar cvfz /backup/backup_mailcow_${DATE}.tar.gz /vmail /mysqldump.sql
s3 put /backup/ ${AWS_BUCKET}
rm -rf /backup/*
rm -rf /mysqldump.sql

echo "--> Backup finished!"
