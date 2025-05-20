
# System Health Monitor (automated)

A lightweight Bash-based system monitoring tool for Ubuntu that logs CPU, memory, disk, and uptime stats, and sends alert emails when thresholds are exceeded — all in a simple Bash script with cron automation.

---

## Features

- Logs system metrics every 5 minutes:
  - CPU usage
  - Memory usage
  - Disk usage
  - Uptime and IP address
- Logs in both plain text and JSON formats
- Sends email alerts if CPU or Disk thresholds are exceeded
- Uses `cron` + `msmtp` for automation and notifications

---

### Clone the Repository

```bash
git clone https://github.com/skt619/Health_Monitor.git
cd Health_Monitor
chmod +x system_health_monitor.sh
```

---

### Install Required Packages

```bash
sudo apt update
sudo apt install bc msmtp mailutils
```

---

### Configure Email Alerts (Gmail Example)

Then create `~/.msmtprc`:

```ini
defaults
auth on
tls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile ~/.msmtp.log

account gmail
host smtp.gmail.com
port 587
from your_email@gmail.com
user your_email@gmail.com
password your_app_password

account default : gmail
```

'your_app_password' is not your gmail password

Create an App Password at [https://myaccount.google.com/apppasswords](https://myaccount.google.com/apppasswords)

Secure it:

```bash
chmod 600 ~/.msmtprc
```

---

### Add the Script to Cron

Edit your crontab:

```bash
crontab -e
```

Add the following line:

```bash
*/5 * * * * /full/path/to/system_health_monitor.sh
```




