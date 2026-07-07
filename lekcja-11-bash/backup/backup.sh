#!/bin/bash
mkdir -p ~/backup
mkdir -p ~/backup/logs
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
copies_count=$(ls -d ~/backup/*/ | grep -v logs | sort | wc -l)
oldest=$(ls -d ~/backup/*/ | grep -v logs | sort | head -n 1)
if [ $copies_count -gt 7 ]; then
	rm -r $oldest
fi
mkdir -p ~/backup/$timestamp
while read -r katalog; do
    rsync -av --delete $katalog ~/backup/$timestamp >> ~/backup/logs/backup.log
done < backup.conf
if [ "$1" == "--restore" ]; then
    ls -d ~/backup/*/ | grep -v logs | sort | nl
read -p "Choose backup number: " numer
snapshot=$(ls -d ~/backup/*/ | grep -v logs | sort | sed -n "${numer}p")
rsync -av --delete $snapshot/Documents ~/Documents
fi
