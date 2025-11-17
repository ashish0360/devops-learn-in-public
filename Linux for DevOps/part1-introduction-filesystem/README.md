# Linux for DevOps — Part 1  
**Introduction · Filesystem & Directory Commands**  
_By Ashish — Learn-in-Public DevOps Journey (Week 1)_  
LinkedIn: https://www.linkedin.com/in/ashish360/

---

## 📘 Table of Contents
1. Why Linux Matters in DevOps  
2. Linux System Architecture (Overview)  
3. Popular Linux Distributions for DevOps  
4. Setting Up Linux (Quick Options)  
5. Package Managers — Quick Summary  
6. Filesystem & Directory Commands — Deep Dive  
7. Practical Tips & Dangerous Flags  
8. Next Steps  

---

## 🚀 Why Linux Matters in DevOps

Linux powers everything in DevOps:

- Cloud servers (AWS, GCP, Azure)  
- Docker containers  
- Kubernetes clusters  
- CI/CD runners  
- System automation  

### Why DevOps Engineers Rely on Linux
- **Cost-Effective** → Free, open-source  
- **High Performance** → Lightweight, efficient  
- **Secure & Stable** → Mature permission model, reliable uptime  

Mastering Linux is unavoidable if you're becoming a DevOps engineer.

---

## 🔧 Linux System Architecture (Simple View)

```
+----------------------------------------------------+
| User Applications (Docker, Vim, Git, Apache, etc.) |
+----------------------------------------------------+
| Shell (Bash, Zsh, Fish, etc.)                      |
+----------------------------------------------------+
| System Libraries (glibc, OpenSSL, etc.)            |
+----------------------------------------------------+
| System Utilities (ls, grep, ps, systemctl, etc.)   |
+----------------------------------------------------+
| Linux Kernel (Processes, Memory, FS, Network)      |
+----------------------------------------------------+
| Hardware (CPU, RAM, Disk, NICs, Peripherals)       |
+----------------------------------------------------+
```

### ✔ Hardware Layer  
Physical components: **CPU**, **RAM**, **storage**, **network cards**.

### ✔ Kernel  
The **brain of Linux**, responsible for:
- process scheduling  
- memory allocation  
- file systems  
- networks  
- drivers  
- system calls  

### ✔ Shell  
Interface between **user** and **kernel**.  
Examples: **Bash**, **Zsh**, **Fish**, **Ksh**.

### ✔ User Applications  
Tools like **Docker**, **Git**, **Terraform**, **Jenkins**, **Nginx**, etc.

---

## 🐧 Popular Linux Distributions for DevOps

- Ubuntu — Most widely used  
- Debian — Stable, production-ready  
- Fedora — Latest packages  
- Rocky/AlmaLinux — Enterprise compatible  
- Alpine — Extremely lightweight  

Kernel source:  
https://git.kernel.org  
https://github.com/torvalds/linux  

---

## 🖥️ Setting Up Linux (Quick Options)

Recommended:
- **Docker** → safest and fastest for practice  
Other options:
- WSL2 (Windows), VirtualBox, VMware, or native installation  

---

## 📦 Package Managers (Quick Summary)

| Distro | Package Manager | Example |
|--------|----------------|---------|
| Ubuntu/Debian | `apt` | `sudo apt install nginx` |
| RHEL/CentOS | `dnf` / `yum` | `sudo dnf install nginx` |
| Arch Linux | `pacman` | `sudo pacman -S nginx` |
| openSUSE | `zypper` | `sudo zypper install nginx` |

Common commands:
```bash
sudo apt update
sudo apt upgrade -y
sudo apt install <package>
sudo apt remove <package>
sudo apt autoremove
```

---

## ⭐ FILESYSTEM & DIRECTORY COMMANDS (FULL DEEP DIVE)

### 6.1 `ls`
```bash
ls -ltr
ls -a
ls -lh
ls -R
```

### 6.2 `pwd`
```bash
pwd
```

### 6.3 `cd`
```bash
cd /etc/nginx
cd ~
cd ..
cd -
```

### 6.4 `touch`
```bash
touch file.txt
```

### 6.5 `mkdir`
```bash
mkdir logs
mkdir -p /opt/app/logs
```

### 6.6 `rmdir`
```bash
rmdir oldfolder
```

### 6.7 `rm`
```bash
rm file.txt
rm -r folder/
rm -rf /tmp/data
```

### 6.8 `cp`
```bash
cp a.txt b.txt
cp -r /var/www /backup
```

### 6.9 `mv`
```bash
mv config.old config.yaml
```

### 6.10 `cat`
```bash
cat /etc/hostname
```

### 6.11 `tac`
```bash
tac server.log
```

### 6.12 `head`
```bash
head -n 20 file.txt
```

### 6.13 `tail`
```bash
tail -n 20 access.log
tail -f /var/log/syslog
```

### 6.14 `wc`
```bash
wc -l app.log
```

### 6.15 `echo`
```bash
echo "Hello"
echo "PORT=8080" > app.env
echo "ENV=prod" >> app.env
```

### 6.16 `cut`
```bash
cut -d',' -f2 users.csv
```

### 6.17 `diff`
```bash
diff old.conf new.conf
```

### 6.18 `ln`
```bash
ln -s /var/www/html index
ln file1 file2
```

### 6.19 `zcat`
```bash
zcat access.log.gz
```

### 6.20 `which`
```bash
which python3
```

### 6.21 `file`
```bash
file script.sh
```

---

## ⚠️ Practical Notes & Dangerous Flags
- Always run `pwd` before using `rm -rf`.  
- Prefer symbolic links for deploys.  
- Use `tail -f` for real-time debugging.  
- Combine with `grep` for filtering logs.  

---

## 📌 Next Steps
Proceed to:  
➡ **Part 2 — Viewers, Editors & File Inspection Commands**

---

## Author
**Ashish — Learn-in-Public DevOps Journey**  
LinkedIn: https://www.linkedin.com/in/ashish360/
