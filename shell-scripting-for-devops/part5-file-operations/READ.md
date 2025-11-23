# Shell Scripting for DevOps — Part 5  
**File Operations, find, grep, sed, awk & Automation**  
_By Ashish — Learn-in-Public DevOps Journey (Week 2)_  
🔗 LinkedIn: https://www.linkedin.com/in/ashish360/

---

# 📘 Table of Contents
- Why File Operations Matter in DevOps  
- Core File Commands (touch, echo, cat, sed, awk, grep)  
- Reading & Writing Files in Shell  
- Line-by-Line Processing  
- Bulk Operations (loop-based file processing)  
- The `find` Command (Beginner → Advanced → Production)  
- Combining grep + awk + sed (DevOps Text Toolkit)  
- Heavy Automation Scripts  
- File Permissions Automation  
- Real Production Scripts  
- DevOps Best Practices for File Processing  
- Examples Folder Overview  
- Next: Part 6 — DevOps Project Scripts & Cloud Automation

---

# ⚡ 1. Why File Operations Matter in DevOps

**Every DevOps pipeline = 70% file manipulation + 30% execution.**

You read them:  
✔ logs  
✔ YAML/JSON  
✔ config files  
✔ Dockerfiles  
✔ Kubernetes manifests  
✔ environment variables  
✔ CI/CD artifacts  

You write them:  
✔ deployment configs  
✔ build output  
✔ temporary files  
✔ health reports  
✔ backup data  

So your real power comes from mastering:

```
grep  → find patterns  
sed   → modify text  
awk   → extract & transform  
find  → locate & bulk operate  
```

This chapter takes you to a *true automation engineer* level.

---

# 📁 2. Core File Commands (Deep Explanation)

---

## **2.1 touch — Create a file**

```bash
touch file.txt
```

If file exists → updates its timestamp.

Used for:
- triggers in CI/CD  
- fake logs  
- marker files  

---

## **2.2 echo — Write to a file**

Overwrite:

```bash
echo "Hello DevOps" > app.log
```

Append:

```bash
echo "New entry" >> app.log
```

Production use:
- generating environment files  
- writing health status  
- writing logs for cron jobs  

---

## **2.3 cat — Read file content**

```bash
cat /etc/hostname
```

---

## **2.4 sed — Edit files directly**

Replacing text:

```bash
sed -i 's/dev/prod/g' config.yaml
```

Used for:
✔ CI/CD promotions  
✔ switching environments  
✔ bulk config updates  

---

## **2.5 awk — Extract fields**

```bash
awk '{print $1, $9}' access.log
```

Used for:
✔ log parsing  
✔ report generation  
✔ monitoring  

---

## **2.6 grep — Search text**

```bash
grep -i "error" app.log
```

Your #1 log debugging tool.

---

# 📖 3. Reading Files Line-by-Line (Correct DevOps Style)

```bash
while read line; do
    echo "Processing: $line"
done < file.txt
```

This is essential in:
- log processors  
- YAML/JSON cleaners  
- CSV extractors  
- automation pipelines  

---

# 📁 4. Bulk File Operations (Loop-Based)

## Create 100 files:

```bash
for i in {1..100}; do
    touch log$i.txt
done
```

## Create folders with arguments:

```bash
#!/bin/bash
for ((i=$1; i<=$2; i++)); do
    mkdir "$3$i"
done
```

Run:

```bash
./script.sh 1 50 backup
```

Creates:

```
backup1 backup2 … backup50
```

---

# 🔍 5. The `find` Command — Your DevOps Secret Weapon

ASCII Memory Map:

```
+----------------------+
|     find command     |
+----------------------+
        | filters
        v
+----------------------+
|    matched files     |
+----------------------+
        | actions
        v
+----------------------+
| rm, chmod, grep etc. |
+----------------------+
```

---

## **5.1 Find files by name**

```bash
find / -name "nginx.conf"
```

---

## **5.2 Find directories**

```bash
find /var -type d -name "log*"
```

---

## **5.3 Find files modified recently**

Last 24 hours:

```bash
find /var/log -mtime -1
```

---

## **5.4 Find & delete old files**

```bash
find /var/log -type f -mtime +7 -delete
```

Production use:  
✔ disk pressure  
✔ log cleanup  
✔ CI runner cleanup  

---

## **5.5 Find large files (>100MB)**

```bash
find / -type f -size +100M
```

---

## **5.6 Find & execute commands**

```bash
find /tmp -name "*.log" -exec rm -f {} \;
```

---

# 🎯 6. Combining grep + sed + awk (DevOps Power Trio)

## **6.1 Extract ERROR logs**
```bash
grep -i "error" app.log
```

---

## **6.2 Replace environment variable**
```bash
sed -i 's/ENV=dev/ENV=prod/g' .env
```

---

## **6.3 Extract IP + status code**
```bash
awk '{print $1, $9}' access.log
```

---

## **6.4 Extract top 10 offending IPs**

```bash
awk '{print $1}' access.log | sort | uniq -c | sort -nr | head
```

---

# 🔥 7. File Permission Automation

Fix Permission Denied errors:

```bash
sudo chown -R $USER:$USER /path
```

Make script executable:

```bash
chmod +x deploy.sh
```

---

# ⚙️ 8. Heavy Automation Scripts (Real DevOps)

---

## ✔ Script 1 — Clean Logs Automatically

```bash
#!/bin/bash
LOG_DIR="/var/log"
DAYS=7

find $LOG_DIR -type f -mtime +$DAYS -delete
echo "Old logs cleaned."
```

---

## ✔ Script 2 — Disk Pressure Debugger (On-Call)

```bash
du -sh /* | sort -h
df -h
```

---

## ✔ Script 3 — Service Auto-Restart

```bash
#!/bin/bash

if ! systemctl is-active --quiet nginx; then
  echo "Nginx down — restarting"
  systemctl restart nginx
fi
```

---

## ✔ Script 4 — Backup a Directory

```bash
tar -cvzf backup.tar.gz /etc
```

---

## ✔ Script 5 — Parse AWS EC2 Instance IDs

```bash
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'
```

---

# 🧱 9. Production-Grade File Automation Template

```bash
#!/bin/bash
set -euo pipefail

trap "echo 'Exiting safely'; cleanup" EXIT

cleanup() {
    echo "Cleanup running..."
    rm -f /tmp/app*
}

log() {
    echo "$(date) — $1"
}

process_logs() {
    for file in *.log; do
        log "Processing $file"
        grep -i "error" "$file" >> errors.txt
    done
}

main() {
    log "Started"
    process_logs
    log "Completed"
}

main "$@"
```

---

# 📁 10. Examples Folder Overview

Your `automation/` folder includes:

- line-by-line processors  
- cleanup scripts  
- bulk creators  
- log parsers  
- grep/sed/awk mashups  
- backup scripts  
- production templates  

---

# 🎉 Part 5 Complete — Advanced Automation Achieved

You now understand:

✔ File creation, reading, writing  
✔ Bulk file/folder automation  
✔ find (beginner → intermediate → advanced → production)  
✔ grep, sed, awk combination logic  
✔ DevOps cleanup, backup, and parsing scripts  
✔ Production-ready templates  

This chapter drastically upgrades your automation skills.
