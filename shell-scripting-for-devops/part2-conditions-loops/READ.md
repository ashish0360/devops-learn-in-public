# Shell Scripting for DevOps — Part 2  
**Conditions, Expressions, If/Else, Case, Loops (for / while / until)**  
_By Ashish — Learn-in-Public DevOps Journey (Week 2)_  
🔗 LinkedIn: https://www.linkedin.com/in/ashish360/

---

## 📘 Table of Contents
- Why Logic Matters in DevOps Automation  
- Expressions & Operators (numeric, string, file tests)  
- `if` / `elif` / `else` — Decision making  
- `case` — Menu-driven scripts & multi-choice logic  
- `for` loops — Counting, iterating lists & file sets  
- `while` loops — Polling, waiting, retry logic  
- `until` loops — The inverse loop pattern  
- Functions + Return values + `exit` codes  
- Combining loops & conditions in real tasks  
- Common pitfalls & performance tips  
- Interview problems & practice exercises  
- Examples & scripts (see `examples/` folder)  
- Next: Part 3 — Error Handling & Debugging

---

## 🚀 Why Logic Matters in DevOps Automation
Scripting without logic is just typing commands. Real automation requires decisions:

- Is the service running? If not, restart.  
- Did the deployment succeed? If not, rollback.  
- Are there >90% CPU processes? Alert.  
- Iterate over servers, deploy to each, stop on first failure or continue — you decide.

This chapter gives you the logic layer — the brain of your scripts.

---

## 🧩 Expressions & Operators (Quick Reference)

### Numeric comparisons (use inside `[[ ]]`)
| Operator | Meaning |
|---|---|
| `-eq` | equal |
| `-ne` | not equal |
| `-gt` | greater than |
| `-lt` | less than |
| `-ge` | greater or equal |
| `-le` | less or equal |

Example:
```bash
if [[ $a -gt $b ]]; then
  echo "a greater than b"
fi
```

### String comparisons
```bash
if [[ "$str" == "prod" ]]; then
  echo "Production"
fi

# Pattern match (regex)
if [[ "$line" =~ ^ERROR ]]; then
  echo "Starts with ERROR"
fi
```

### File tests (common)
| Test | Description |
|---|---|
| `-f file` | file exists and is a regular file |
| `-d dir` | directory exists |
| `-r file` | readable |
| `-w file` | writable |
| `-x file` | executable |
| `-s file` | size > 0 |

Example:
```bash
if [[ -f /etc/nginx/nginx.conf ]]; then echo "nginx config present"; fi
```

---

## 🔁 `if` / `elif` / `else` Patterns

### Basic
```bash
if [[ condition ]]; then
  # true block
elif [[ other_condition ]]; then
  # alternative
else
  # fallback
fi
```

### Example — Environment check
```bash
env="$1"
if [[ "$env" == "prod" ]]; then
  echo "Deploying to production"
elif [[ "$env" == "stage" ]]; then
  echo "Deploying to staging"
else
  echo "Unknown environment"
  exit 1
fi
```

---

## 🎛️ `case` — Cleaner menus & multi-value matches
`case` is often easier than long `if` chains — especially for CLI flags or menu input.

```bash
case "$1" in
  start) systemctl start myapp ;;
  stop) systemctl stop myapp ;;
  status) systemctl status myapp ;;
  *) echo "Usage: $0 {start|stop|status}" ; exit 2 ;;
esac
```

`case` supports pattern matching (wildcards), so `dev*` can match `dev1`, `dev2`, etc.

---

## 🔁 `for` Loops — Iterate over lists, files, numbers

### C-style numeric loop (fast & explicit)
```bash
for ((i=1; i<=10; i++)); do
  echo "Num $i"
done
```

### Iterate over words / filenames
```bash
for file in /var/log/*.log; do
  echo "Processing $file"
done
```

### Range generation
```bash
for i in {1..5}; do echo $i; done
```

### Use-cases
- Batch folder creation  
- Iterate over servers in a list  
- Process many files in a folder

---

## 🔄 `while` Loops — Polling & retry logic

### Basic pattern
```bash
count=0
while [[ $count -lt 5 ]]; do
  echo "Try $count"
  ((count++))
done
```

### Polling example — wait for service to be active
```bash
until systemctl is-active --quiet myservice; do
  echo "Waiting for myservice..."
  sleep 5
done
echo "Service is active"
```

### Retry pattern with timeout
```bash
retries=0
max=5
until command; do
  ((retries++))
  if [[ $retries -ge $max ]]; then
    echo "Failed after $max attempts"; exit 1
  fi
  sleep 2
done
```

---

## ⏳ `until` — run until condition becomes true
`until` is the inverse of `while` — it keeps running while condition is false.

```bash
n=1
until [[ $n -gt 5 ]]; do
  echo "n=$n"
  ((n++))
done
```

Use when readability benefits from a negative condition.

---

## 🧩 Functions, Return Values & Exit Codes

Functions keep code modular:
```bash
check_nginx() {
  if systemctl is-active --quiet nginx; then
    return 0   # success
  else
    return 1   # failure
  fi
}

if check_nginx; then
  echo "nginx OK"
else
  echo "nginx not running"
fi
```

*Tip:* `return` sets function exit status (`$?`). Use `exit` only in main flow when you want to stop entire script.

---

## 🔗 Combining Loops & Conditions — Real Workflows

### Example: Process log files and notify if too many 500s
```bash
for f in /var/log/nginx/*.log; do
  errors=$(grep " 500 " "$f" | wc -l)
  if [[ $errors -gt 10 ]]; then
    echo "High 500s in $f: $errors"
    # send alert, copy file, etc.
  fi
done
```

### Example: Deploy to multiple servers with fail-fast
```bash
servers=("web1" "web2" "web3")
for s in "${servers[@]}"; do
  scp build.tar "$s":/tmp/ || { echo "scp failed to $s"; exit 1; }
  ssh "$s" "sudo systemctl restart myapp" || { echo "restart failed on $s"; exit 1; }
done
```

---

## ⚠️ Common Pitfalls & Best Practices
- Use `[[ ]]` for safer tests (no word-splitting).  
- Quote variables: `"$var"` to avoid globbing and word-splitting.  
- Prefer arrays for server lists: `arr=(a b c)` then `${arr[@]}`.  
- Avoid parsing `ps` output with `awk` when `pgrep`/`pidof` exist.  
- Don't use `for file in $(ls *.log)` — use `for file in *.log` instead.  
- Use `set -euo pipefail` in scripts that will run in CI/production.

---

## 🧪 Interview Practice Problems (with hints)
1. Print Fibonacci sequence up to N. *(Use loop and arithmetic)*  
2. Reverse the lines of a file. *(Hint: `tac` or `awk`/`sed`)*  
3. Monitor a log file and print lines that match a keyword in real time. *(Hint: `tail -f | grep --line-buffered`)*  
4. Read CSV and print 3rd column. *(Hint: `awk -F, '{print $3}'`)*  
5. Write a script to check open TCP ports on localhost from 1..65535 and print first 10 open. *(Hint: use `nc` in loops but be mindful of speed)*

---

## 🧾 Examples & Scripts
Copy the files in `examples/` into this folder. Every example is commented and shows what each command does.

---

## ✅ Summary — Part 2 Complete
You now understand the full logic layer:

- Conditionals (numeric, string & file tests)  
- `if` / `case` / `for` / `while` / `until` patterns  
- How to combine tests and loops into real automation workflows  
- Interview-style tasks to practice
