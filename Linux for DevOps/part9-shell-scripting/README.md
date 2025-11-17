# Linux for DevOps — Part 9  
**Editors, Shell Scripting & Automation**  
_By Ashish — Learn-in-Public DevOps Journey_  
LinkedIn: https://www.linkedin.com/in/ashish360/

---

## 📘 Table of Contents
1. Editors (nano, vim)  
2. Shell Scripting Basics  
3. Variables & Input  
4. Redirections  
5. Conditions (if/else, case)  
6. Loops (for, while, until)  
7. Functions  
8. Exit Codes  
9. Error Handling (`set -e`, `set -x`)  
10. Cron Jobs (Automation)  
11. Real DevOps Automation Scripts  
12. Next Steps  

---

# ⭐ 1. Editors for DevOps

---

## 1.1 `nano` — Simple Editor
```bash
nano app.conf
```
Shortcuts:  
- **Ctrl + O** → Save  
- **Ctrl + X** → Exit  
- **Ctrl + K** → Cut line  
- **Ctrl + U** → Paste  

Used for quick edits in servers/containers.

---

## 1.2 `vim` — The DevOps Standard Editor

Vim is available everywhere → SSH, containers, rescue mode.

### Vim Modes
| Mode | Purpose |
|------|---------|
| Normal | navigation/commands |
| Insert | editing text |
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
0     # start of line  
$     # end of line  
gg    # top  
G     # bottom  
:n    # go to line n
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

# ⭐ 2. Shell Scripting Basics

A shell script is a list of commands executed by the Bash shell.

---

## 2.1 Create Script File
```bash
touch script.sh
chmod +x script.sh
nano script.sh
```

---

## 2.2 Basic Script Structure
```bash
#!/bin/bash
echo "Hello from DevOps"
```

Run it:
```bash
./script.sh
```

---

# ⭐ 3. Variables & Input

## 3.1 Variables
```bash
name="Ashish"
echo "Hello $name"
```

System variables:
```bash
echo $HOME
echo $USER
echo $PATH
```

---

## 3.2 User Input
```bash
read -p "Enter your name: " username
echo "Welcome $username"
```

---

# ⭐ 4. Redirections

Overwrite:
```bash
echo "log entry" > file.txt
```

Append:
```bash
echo "append entry" >> file.txt
```

---

# ⭐ 5. Conditions

---

## 5.1 If-Else
```bash
if [ $age -ge 18 ]; then
   echo "Adult"
else
   echo "Minor"
fi
```

---

## 5.2 File Checks
```bash
if [ -f file.txt ]; then
    echo "File exists"
fi
```

---

## 5.3 Case Statement
```bash
read -p "Choose option: " opt

case $opt in
  1) echo "Start service" ;;
  2) echo "Stop service" ;;
  *) echo "Invalid" ;;
esac
```

---

# ⭐ 6. Loops

---

## 6.1 For Loop
```bash
for i in {1..5}
do
  echo "Number: $i"
done
```

---

## 6.2 While Loop
```bash
count=1
while [ $count -le 5 ]
do
  echo "Loop $count"
  count=$((count+1))
done
```

---

## 6.3 Until Loop
```bash
until [ $n -gt 5 ]
do
  echo "n = $n"
  n=$((n+1))
done
```

---

# ⭐ 7. Functions

```bash
deploy_app() {
    echo "Deploying application..."
}

deploy_app
```

---

# ⭐ 8. Exit Codes

```bash
echo $?     # shows last command exit code
```

- **0 = success**  
- **Non-zero = error**

---

# ⭐ 9. Script Debugging & Error Handling

## 9.1 Print Each Command
```bash
set -x
```

## 9.2 Exit on Error
```bash
set -e
```

## 9.3 Combined
```bash
set -xe
```

Used in CI/CD pipelines.

---

# ⭐ 10. Cron Jobs — Automation

Edit crontab:
```bash
crontab -e
```

Run script daily at midnight:
```
0 0 * * * /home/ashish/backup.sh
```

---

# ⭐ 11. Real DevOps Automation Scripts

---

## 11.1 Cleanup Old Logs
```bash
#!/bin/bash
find /var/log -type f -mtime +7 -delete
```

---

## 11.2 Restart Service If Down
```bash
#!/bin/bash
if ! systemctl is-active --quiet nginx; then
  systemctl restart nginx
fi
```

---

## 11.3 Auto User Creation
```bash
#!/bin/bash
user=$1
sudo useradd -m $user
echo "$user created"
```

---

## 11.4 Copy Build to Server (CI/CD)
```bash
rsync -avz build/ user@server:/var/www/app/
```

---

## 11.5 Database Backup
```bash
#!/bin/bash
mysqldump -u root -p dbname > backup.sql
```

---

# 📌 Next Steps  
Proceed to:  
➡ **Part 10 — DevOps Quick Recipes & Troubleshooting Toolkit**

---

## Author  
**Ashish — Learn-in-Public DevOps Journey**  
LinkedIn: https://www.linkedin.com/in/ashish360/
