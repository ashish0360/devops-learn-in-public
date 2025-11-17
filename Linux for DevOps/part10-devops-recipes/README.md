# Linux for DevOps — Part 10  
**DevOps Quick Recipes & Troubleshooting Toolkit**  
_By Ashish — Learn-in-Public DevOps Journey (Week 1)_  
LinkedIn: https://www.linkedin.com/in/ashish360/

---

## 📘 Table of Contents
1. On-Call Survival Commands  
2. Log Debugging  
3. Disk Pressure & Out-of-Disk Errors  
4. Network Troubleshooting  
5. CPU & Memory Debugging  
6. Permission Issues  
7. Deployment & CI/CD Helpers  
8. SSH & Connectivity  
9. Docker / Container Debugging  
10. Kubernetes Handy Commands  
11. Ultimate DevOps One-Liners  
12. Next Steps  

---

# ⭐ 1. On-Call Survival Commands

These are the first commands you run during outages.

---

## Check system load
```bash
uptime
```

---

## Top CPU consumers
```bash
ps aux --sort=-%cpu | head
```

---

## Top memory consumers
```bash
ps aux --sort=-%mem | head
```

---

## Free memory
```bash
free -h
```

---

## Real-time memory watch
```bash
watch -n 1 free -h
```

---

# ⭐ 2. Log Debugging (MOST IMPORTANT)

---

## Live logs
```bash
tail -f /var/log/syslog
```

---

## Filter errors
```bash
grep -i "error" /var/log/syslog
```

---

## Filter warnings
```bash
grep -i "warn" app.log
```

---

## Nginx access logs live
```bash
tail -f /var/log/nginx/access.log
```

---

## Only failed requests
```bash
grep " 500 " access.log
```

---

# ⭐ 3. Disk Pressure & “No Space Left on Device”

---

## Check disk usage
```bash
df -h
```

---

## Find biggest directories
```bash
du -sh /* | sort -h | tail
```

---

## Check /var/log usage
```bash
du -sh /var/log/*
```

---

## Find largest files
```bash
find / -type f -exec du -Sh {} + | sort -rh | head -n 20
```

---

## Clean apt cache
```bash
sudo apt autoremove
sudo apt clean
```

---

# ⭐ 4. Network Troubleshooting

---

## Connectivity check
```bash
ping google.com
```

---

## Show system IPs
```bash
ip a
```

---

## DNS resolution
```bash
dig google.com
nslookup google.com
```

---

## Check port usage
```bash
ss -tulnp | grep :80
```

---

## Routing table
```bash
ip route
```

---

# ⭐ 5. CPU & Memory Debugging

---

## CPU usage live
```bash
top
```

---

## Per-core usage
```bash
mpstat -P ALL 1
```

---

## Disk IO pressure
```bash
iostat -xz 1
```

---

# ⭐ 6. Permission Issues

---

## Fix permission denied
```bash
sudo chown -R $USER:$USER /path
```

---

## Give script execute permission
```bash
chmod +x script.sh
```

---

## Check detailed permissions
```bash
ls -l file.txt
```

---

# ⭐ 7. Deployment & CI/CD Helpers

---

## Sync build to server
```bash
rsync -avz build/ user@server:/var/www/app/
```

---

## Copy file to server
```bash
scp -i key.pem file user@server:/path/
```

---

## Restart service
```bash
sudo systemctl restart nginx
```

---

## View service logs
```bash
journalctl -u nginx -f
```

---

# ⭐ 8. SSH & Connectivity

---

## SSH into server
```bash
ssh -i key.pem user@server
```

---

## Test open port
```bash
nc -zv server 443
```

---

## Keep process alive after logout
```bash
nohup command &
```

---

# ⭐ 9. Docker / Container Debugging

---

## Check container logs
```bash
docker logs container
```

---

## Exec into container
```bash
docker exec -it container bash
```

---

## Get container IP
```bash
docker inspect -f '{{ .NetworkSettings.IPAddress }}' container
```

---

## Clean unused images
```bash
docker image prune -f
```

---

# ⭐ 10. Kubernetes Handy Commands (Bonus)

---

## Pod logs
```bash
kubectl logs pod-name
```

---

## Exec into pod
```bash
kubectl exec -it pod -- bash
```

---

## Service endpoints
```bash
kubectl get endpoints service
```

---

## DNS debug inside pod
```bash
kubectl exec -it pod -- nslookup google.com
```

---

## Node resources
```bash
kubectl top node
```

---

# ⭐ 11. Ultimate DevOps One-Liners

---

## Restart service if crashed
```bash
! systemctl is-active --quiet app && systemctl restart app
```

---

## Alert if disk > 90%
```bash
df -h | awk '$5+0 > 90 {print $0}'
```

---

## Top 10 IPs hitting server
```bash
awk '{print $1}' access.log | sort | uniq -c | sort -nr | head
```

---

## Memory hogs
```bash
ps aux --sort -rss | head
```

---

## Find configs containing keyword
```bash
grep -r "password" /etc
```

---

# 📌 Next Steps  
You have completed the **entire Linux for DevOps — Week 1 series**.  
Proceed to Week 2 or start applying these tools in real environments.

---

## Author  
**Ashish — Learn-in-Public DevOps Journey**  
LinkedIn: https://www.linkedin.com/in/ashish360/
