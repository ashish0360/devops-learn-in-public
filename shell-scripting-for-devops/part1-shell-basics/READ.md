# Shell Scripting for DevOps — Part 1  
**The Essentials: Shebang, Shell Types, Syntax, Variables & User Input**  
_By Ashish — Learn in Public DevOps Journey (Week 2)_  
🔗 LinkedIn: https://www.linkedin.com/in/ashish360/

---

# 📘 Table of Contents  
- Why Shell Scripting Matters in DevOps  
- What is a Shell? (bash, sh, dash comparison)  
- Shell Architecture (ASCII Visual Diagram)  
- Shebang (#!) — Why It Matters  
- Running Shell Scripts (All Methods)  
- Basic Syntax Every DevOps Engineer MUST Know  
- Variables (User-defined & System Variables)  
- User Input with `read`  
- Script Arguments ($0, $1, $2…)  
- Debugging & Error Handling Flags  
- Essential DevOps Commands Inside Scripts  
- Real DevOps Use-Cases  
- Summary & Part 2 Preview  

---

# 🚀 1. Why Shell Scripting Matters in DevOps  
Let’s be blunt:  
**You cannot become a DevOps engineer without knowing shell scripting deeply.**

Everyday DevOps tasks rely on shell scripts:

- Deploying applications  
- Installing packages  
- Starting servers  
- Parsing logs  
- Running CI/CD steps  
- Automating AWS/Azure/GCP  
- Managing Docker/K8s  
- Creating backups  
- Monitoring services  

If you master shell scripting →  
You stop being an engineer who clicks buttons,  
and become an engineer who **automates infrastructure.**

---

# 🧠 2. What is a Shell?  
A shell is the program that **interprets your commands**.

Common shells:

| Shell | Path | Notes |
|------|---------|--------|
| `bash` | /bin/bash | DevOps standard (most powerful & common) |
| `sh` | /bin/sh | POSIX shell (mapped to dash in Ubuntu) |
| `dash` | /bin/dash | Very fast, minimal shell |
| `zsh` | /bin/zsh | Popular for interactive usage |
| `fish` | /usr/bin/fish | Friendly interactive shell |

In DevOps, **bash is king**.

---

# 🏗️ 3. Shell Architecture (ASCII Diagram)

```
+------------------------------------------------+
|              User Inputs (Commands)            |
+------------------------------------------------+
                     |
                     v
+------------------------------------------------+
|            Shell (bash, sh, dash)              |
|  - Interprets commands                         |
|  - Expands variables                           |
|  - Executes programs                            |
+------------------------------------------------+
                     |
                     v
+------------------------------------------------+
|             Kernel (System Core)               |
|  - Manages processes                           |
|  - Memory allocation                           |
|  - File systems, networking                    |
+------------------------------------------------+
                     |
                     v
+------------------------------------------------+
|                Hardware Layer                  |
|      CPU | RAM | Disks | NICs | I/O devices    |
+------------------------------------------------+
```

Whenever you type a command:  
User → Shell → Kernel → Hardware.

---

# 🔥 4. The Shebang (#!) — The Very First Line  
Shebang tells the system **which shell** should run the script.

## Most common:
```bash
#!/bin/bash
```

## System-level scripts:
```bash
#!/bin/sh
```

## For POSIX compatibility:
```bash
#!/usr/bin/env bash
```

### Why is the shebang important?
- Different shells behave differently  
- Commands valid in bash may break in sh/dash  
- CI/CD pipelines rely on correct shebang  
- Production scripts must specify interpreter explicitly  

Never skip shebang in DevOps work.

---

# ▶️ 5. How to Run a Shell Script  

## Step 1: Create a file
```bash
touch script.sh
```

## Step 2: Add shebang
```bash
#!/bin/bash
echo "Hello DevOps"
```

## Step 3: Give execution permission
```bash
chmod +x script.sh
```

## Step 4: Run the script
### Method 1 — Direct execution
```bash
./script.sh
```

### Method 2 — Using shell name
```bash
bash script.sh
```

### Method 3 — POSIX-compatible run
```bash
sh script.sh
```

**Note:**  
If the script uses bashism (like `[[ ]]`), `sh script.sh` will fail.

---

# 📝 6. Basic Syntax Every DevOps Engineer Must Know  

## Printing outputs
```bash
echo "Hello DevOps"
```

## Single-line comment
```bash
# This is a shell script
```

## Block comment
```bash
<<COMMENT
This is a 
multi-line
comment
COMMENT
```

## Command substitution
```bash
DATE=$(date)
echo "Today is $DATE"
```

---

# 🧩 7. Variables  

## User-defined variables
```bash
name="Ashish"
echo "Welcome $name"
```

➡ Variables **must not** have spaces around `=`  
Incorrect: `name = "Ashish"`

## System Variables (Predefined)
```bash
echo $HOME
echo $USER
echo $SHELL
echo $PWD
echo $PATH
```

## Arithmetic
```bash
count=$((10 + 5))
echo $count
```

---

# 🔡 8. Reading User Input — `read`  
Interactive scripts are powerful for DevOps menus.

```bash
read -p "Enter your project name: " project
echo "Project: $project"
```

### With silent input (passwords):
```bash
read -s -p "Enter password: " pass
```

---

# 🎯 9. Script Arguments ($0, $1, $2 …)

Run:
```bash
./deploy.sh prod v2
```

Inside script:
```bash
echo "Script name: $0"
echo "Env: $1"
echo "Version: $2"
```

Use cases:
- Deploy to different environments  
- Pass resource names  
- Use in CI/CD pipelines  
- AWS automation (AMI, subnet, instance-type inputs)  

---

# 🐞 10. Debugging & Error Handling Flags  

These flags instantly level-up your DevOps scripts:

## Print commands as they run
```bash
set -x
```

## Exit immediately on any error
```bash
set -e
```

## Pipeline safety
```bash
set -o pipefail
```

## DevOps Gold Standard
```bash
set -exo pipefail
```

This saves you from silent failures—that’s how production outages are prevented.

---

# 🛠 11. Essential Commands DevOps Engineers Use Daily  

### Process management  
```bash
ps -ef
ps -ef | grep nginx
```

### API calls  
```bash
curl -I https://google.com
```

### File search  
```bash
find / -name "*.log"
```

### Text extraction  
```bash
grep -i "error" app.log
awk '{print $1}' access.log
```

These form the foundation of all automation.

---

# 🧵 12. Real DevOps Use Cases  

## Use Case 1 — Restart Nginx if Down  
```bash
if ! systemctl is-active --quiet nginx; then
    echo "Nginx DOWN — restarting..."
    systemctl restart nginx
fi
```

## Use Case 2 — Create multiple folders  
```bash
for i in {1..10}; do
    mkdir "log$i"
done
```

## Use Case 3 — Validate user input  
```bash
if [[ -z "$1" ]]; then
    echo "ERROR: Pass environment (dev/prod)"
    exit 1
fi
```

## Use Case 4 — Backup config  
```bash
cp /etc/nginx/nginx.conf backup.conf
```

---

# 🎉 Summary — Part 1 Complete  
You now understand:

✔ What a shell is and why bash is preferred  
✔ How the shell interacts with kernel & hardware  
✔ Shebang and script execution  
✔ Syntax, variables, arguments  
✔ Reading user input  
✔ Debugging flags  
✔ Core DevOps commands  

You now have the foundation needed for real automation.

---
