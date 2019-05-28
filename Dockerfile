FROM alpine:latest

RUN addgroup -S app && adduser -S -G app app

RUN apk add --no-cache \
    sqlite \
    busybox-suid \
    su-exec

ENV DB_FILE /data/db.sqlite3
ENV BACKUP_FILE /data/db_backup/backup.sqlite3
ENV TIMESTAMP false
ENV UID 100
ENV GID 100
ENV LOGFILE /app/log/backup.log
ENV DAYS_TO_KEEP 14

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN mkdir -p /app/log/ \
    && chown -R app:app /app/ \
    && chmod -R 777 /app/ \
    && chmod +x /usr/local/bin/entrypoint.sh 

ENTRYPOINT ["entrypoint.sh"]
