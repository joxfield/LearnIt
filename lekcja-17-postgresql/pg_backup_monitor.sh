#!/bin/bash
BACKUP_DIR=~/pg_backups
LAST_BACKUP=$(ls -t $BACKUP_DIR/*.sql 2>/dev/null | head -1)

if [ -z "$LAST_BACKUP" ]; then
    echo "ALERT: Brak kopii zapasowych!"
    exit 1
fi

LAST_BACKUP_TIME=$(stat -c %Y "$LAST_BACKUP")
CURRENT_TIME=$(date +%s)
DIFF=$(( (CURRENT_TIME - LAST_BACKUP_TIME) / 3600 ))

if [ $DIFF -gt 24 ]; then
    echo "ALERT: Ostatni backup starszy niż 24 godziny!"
else
    echo "OK: Ostatni backup sprzed $DIFF godzin"
fi
