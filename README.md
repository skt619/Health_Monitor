
# 🖥️ System Health Monitor (Bash + Cron)

A lightweight Bash-based system monitoring tool for Ubuntu that logs CPU, memory, disk, and uptime stats, and sends alert emails when thresholds are exceeded — all in a simple Bash script with cron automation.

---

## 🔧 Features

- ✅ Logs system metrics every 5 minutes:
  - CPU usage
  - Memory usage
  - Disk usage
  - Uptime and IP address
- ✅ Logs in both plain text and JSON formats
- ✅ Sends email alerts if CPU or Disk thresholds are exceeded
- ✅ Uses `cron` + `msmtp` for automation and notifications

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/<your-github-username>/<repo-name>.git
cd <repo-name>
chmod +x system_health_monitor.sh
```

---

### 2. Install Required Packages

```bash
sudo apt update
sudo apt install bc msmtp mailutils
```

---

### 3. Configure Email Alerts (Gmail Example)

Create an App Password at [https://myaccount.google.com/apppasswords](https://myaccount.google.com/apppasswords)

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

Secure it:

```bash
chmod 600 ~/.msmtprc
```

---

### 4. Add the Script to Cron

Edit your crontab:

```bash
crontab -e
```

Add the following line:

```bash
*/5 * * * * /full/path/to/system_health_monitor.sh
```

> Use `pwd` inside your repo to get the full path.

---

## 📂 Files

- `system_health_monitor.sh`: Main monitoring script
- `system_health.log`: Appended log with both plain text and JSON
- `system_health_debug.log`: Cron debug log (optional, created at runtime)

---

## ⚙️ Customize Thresholds

Edit these lines in the script to change alert behavior:

```bash
EMAIL="your_email@gmail.com"
ALERT_CPU_THRESHOLD=90
ALERT_DISK_THRESHOLD=90
```

---

## 📬 Example Alert Email

```
Subject: ALERT: System Health Warning

Disk Usage: 91%
CPU Usage: 93%
Timestamp: 2025-05-19 14:10:00
```

---

## 🧪 Test Manually

```bash
bash system_health_monitor.sh
```

Lower thresholds to test alert functionality:

```bash
ALERT_CPU_THRESHOLD=5
ALERT_DISK_THRESHOLD=5
```

---

## 🧰 Troubleshooting

- Not receiving emails?
  - Confirm App Password is correct in `~/.msmtprc`
  - Confirm `msmtp` works manually:  
    ```bash
    echo "Test" | msmtp your_email@gmail.com
    ```
  - Check cron errors:
    ```bash
    cat ~/system_health_debug.log
    ```

---

## 📄 License

MIT License — free to use, modify, and share.

---

## 🙌 Contributing

Pull requests and feature suggestions are welcome!
