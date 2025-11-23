# Shell Scripting for DevOps — Part 4  
**Trap, Signals, Cleanup Automation, Background Jobs, nohup & Cron Scheduling**  
_By Ashish — Learn-in-Public DevOps Journey (Week 2)_  
🔗 LinkedIn: https://www.linkedin.com/in/ashish360/

---

# 📘 Table of Contents
- Why Signals Matter in DevOps  
- How Linux Processes Receive Signals  
- Common Signals (SIGINT, SIGTERM, SIGHUP, SIGKILL…)  
- `trap` Command — The DevOps Lifeline  
- Cleanup Handlers with `trap`  
- Prevent Script Exit with Handlers  
- Long-Running Tasks & Background Jobs (`&`, jobs, fg, bg)  
- nohup — Keep Processes Alive After Logout  
- Cron Jobs (Beginner → Advanced)  
- Real DevOps Automation Examples  
- Production Templates  
- Examples Folder Overview  
- Next: Part 5 (File Operations, find, grep, sed, awk)

---

# ⚡ 1. Why Signals Matter in DevOps

Let’s be very clear:

**If your script cannot handle interruptions, it is NOT production-safe.**

Deployments get stopped.  
SSH sessions get dropped.  
Users press Ctrl+C by mistake.  
Containers restart mid-way.  
Cron jobs die halfway.

Signals are how **Linux controls, kills, pauses, and resumes processes**.

Your job as a DevOps engineer:

✔ Catch interruptions  
✔ Clean up files  
✔ Stop halfway deployments cleanly  
✔ Remove temp resources  
✔ Avoid partial failures  

This is why **trap + signals** is one of the most important DevOps topics.

---

# 🧠 2. How Linux Signals Work (ASCII Diagram)

```
+-----------------------+
|   User / System Event |
+-----------------------+
             |
             v
+-----------------------+
|        Kernel         |
| Generates a signal    |
+-----------------------+
             |
             v
+-----------------------+
|     Target Process    |
| (script, nginx, etc.) |
+-----------------------+
```

Example events that trigger signals:

- Ctrl+C → SIGINT  
- kill command → SIGTERM  
- SSH session dropped → SIGHUP  
- System restart → SIGTERM  
- Forced kill → SIGKILL (cannot be trapped)

---

# 🔔 3. Common Signals Every DevOps Engineer Must Know

| Signal | Number | Meaning | Can trap? |
|--------|--------|----------|-----------|
| `SIGINT` | 2 | Interrupt (Ctrl+C) | ✔ |
| `SIGTERM` | 15 | Termination request | ✔ |
| `SIGHUP` | 1 | Hangup (SSH disconnect) | ✔ |
| `SIGQUIT` | 3 | Quit + core dump | ✔ |
| `SIGKILL` | 9 | Force kill | ❌ cannot trap |
| `SIGUSR1` | — | Custom signal | ✔ |

Among these, **SIGINT, SIGTERM, SIGHUP** matter most in DevOps.

---

# 🪝 4. `trap` — The DevOps Safety Hook

`trap` lets you run a custom command *when a signal arrives*.

### Syntax:
```bash
trap "commands_to_run" SIGNAL1 SIGNAL2 ...
```

### Example (simple):
```bash
trap "echo 'You pressed Ctrl+C'" SIGINT
```

Now pressing Ctrl+C prints message instead of killing script.

---

# 🧹 5. Cleanup Handlers — MUST for Automation

Cleanup ensures your scripts **never leave the system dirty**.

### Example: Remove temp files on exit
```bash
#!/bin/bash

tmp="/tmp/build.log"

trap "rm -f $tmp" EXIT

echo "Temporary file created"
touch $tmp

sleep 5
echo "Exiting..."
```

When script exits (normal or Ctrl+C):  
→ file removed.

This is used in:

- deployments  
- build jobs  
- file processing pipelines  
- CI agents  
- cron scripts

---

# 🛑 6. Handling Ctrl+C Gracefully (`SIGINT`)
```bash
trap "echo 'Stopping safely...'; exit" SIGINT

while true; do
    echo "Running task..."
    sleep 1
done
```

Now Ctrl+C **does not kill** the script abruptly.

