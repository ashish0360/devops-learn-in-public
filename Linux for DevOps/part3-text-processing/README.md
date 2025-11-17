# Linux for DevOps — Part 3  
**Text Processing: grep, sed, awk**  
_By Ashish — Learn-in-Public DevOps Journey (Week 1)_  
LinkedIn: https://www.linkedin.com/in/ashish360/

---

## 📘 Table of Contents
1. Why Text Processing Matters in DevOps  
2. `grep` — Pattern Searching  
3. `sed` — Stream Editing  
4. `awk` — Text Extraction, Filters & Reports  
5. Practical DevOps Log Examples  
6. DevOps Automation One-Liners  
7. Next Steps  

---

# ⭐ 1. Why Text Processing Matters in DevOps

DevOps work revolves around reading & analyzing:

- Logs  
- Configs  
- YAML/JSON  
- CI/CD output  
- Kubernetes events  
- System metrics  
- Monitoring alerts  

Three tools dominate Linux text processing:

- **grep** → search patterns  
- **sed** → modify text  
- **awk** → extract, compute, transform  

You will use these every single day.

---

# ⭐ 2. `grep` — Global Regular Expression Print

Search text/patterns inside files or command outputs.

---

## 2.1 Basic Search
```bash
grep "error" app.log
```

Case-insensitive:
```bash
grep -i "error" app.log
```

---

## 2.2 Recursive Search
```bash
grep -r "timeout" /var/log/
```

---

## 2.3 Count Occurrences
```bash
grep -c "404" access.log
```

---

## 2.4 Show Line Numbers
```bash
grep -n "invalid" /var/log/auth.log
```

---

## 2.5 Invert Match (show non-matching)
```bash
grep -v "200" access.log
```

---

## 2.6 Highlight Matches
```bash
grep --color=auto "failed" /var/log/secure
```

---

## 2.7 Filter Processes
```bash
ps aux | grep nginx
```

---

## 2.8 Regex Examples
Ends with `.log`:
```bash
ls | grep "\.log$"
```

Numbers:
```bash
grep -E "[0-9]+" file.txt
```

---

# ⭐ 3. `sed` — Stream Editor

Modify files without opening them.

---

## 3.1 Replace Text (Global)
```bash
sed 's/error/failed/g' app.log
sed 's/error/failed/gi' app.log   # case-insensitive
```

---

## 3.2 Replace Within Line Range
```bash
sed '1,5 s/debug/info/g' log.txt
```

---

## 3.3 Print Only Matching Lines
```bash
sed -n '/timeout/p' server.log
```

---

## 3.4 Show Line Numbers of Matches
```bash
sed -n -e '/error/=' server.log
```

---

## 3.5 Multiple `sed` Operations
```bash
sed -n -e '/error/=' -e '/error/p' logfile
```

---

## 3.6 Delete Matching Lines
```bash
sed '/DEBUG/d' app.log
```

---

## 3.7 Insert a Line Before Match
```bash
sed '/server {/i # Managed by DevOps' nginx.conf
```

---

## 3.8 Inline Edit (Overwrite File)
```bash
sed -i 's/old/new/g' config.yaml
```
⚠ Use with caution — edits file permanently.

---

# ⭐ 4. `awk` — Text Extraction & Reporting

A mini programming language for structured data.

---

## 4.1 Print Columns
```bash
awk '{print $1, $3}' file.txt
```

---

## 4.2 Filter by Pattern + Print Fields
```bash
awk '/error/ {print $2, $5}' app.log
```

---

## 4.3 Count Matching Lines
```bash
awk '/404/ {count++} END {print count}' access.log
```

---

## 4.4 Numerical Conditions
```bash
awk '$2 >= "10.10.11.14" && $2 <= "10.10.11.51" {print $2}' file
```

---

## 4.5 Response Time Filter
```bash
awk '$5 > 500 {print $0}' api.log
```

---

## 4.6 CSV Processing
```bash
awk -F',' '{print $1, $3}' users.csv
```

---

## 4.7 Summation Example
```bash
awk '{sum += $10} END {print sum}' access.log
```

---

# ⭐ 5. Practical DevOps Log Examples

## 5.1 Count 500 Errors
```bash
grep " 500 " access.log | wc -l
```

---

## 5.2 Unique IPs
```bash
awk '{print $1}' access.log | sort | uniq
```

---

## 5.3 Monitor Timeouts
```bash
grep -i "timeout" -r /var/log/
```

---

## 5.4 Replace Env Var in CI/CD
```bash
sed -i 's/ENV=dev/ENV=prod/g' .env
```

---

## 5.5 API Response Time Analysis
```bash
awk '$9 > 400 {print $1, $9}' access.log
```

---

## 5.6 Disk Usage Analysis
```bash
df -h | awk 'NR>1 {print $1, $5}'
```

---

# ⭐ 6. DevOps One-Liner Automations

## Restart service if memory > 90%
```bash
free -m | awk '/Mem/ {if($3/$2*100 > 90) print "Restart needed!"}'
```

---

## Detect high CPU processes
```bash
ps aux | awk '$3 > 50 {print $0}'
```

---

## Validate YAML indentation (CI)
```bash
sed -n '/^[[:space:]]\{2\}[^ ]/p' file.yaml
```

---

## Extract container IDs
```bash
docker ps | grep nginx | awk '{print $1}'
```

---

# 📌 Next Steps  
Proceed to:  
➡ **Part 4 — Users, Groups & Permissions (U/G/O, chmod, chown, special bits)**  

---

## Author  
**Ashish — Learn-in-Public DevOps Journey**  
LinkedIn: https://www.linkedin.com/in/ashish360/
