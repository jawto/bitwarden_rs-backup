#!/bin/sh

if [ ! -d $(dirname "$BACKUP_FILE") ]
then
  mkdir -p $(dirname "$BACKUP_FILE")
fi

cd $(dirname "$DB_FILE")
if [ ! -d backups ]
then
  mkdir backups
fi

if [ $TIMESTAMP = true ]
then
  BACKUP_FILE="$(echo "$BACKUP_FILE")_$(date "+%F-%H%M%S")"
fi

bd=$(dirname "$BACKUP_FILE")
bf=$(basename "$BACKUP_FILE")

TMP_FILE=backups/$bf
/usr/bin/sqlite3 $(basename "$DB_FILE") ".backup $TMP_FILE"
/bin/tar czf backups/$bf.tar.gz $TMP_FILE $(ls -d attachments 2>/dev/null)
rm $TMP_FILE
mv backups/$bf.tar.gz $bd/

echo "$(date "+%F %T") - Backup successfull"
