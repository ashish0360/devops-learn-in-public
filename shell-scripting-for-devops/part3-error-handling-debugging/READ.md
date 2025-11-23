# Shell Scripting for DevOps — Part 3  
**Error Handling, Debugging Flags, Exit Codes & Production-Safe Automation**  
_By Ashish — Learn-in-Public DevOps Journey (Week 2)_  
🔗 LinkedIn: https://www.linkedin.com/in/ashish360/

---

# 📘 Table of Contents
- Why Error Handling Matters in DevOps  
- Understanding Exit Codes (`$?`)  
- The “DevOps Trinity”: `set -e`, `set -x`, `set -o pipefail`  
- `set -u` — strict mode for undefined variables  
- Defensive Scripting Patterns  
- Error handling with logical operators (`||`, `&&`)  
- Error handling inside functions  
- Logging patterns (standard output + timestamps)  
- Debugging techniques (partial debugging, trace logging)  
- Real DevOps production scripts  
- Common automation patterns  
- Best practices checklist  
- Examples folder overview  
- Preview: Part 4 — Signals, Trap, Cron, Background Jobs

---

# 🚨 1. Why Error Handling is CRITICAL in DevOps

Let’s be real:

One bad script →  
One silent error →  
One wrong command →  
and you can:

- break deployments  
- delete data  
- restart wrong services  
- spin 100 unwanted EC2 instances  
- cause outages  
- mess up CI pipelines  

So as a DevOps engineer, you **never trust commands blindly**.

Your scripts must be:

✔ Safe  
✔ Predictable  
✔ Fail-fast  
✔ Transparent  

Part 3 is about making your scripts **production-grade**.

---

# 🧯 2. Understanding Exit Codes (`$?`)

Every Linux command returns an exit code:

```
0  = success  
1–255 = failure / error  
```

### Check exit code:
```bash
ls /not_found
echo $?
```

Output:
```
2
```

This means the command failed.

### Real cases where exit codes matter:
✔ AWS CLI fails to create an instance  
✔ Docker image build fails  
✔ Nginx reload fails  
✔ Git clone fails  
✔ Curl API check returns non-200  

If you ignore exit codes → you let failure pass silently → disaster.

---

# ⚙️ 3. The DevOps Safety Trio: `set -e`, `set -x`, `set -o pipefail`

These three flags turn your script from “beginner-level” to “production-ready”.

---

## 🔥 `set -e` — Exit Immediately on Any Error

Without this, commands fail silently.

```
set -e
```

If ANY command fails, script stops immediately.

Perfect for:

- deployments  
- CI/CD  
- provisioning scripts  
- container build scripts  

---

## 🔍 `set -x` — Debug Mode (Print Commands Before Running)

```
set -x
```

Output example:
```
+ echo Hello
+ ls -l
```

This is **line-by-line tracing**, essential for:

- debugging  
- reproducing CI failures  
- catching wrong variables  

---

## 🚫 `set -o pipefail` — Stop if ANY command in pipeline fails

Without pipefail:

```
command1 | command2 | command3
```

If command1 fails, script STILL continues.

With pipefail:

```
set -o pipefail
```

Pipeline must succeed fully.

---

## 💣 Best DevOps Combination (use always):

```
set -euo pipefail
```

Meaning:

| Flag | Meaning |
|------|---------|
| -e | exit on error |
| -u | undefined variables = error |
| -o pipefail | pipeline safety |

**This is the gold standard for production scripts.**

---

# ❗ 4. `set -u` — Catch Undefined Variables

Look at this:

```bash
echo $USERNAME_NOT_SET
```

Silent bug. No error.

But with strict mode:

```
set -u
```

This becomes:

```
unbound variable USERNAME_NOT_SET
```

Prevents stupid mistakes.

---

# 🚧 5. Defensive Scripting Patterns

These patterns make your script safer.

---

## Pattern 1 — Using `||` for manual error capture

```bash
mkdir data || {
  echo "Failed to create directory"
  exit 1
}
```

---

## Pattern 2 — Using a function + return status

