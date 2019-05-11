#!/bin/sh

if [ ! -d $(dirname "$BACKUP_FILE") ]
then
  mkdir -p $(dirname "$BACKUP_FILE")
fi

if [ $TIMESTAMP = true ]
then
  BACKUP_FILE="$(echo "$BACKUP_FILE")_$(date "+%F-%H%M%S")"
fi

/usr/bin/sqlite3 $DB_FILE ".backup $BACKUP_FILE.tmp"
/bin/tar czf $BACKUP_FILE $BACKUP_FILE.tmp attachments
rm $BACKUP_FILE.tmp

if [ $? -eq 0 ] 
then 
  echo "$(date "+%F %T") - Backup successfull"
else
  echo "$(date "+%F %T") - Backup unsuccessfull"
fi
