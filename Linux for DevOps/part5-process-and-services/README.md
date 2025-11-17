# Linux for DevOps — Part 5  
**Process, Job & Service Management**  
_By Ashish — Learn-in-Public DevOps Journey (Week 1)_  
LinkedIn: https://www.linkedin.com/in/ashish360/

---

## 📘 Table of Contents
1. Understanding Linux Processes  
2. `ps` — Process Viewer  
3. `top` / `htop` — Live Monitoring  
4. `pgrep` / `pidof` — Find Processes  
5. `kill` / `pkill` / `killall` — Terminate Processes  
6. `nice` & `renice` — Set CPU Priority  
7. Jobs: `jobs`, `bg`, `fg`  
8. `nohup` — Keep Processes Running After Logout  
9. `systemctl` — Manage Services (Critical for DevOps)  
10. Troubleshooting One-Liners  
11. Next Steps  

---

# ⭐ 1. What is a Process?

A **process** is a running program.  
Every process has:

- **PID** (Process ID)  
- **PPID** (Parent Process ID)  
- **UID** (User ID of owner)  
- **CPU & memory usage**  
- **State** (running, sleeping, zombie)  

Linux process tree (simplified):

```
systemd
 ├── sshd
 ├── docker
 ├── nginx
 └── kubelet
```

You troubleshoot processes during:

- High CPU  
- Memory leaks  
- Crashes  
- Deployment failures  
- Network bottlenecks  

---

# ⭐ 2. `ps` — View Running Processes

---

## 2.1 Basic List
```bash
ps
```

---

## 2.2 Full Details (`-ef`)
```bash
ps -ef
```

---

## 2.3 Detailed Metrics (`aux`)
```bash
ps aux
```

Shows:

- %CPU  
- %MEM  
- TTY  
- Process owner  
- Command  

---

## 2.4 Filter by Name
```bash
ps aux | grep nginx
```

Used constantly during debugging.

---

# ⭐ 3. `top` — Live Process Monitoring

```bash
top
```

Useful keys:
- `P` → sort by CPU  
- `M` → sort by memory  
- `k` → kill process  
- `r` → renice  
- `q` → quit  

---

# ⭐ 4. `htop` — Enhanced `top`

```bash
htop
```

Better UI, colors, graphs.  
May require install:

```bash
sudo apt install htop
```

---

# ⭐ 5. `pgrep` & `pidof` — Finding Processes

---

## 5.1 `pgrep` (by name)
```bash
pgrep nginx
```

---

## 5.2 `pidof` (single PID)
```bash
pidof sshd
```

---

# ⭐ 6. `kill` / `pkill` / `killall`

---

## 6.1 `kill` — Terminate by PID
```bash
kill 1234
kill -9 1234    # force kill (use with caution)
```

---

## 6.2 `pkill` — Kill by Name
```bash
pkill nginx
```

---

## 6.3 `killall` — Kill All of a Command
```bash
killall python
```

---

# ⭐ 7. CPU Priority — `nice` & `renice`

---

## 7.1 `nice` — Start with Priority  
Range: **-20 (high)** to **19 (low)**

```bash
nice -n 10 python script.py
```

---

## 7.2 `renice` — Change Priority of Running Process
```bash
renice -n -5 -p 1234
```

---

# ⭐ 8. Background & Foreground Jobs

---

## 8.1 `jobs` — View Jobs
```bash
jobs
```

---

## 8.2 `bg` — Move Job to Background
```bash
bg %1
```

---

## 8.3 `fg` — Bring Job to Foreground
```bash
fg %1
```

---

# ⭐ 9. `nohup` — Run Commands After Logout

```bash
nohup python server.py &
```

Useful for long-running tasks over SSH.

---

# ⭐ 10. `systemctl` — Manage Services (MOST IMPORTANT)

Systemd service control — critical for DevOps, SRE, CI/CD troubleshooting.

---

## Start service
```bash
sudo systemctl start nginx
```

---

## Stop service
```bash
sudo systemctl stop nginx
```

---

## Restart service
```bash
sudo systemctl restart nginx
```

---

## Check status
```bash
sudo systemctl status nginx
```

---

## Enable service on boot
```bash
sudo systemctl enable docker
```

---

## Disable service
```bash
sudo systemctl disable docker
```

---

# ⭐ 11. Troubleshooting One-Liners

---

### Find top CPU processes
```bash
ps aux --sort=-%cpu | head
```

### Find memory hogs
```bash
ps aux --sort=-%mem | head
```

### Check which process uses a port
```bash
sudo lsof -i :8080
```

### Restart if service is down
```bash
! systemctl is-active --quiet nginx && systemctl restart nginx
```

### Find zombie processes
```bash
ps aux | grep Z
```

### Check load average
```bash
uptime
```

---

# 📌 Next Steps  
Proceed to:  
➡ **Part 6 — System Monitoring & Performance Tools**

---

## Author  
**Ashish — Learn-in-Public DevOps Journey**  
LinkedIn: https://www.linkedin.com/in/ashish360/
