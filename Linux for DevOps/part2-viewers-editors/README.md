# Linux for DevOps — Part 2  
**Viewers, Editors & File Inspection Commands**  
_By Ashish — Learn-in-Public DevOps Journey (Week 1)_  
LinkedIn: https://www.linkedin.com/in/ashish360/

---

## 📘 Table of Contents
1. File Viewing Tools  
2. Redirection & Output Tools  
3. Editors (nano, vim)  
4. Using Editors in DevOps  
5. Next Steps  

---

# ⭐ 1. File Viewing Tools

These commands help inspect logs, configs, scripts — daily tasks for DevOps engineers.

---

## 1.1 `cat` — Display File Content
```bash
cat /etc/os-release
cat file1 file2 > merged.txt
```

---

## 1.2 `tac` — Reverse File Content
```bash
tac application.log
```

---

## 1.3 `more` — View File Page-by-Page
```bash
more /var/log/syslog
```

---

## 1.4 `less` — Best File Viewer
```bash
less /var/log/auth.log
```
Navigation:
- Up/Down arrows → scroll  
- `G` → end  
- `1G` → top  
- `/keyword` → search  

---

## 1.5 `head` — First Lines
```bash
head -n 20 nginx.conf
```

---

## 1.6 `tail` — Last Lines
```bash
tail -n 20 access.log
```

---

## 1.7 `tail -f` — Live Log Monitoring
```bash
tail -f /var/log/syslog
```

---

## 1.8 `nl` — Numbered Output
```bash
nl index.html
```

---

## 1.9 `od` — Octal/Hex Viewer
```bash
od -c myfile.bin
```

---

## 1.10 `strings` — Extract Text from Binary
```bash
strings /usr/bin/ssh
```

---

## 1.11 `zcat` — View GZipped Files
```bash
zcat nginx-access.log.gz
```

---

# ⭐ 2. Redirection & Output Tools

## 2.1 `echo`
```bash
echo "Hello World"
echo "ENV=prod" > app.env
echo "PORT=8080" >> app.env
```

---

## 2.2 `tee` — Output + Save
```bash
echo "server restarted" | tee /var/log/restart.log
```

---

# ⭐ 3. Editors

---

## 3.1 `nano` — Simple Editor
```bash
nano config.yaml
```

Shortcuts:
- **Ctrl + O** → Save  
- **Ctrl + X** → Exit  
- **Ctrl + K** → Cut  
- **Ctrl + U** → Paste  

---

## 3.2 `vi` / `vim` — Most Important DevOps Editor
Vim is lightweight, available on every server, and essential over SSH.

### Modes
| Mode | Purpose |
|------|---------|
| Normal | navigation, commands |
| Insert | writing text |
| Command | save/quit/search |

Switching:
```
i → insert  
Esc → normal  
: → command  
```

---

### ⭐ VIM COMMAND CHEATSHEET

**Save & Quit**
```
:w
:wq
:q!
```

**Navigation**
```
h j k l  
0  
$  
gg  
G  
:n  
```

**Editing**
```
x  
dd  
yy  
p  
u  
Ctrl+r  
```

**Search**
```
/pattern  
n  
N  
```

---

# ⭐ 4. Using Editors in DevOps

Common tasks:
- Editing `/etc/` configs  
- Modifying `.env` files  
- Fixing shell scripts  
- Updating Dockerfiles, Jenkinsfiles  
- Changing settings inside containers  

Vim is the most-used editor in DevOps & SRE.

---

# 📌 Next Steps

Continue to:  
➡ **Part 3 — Text Processing: grep, awk, sed**

---

## Author
**Ashish — Learn-in-Public DevOps Journey**  
LinkedIn: https://www.linkedin.com/in/ashish360/
