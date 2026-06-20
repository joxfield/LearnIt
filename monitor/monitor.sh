#!/bin/bash
mkdir -p ~/monitor

# CPU
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print int(100 - $8)}')
if [ ! -f ~/monitor/cpu_counter.txt ]; then
    echo "0" > ~/monitor/cpu_counter.txt
fi
cpu_counter=$(cat ~/monitor/cpu_counter.txt)
if [ $cpu_usage -ge 80 ]; then
    cpu_counter=$((cpu_counter + 1))
    echo $cpu_counter > ~/monitor/cpu_counter.txt
    if [ $cpu_counter -ge 5 ]; then
        echo "ALERT: CPU usage above 80%" >> ~/monitor/alerts.log
    fi
else
    echo "0" > ~/monitor/cpu_counter.txt
fi

# RAM
memory_usage=$(free -m | grep Mem | awk '{print int($3/$2*100)}')
if [ $memory_usage -ge 80 ]; then
    echo "ALERT: Memory usage above 80%" >> ~/monitor/alerts.log
fi

# Dysk
diskspace_usage=$(df -h | grep /dev/sda2 | awk '{gsub("%","",$5); print int ($5)}')
if [ $diskspace_usage -ge 90 ]; then
    echo "ALERT: Disc space usage is above 90%!" >> ~/monitor/alerts.log
fi

# Usługi
ssh_check=$(systemctl is-active ssh)
if [ $ssh_check == inactive ]; then
    echo "ALERT: ssh is inactive!" >> ~/monitor/alerts.log
fi

cron_check=$(systemctl is-active cron)
if [ $cron_check == inactive ]; then
    echo "ALERT: cron is inactive!" >> ~/monitor/alerts.log
fi

# Logi systemowe
systemlog_check=$(journalctl -p err --since "5 minutes ago" | wc -l)
if [ $systemlog_check -gt 1 ]; then
    echo "ALERT: errors in system logs!" >> ~/monitor/alerts.log
fi

# Historia
echo "$(date +"%Y-%m-%d %H:%M:%S") cpu=$cpu_usage memory=$memory_usage disk=$diskspace_usage" >> ~/monitor/history.log
