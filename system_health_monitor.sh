
LOG_FILE="$HOME/system_health.log"  
EMAIL="hassan.shafkat@gmail.com"  
ALERT_CPU_THRESHOLD=90
ALERT_DISK_THRESHOLD=90
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
MEMORY_USAGE=$(free | awk '/Mem:/ { printf("%.2f", $3/$2 * 100.0) }')
DISK_USAGE=$(df / | awk 'END { print $5 }' | sed 's/%//')
UPTIME=$(uptime -p)
IP_ADDRESS=$(hostname -I | awk '{print $1}')

echo "$TIMESTAMP CPU: $CPU_USAGE% | RAM: $MEMORY_USAGE% | Disk: $DISK_USAGE% | IP: $IP_ADDRESS | Uptime: $UPTIME" >> "$LOG_FILE"

LOG_JSON=$(cat <<EOF
{
  "timestamp": "$TIMESTAMP",
  "cpu_usage": "$CPU_USAGE",
  "memory_usage": "$MEMORY_USAGE",
  "disk_usage": "$DISK_USAGE",
  "ip_address": "$IP_ADDRESS",
  "uptime": "$UPTIME"
}
EOF
)
echo "$LOG_JSON" >> "$LOG_FILE"

if (( $(echo "$CPU_USAGE > $ALERT_CPU_THRESHOLD" | bc -l) )); then
  echo -e "Subject: ALERT: High CPU Usage\n\nCPU usage is at ${CPU_USAGE}% on $TIMESTAMP" \
    | msmtp "$EMAIL"
fi

if (( DISK_USAGE > ALERT_DISK_THRESHOLD )); then
  echo -e "Subject: ALERT: Low Disk Space\n\nDisk usage is at ${DISK_USAGE}% on $TIMESTAMP" \
    | msmtp "$EMAIL"
fi

