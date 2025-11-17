# Linux for DevOps — Part 6  
**System Monitoring & Performance Tools**  
_By Ashish — Learn-in-Public DevOps Journey (Week 1)_  
LinkedIn: https://www.linkedin.com/in/ashish360/

---

## 📘 Table of Contents
1. Disk Monitoring Tools  
2. Memory Monitoring  
3. CPU & System Performance  
4. Kernel & System Logs  
5. Diagnostics & Utility Tools  
6. Real DevOps Scenarios  
7. Troubleshooting One-Liners  
8. Next Steps  

---

# ⭐ 1. Disk Monitoring Tools

---

## 1.1 `df` — Disk Free Space
```bash
df -h
```
Shows:
- Filesystem  
- Size  
- Used  
- Available  
- Mounted on  

Useful for diagnosing **“No space left on device”** issues.

---

## 1.2 `du` — Directory Space Usage
```bash
du -sh /var/log
```
Flags:
- `-s` summary  
- `-h` human readable  

Identify large folders & logs.

---

## 1.3 `lsblk` — List Block Devices
```bash
lsblk
```

Shows:
- Disks  
- Partitions  
- LVM layout  
- Mount points  

Used heavily after attaching cloud disks (AWS EBS, Azure Disks, GCP PD).

---

## 1.4 `fdisk -l` — Partition Table Info
```bash
sudo fdisk -l
```

Useful for checking:
- MBR/GPT  
- Partition sizes  
- Raw/unformatted disks  

---

## 1.5 `mount` — Mount a Filesystem
```bash
sudo mount /dev/sdb1 /mnt
```

---

## 1.6 `umount` — Unmount Filesystem
```bash
sudo umount /mnt
```

---

# ⭐ 2. Memory Monitoring

---

## 2.1 `free` — Memory Summary
```bash
free -h
```

Shows:
- Total  
- Used  
- Free  
- Buffers/cache  
- Swap  

---

## 2.2 `/proc/meminfo` — Detailed Memory Stats
```bash
cat /proc/meminfo
```
Frequently used in Kubernetes node debugging.

---

## 2.3 `vmstat` — Virtual Memory Statistics
```bash
vmstat 1 5
```

Columns show:
- Processes  
- Memory  
- Swap  
- IO  
- CPU  

Great for debugging memory leaks + CPU wait.

---

# ⭐ 3. CPU & System Performance

---

## 3.1 `uptime` — Load Average
```bash
uptime
```

Load average =  
1min | 5min | 15min load indicators.

---

## 3.2 `mpstat` — Per-CPU Stats
```bash
mpstat -P ALL 1
```
(Install: `sudo apt install sysstat`)

Helps debug CPU throttling or uneven CPU use.

---

## 3.3 `iostat` — Disk IO Performance
```bash
iostat -xz 1
```

Shows:
- Read/write ops  
- IO wait  
- Utilization  

---

# ⭐ 4. Kernel & System Logs

---

## 4.1 `dmesg` — Kernel Messages
```bash
dmesg | tail
```
Used for debugging:
- Disk failures  
- USB issues  
- Kernel crashes  
- Out-of-memory (OOM) events  

---

## 4.2 `journalctl` — Systemd Logs
View service logs:
```bash
journalctl -u nginx
```

Follow logs:
```bash
journalctl -u nginx -f
```

---

# ⭐ 5. Diagnostics & Utility Tools

---

## 5.1 `watch` — Run Command Repeatedly
```bash
watch -n 3 df -h
```

---

## 5.2 `nproc` — Number of CPU Cores
```bash
nproc
```

Used for:
- Nginx worker tuning  
- Docker resource optimization  
- CI/CD parallel builds  

---

# ⭐ 6. Real DevOps Scenarios

---

## 6.1 Disk Full — Find the Culprit
```bash
df -h
du -sh /* | sort -h
du -sh /var/* | sort -h
```

---

## 6.2 High CPU Investigation
```bash
ps aux --sort=-%cpu | head
```

---

## 6.3 Memory Leak Monitoring
```bash
watch -n 1 free -h
```

---

## 6.4 High IO Wait
```bash
iostat -xz 1
```

---

## 6.5 Kernel Disk Errors
```bash
dmesg | grep -i error
```

---

## 6.6 Service Failure Debugging
```bash
systemctl status nginx
journalctl -u nginx -f
```

---

# ⭐ 7. Troubleshooting One-Liners

---

### Check uptime + load  
```bash
uptime
```

### Find failed systemd services  
```bash
systemctl --failed
```

### Identify largest folders  
```bash
du -ah / | sort -h | tail
```

### Check disk type  
```bash
lsblk -f
```

### Check swap usage  
```bash
free -m | grep Swap
```

---

# 📌 Next Steps  
Proceed to:  
➡ **Part 7 — Networking Commands (Complete Practical Guide)**  

---

## Author  
**Ashish — Learn-in-Public DevOps Journey**  
LinkedIn: https://www.linkedin.com/in/ashish360/
