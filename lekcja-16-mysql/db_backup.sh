#!/bin/bash
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE=~/backups/blog_$DATE.sql
mkdir -p ~/backups
sudo mysqldump blog > $BACKUP_FILE
echo "Backup zapisany: $BACKUP_FILE"