---

# 📴 7. Handling SSH Disconnect (`SIGHUP`)

If your script runs over SSH and SSH disconnects, script may stop.  
Use:

```bash
trap "echo 'SSH hung up — cleaning'; cleanup" SIGHUP
```

---

# 💥 8. Preventing Unexpected Death (`SIGTERM`)

When Linux or systemd tries to kill script:

```bash
trap "echo 'Termination requested. Cleaning up...'; exit 1" SIGTERM
```

---

# 🏃 9. Background Jobs — (&, jobs, fg, bg)

### Run a command in background
```bash
python3 app.py &
```

### See running background jobs
```bash
jobs
```

### Bring job to foreground
```bash
fg %1
```

### Resume job in background
```bash
bg %1
```

---

# 🔧 10. nohup — Keep Process Alive Even After Logout

Very important on EC2 servers, pipelines, remote clusters.

```bash
nohup python3 app.py &
```

Output goes to:
```
nohup.out
```

Even if you close terminal → **process keeps running**.

Used for:

- long migrations  
- background data import  
- async processors  
- DevOps debugging sessions  

---

# ⏰ 11. Cron Jobs — Linux Task Scheduler

Edit cron with:
```bash
crontab -e
```

---

## Cron Format

```
* * * * * /path/to/script.sh
| | | | |
| | | | +— day of week (0–6)
| | | +—— month (1–12)
| | +——— day of month (1–31)
| +———— hour (0–23)
+————— minute (0–59)
```

---

## Common Cron Examples

### Run script every 5 minutes
```bash
*/5 * * * * /home/ashish/health.sh
```

### Daily backup
```bash
0 2 * * * /home/ashish/db_backup.sh
```

### Clear logs weekly
```bash
0 0 * * 0 rm -rf /var/log/*.gz
```

---

# ⚙️ 12. Real DevOps Automation Examples (Detailed)

---

## ✔ Example 1 — Kill Hanging Process & Log The Event

```bash
#!/bin/bash
trap "echo 'Process killed manually' >> /var/log/proc.log" SIGTERM

pid=$(pgrep python)

if [[ -z "$pid" ]]; then
    echo "No python process running"
else
    kill -9 $pid
    echo "Killed python process $pid"
fi
```

---

## ✔ Example 2 — Auto-Restart Docker If It Fails

```bash
#!/bin/bash
trap "echo 'Docker failed — attempting restart'" EXIT

if ! docker ps >/dev/null; then
    systemctl restart docker
fi
```

---

## ✔ Example 3 — Cleanup Docker Resources Automatically

```bash
#!/bin/bash
set -e

trap "docker system prune -f" EXIT

echo "Running build..."
docker build -t webapp .
```

---

## ✔ Example 4 — Cron + Health Check Script for Nginx

health.sh:
```bash
#!/bin/bash
set -euo pipefail

log="/var/log/health.log"

if ! systemctl is-active --quiet nginx; then
   echo "$(date) — Nginx DOWN" >> $log
   systemctl restart nginx
fi
```

cron entry:
```bash
*/2 * * * * /home/ashish/health.sh
```

---

# 🧰 13. Production Template — The “Resilient Script”

```bash
#!/bin/bash
set -euo pipefail

trap "echo 'Unexpected exit — cleaning'; cleanup" EXIT SIGINT SIGTERM

cleanup() {
    echo "Cleaning temp files..."
    rm -f /tmp/app*
}

main() {
    echo "Doing work..."
    sleep 3
}

main "$@"
```

This pattern =  
**professional-grade scripting.**

---

# 📁 14. Examples Folder Overview

Your examples include:

- signal handlers  
- cleanup automation  
- nohup examples  
- cron jobs  
- service monitors  
- production safety templates  
- real DevOps use-cases  

Available scripts in:

`scripts/`

---

# 🎉 Summary — Part 4 Complete

You now understand:

✔ Linux signals  
✔ trap command  
✔ cleanup handlers  
✔ preventing mid-exit failures  
✔ background jobs  
✔ nohup  
✔ cron scheduling  
✔ automation patterns  
✔ production templates  

This is a MAJOR DevOps milestone — your scripts can now **survive real-world interruptions**.

---
