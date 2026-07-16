#!/bin/bash
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR=~/pg_backups
mkdir -p $BACKUP_DIR

# Pełny backup
sudo -u postgres pg_dump business_db > $BACKUP_DIR/backup_$DATE.sql

if [ $? -eq 0 ]; then
    echo "Backup udany: backup_$DATE.sql"
else
    echo "Backup nieudany!" >> $BACKUP_DIR/backup_errors.log
fi