```bash
create_dir() {
  mkdir data
}

if ! create_dir; then
   echo "Directory exists — exiting."
   exit 1
fi
```

---

## Pattern 3 — Use `&&` chains when needed

```bash
git pull && echo "Pulled latest code"
```

---

## Pattern 4 — Explicit exit codes

```bash
if [[ ! -f config.yaml ]]; then
   echo "Missing config"
   exit 2
fi
```

---

# 📜 6. Logging Patterns (Very Important in DevOps)

You MUST log everything, especially in automation.

### Basic logging function:
```bash
log() {
    echo "$(date '+%F %T') — $1"
}
```

Usage:
```bash
log "Starting deployment"
log "Installing dependencies"
```

---

# 🐞 7. Debugging Techniques — How Real Engineers Debug

## Technique 1 — Debug only a portion of script

```bash
set -x
docker build -t app .
docker push app
set +x
```

---

## Technique 2 — Debug variable usage

```bash
echo "ENV=$ENV"
echo "PORT=$PORT"
```

---

## Technique 3 — Simulate failures for testing

```bash
false || echo "Simulated failure"
```

---

## Technique 4 — Replace harmful commands with safe ones during testing

Instead of:

```bash
rm -rf /var/log/*
```

Use:

```bash
echo rm -rf /var/log/*
```

This prints command without execution.

---

# 🧨 8. Real DevOps Production Scripts (Expanded)

These are real-world examples used daily in DevOps teams.

---

## 🔥 Example 1 — Safe Directory Creation

```bash
#!/bin/bash
set -euo pipefail

dir="test"

if [[ -d "$dir" ]]; then
  echo "Directory exists"
else
  mkdir "$dir"
  echo "Directory created"
fi
```

---

## 🔥 Example 2 — Process Checker

```bash
count=$(ps -ef | grep nginx | grep -v grep | wc -l)

if [[ $count -ge 1 ]]; then
   echo "Nginx running"
else
   echo "Nginx DOWN — restarting..."
   systemctl restart nginx
fi
```

---

## 🔥 Example 3 — AWS EC2 Creation Script (Production Ready)

```bash
#!/bin/bash
set -euo pipefail

AMI="ami-123456"
TYPE="t2.micro"
KEY="mykey"
SG="sg-123"
SUBNET="subnet-123"

instance_id=$(aws ec2 run-instances \
  --image-id "$AMI" \
  --instance-type "$TYPE" \
  --key-name "$KEY" \
  --security-group-ids "$SG" \
  --subnet-id "$SUBNET" \
  --query "Instances[0].InstanceId" \
  --output text)

echo "Instance created: $instance_id"
```

---

# 🧠 9. Common Automation Patterns

✔ Retry loop  
✔ Dry-run mode  
✔ Validation function  
✔ File backup pattern  
✔ Health check loop  
✔ Error-safe configuration updates  
✔ Deployment pre-checks  

We cover many of these in Part 4 & Part 5.

---

# 📝 10. Best Practices Checklist

| Best Practice | Why |
|---------------|------|
| Always start script with `#!/bin/bash` | defines shell |
| Use `set -euo pipefail` | production safety |
| Always quote variables | avoid globbing/word splitting |
| Validate inputs | avoid null errors |
| Use functions | modular code |
| Use logging | clear debugging |
| Avoid hardcoding secrets | security |
| Use exit codes | CI/CD behaviors depend on them |

---

# 📁 11. Examples Folder Overview

Your examples folder includes:

- exit code examples  
- debugging flags demo  
- safe directory creation  
- safe deployment flow  
- function-based error handling  
- AWS CLI safe script  
- Nginx health checker  
- Django deployment (clean version)  

Each script is fully commented and production-ready.

---

# 🎯 Summary — Part 3 Complete

You now understand:

✔ exit codes  
✔ strict debugging flags  
✔ defensive scripting  
✔ safe automation patterns  
✔ real DevOps production scripts  
✔ modular functions  
✔ logging patterns  
✔ safe AWS/Docker workflows  

This is the exact skill senior DevOps engineers expect from juniors.

---

