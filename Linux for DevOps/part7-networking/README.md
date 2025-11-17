# Linux for DevOps — Part 7  
**Networking Commands (Complete Practical Guide + Real DevOps Debugging)**  
_By Ashish — Learn-in-Public DevOps Journey (Week 1)_  
LinkedIn: https://www.linkedin.com/in/ashish360/

---

## 📘 Table of Contents
1. Host & System Identity  
2. Network Interfaces & IP Address Tools  
3. Connectivity Testing Tools  
4. DNS Tools  
5. Ports, Sockets & Firewalls  
6. HTTP/HTTPS & API Tools  
7. TCP/UDP Debugging Tools  
8. Routing & ARP Tables  
9. Interface Health & Cable Status  
10. Real DevOps Scenarios  
11. Troubleshooting One-Liners  
12. Next Steps  

---

# ⭐ 1. Host & System Identity

---

## 1.1 `hostname` — Get/Set Hostname
```bash
hostname
sudo hostname server-01
```

---

## 1.2 `hostnamectl` — Full System Identity
```bash
hostnamectl
```

Shows:
- OS  
- Kernel  
- Architecture  
- Machine name  

---

# ⭐ 2. Network Interfaces & IP Address Tools

---

## 2.1 `ip a` — Show IP Addresses (Modern)
```bash
ip a
```
Shows:
- Interfaces  
- IPs  
- MAC addresses  
- Link state  

---

## 2.2 `ifconfig` — Legacy Interface Tool
```bash
ifconfig
```

Still found on older servers or lightweight containers.

---

## 2.3 `iwconfig` — Wireless Config
```bash
iwconfig
```

(Not usually needed in cloud environments.)

---

# ⭐ 3. Connectivity Testing Tools

Critical for debugging network failures.

---

## 3.1 `ping` — Reachability Test
```bash
ping google.com
```

Used for:
- DNS check  
- Latency  
- Packet loss  

---

## 3.2 `traceroute` — Trace Network Hops
```bash
traceroute google.com
```

---

## 3.3 `tracepath` — No Root Required
```bash
tracepath google.com
```

---

## 3.4 `mtr` — Real-Time Ping + Trace
```bash
mtr google.com
```

Used to debug:
- Jitter  
- Packet loss  
- Misconfigured routes  

---

# ⭐ 4. DNS Tools

---

## 4.1 `dig` — Most Powerful DNS Tool
```bash
dig google.com
dig A example.com
dig +trace domain.com
```

---

## 4.2 `nslookup` — Basic DNS Query
```bash
nslookup google.com
```

---

## 4.3 `whois` — Domain Ownership
```bash
whois google.com
```

---

# ⭐ 5. Ports, Sockets & Firewalls

---

## 5.1 `ss` — Modern Socket Tool
```bash
ss -tulnp
```

Flags:
- `t` TCP  
- `u` UDP  
- `l` listening  
- `n` numeric  
- `p` process  

Use-case:  
Check “port already in use” errors.

---

## 5.2 `netstat` — Legacy Socket Tool
```bash
netstat -tulnp
```

---

## 5.3 `nmap` — Port Scanner
```bash
nmap <server-ip>
```

Useful for:
- Open port discovery  
- Firewall validation  
- Security audits  

---

# ⭐ 6. HTTP/HTTPS & API Tools

---

## 6.1 `curl` — API Testing Tool
```bash
curl google.com
curl -I https://example.com
curl -X POST -d "name=ashish" https://api.com
```

Use-cases:
- Debug backend APIs  
- Check SSL/HTTPS  
- Verify load balancer  
- Test domain routing  

---

## 6.2 `wget` — Download Files
```bash
wget https://example.com/file.zip
```

---

# ⭐ 7. TCP/UDP Debugging Tools

---

## 7.1 `telnet` — Test Port Connectivity
```bash
telnet server 443
```

If it connects → port open.

---

## 7.2 `nc` (netcat) — Swiss Army Knife
Check if port open:
```bash
nc -zv server 22
```

Start a listener:
```bash
nc -l 8080
```

Transfer files:
```bash
nc -l 1234 > file.txt
```

---

# ⭐ 8. Routing & ARP Tools

---

## 8.1 `route` — Routing Table (Legacy)
```bash
route -n
```

---

## 8.2 `ip r` — Routing Table (Modern)
```bash
ip route
```

---

## 8.3 `arp` — MAC to IP Mapping
```bash
arp -a
```

Used to debug:
- Duplicate IPs  
- Local network issues  

---

# ⭐ 9. Interface Health & Cable Status

---

## 9.1 `ifplugstatus`
```bash
ifplugstatus
```

Useful for bare-metal or on-prem setups.

---

# ⭐ 10. Real DevOps Scenarios

---

## 10.1 Backend API Reachability
```bash
curl -I http://backend:8080/health
```

---

## 10.2 Debug Kubernetes Pod Networking
Inside Pod:
```bash
curl http://service:8080
nslookup service
```

---

## 10.3 Find Process Blocking Port
```bash
ss -tulnp | grep 8080
```

---

## 10.4 Validate DNS Routing
```bash
dig +trace domain.com
```

---

## 10.5 Test Firewall Rules
```bash
nc -zv server 443
```

---

## 10.6 Diagnose Latency/Jitter
```bash
mtr google.com
```

---

# ⭐ 11. Troubleshooting One-Liners

---

### Check open ports
```bash
ss -tulnp
```

### Check DNS using Google DNS
```bash
dig domain.com @8.8.8.8
```

### Firewall: Check if port blocked
```bash
iptables -L -n | grep 22
```

### List all system IPs
```bash
ip -o -4 addr show | awk '{print $4}'
```

### Check SSL Certificate Expiry
```bash
echo | openssl s_client -servername domain.com -connect domain.com:443 | openssl x509 -noout -dates
```

---

# 📌 Next Steps  
Proceed to:  
➡ **Part 8 — Disk, Filesystem & LVM Management**

---

## Author  
**Ashish — Learn-in-Public DevOps Journey**  
LinkedIn: https://www.linkedin.com/in/ashish360/
