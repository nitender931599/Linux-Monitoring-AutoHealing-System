#!/bin/bash

LOGFILE="$HOME/Linux-Monitoring-AutoHealing-System/logs/incident.log"

echo "==================================" >> $LOGFILE
echo "Timestamp: $(date)" >> $LOGFILE

# CPU Usage
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')

# Memory Usage
MEMORY=$(free | awk '/Mem:/ {printf("%.2f"), $3/$2*100}')

# Disk Usage
DISK=$(df / | awk 'NR==2 {print $5}')

echo "CPU Usage: $CPU%" >> $LOGFILE
echo "Memory Usage: $MEMORY%" >> $LOGFILE
echo "Disk Usage: $DISK" >> $LOGFILE

echo "" >> $LOGFILE
# Nginx Monitoring

if pgrep nginx > /dev/null
then
    echo "Nginx Status: Running" >> $LOGFILE
else
    echo "Nginx Status: DOWN" >> $LOGFILE
    echo "Attempting restart..." >> $LOGFILE

    sudo service nginx start

    if pgrep nginx > /dev/null
    then
        echo "Nginx restarted successfully" >> $LOGFILE
    else
        echo "Restart failed" >> $LOGFILE
    fi
fi
CPU_INT=$(echo $CPU | cut -d'.' -f1)
MEMORY_INT=$(echo $MEMORY | cut -d'.' -f1)
DISK_INT=$(echo $DISK | sed 's/%//')

if [ $CPU_INT -gt 80 ]; then
    echo "ALERT: CPU Usage Above 80%" >> $LOGFILE
fi

if [ $MEMORY_INT -gt 80 ]; then
    echo "ALERT: Memory Usage Above 80%" >> $LOGFILE
fi

if [ $DISK_INT -gt 80 ]; then
    echo "ALERT: Disk Usage Above 80%" >> $LOGFILE
fi
# Docker Container Monitoring

if docker ps --format '{{.Names}}' | grep -q "^webserver$"
then
    echo "Docker Container Status: Running" >> $LOGFILE
else
    echo "Docker Container Status: DOWN" >> $LOGFILE
    echo "Attempting container restart..." >> $LOGFILE

    docker start webserver >> $LOGFILE 2>&1

    if docker ps --format '{{.Names}}' | grep -q "^webserver$"
    then
        echo "Docker container restarted successfully" >> $LOGFILE
    else
        echo "Docker container restart failed" >> $LOGFILE
    fi
fi
