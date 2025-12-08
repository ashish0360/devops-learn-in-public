Networking for DevOps and SDLC(Software Development Lifecycle) — The Complete Hands-On Beginner-to-Advanced Guide (Week 3)
Networking for DevOps — Part 1
Networking Foundations for DevOps — Part 1
By Ashish — Learn-in-Public DevOps Journey (Week 3)

Overview
This part gives a rock-solid, practical foundation in networking for DevOps engineers. Every topic below contains:

Definition (what it is),

What it does / why it matters,

When a DevOps engineer uses it,

Practical command examples you can -–paste and run,

Notes / common pitfalls to watch for.

Targets: system/network troubleshooting, cloud networking, container networking, observability, CI/CD connectivity issues, and on-call remediation.

Table of Contents
Network models: OSI vs TCP/IP

Network interfaces, MAC & link layer

IP addresses: IPv4 and IPv6 (definition + examples)

Subnetting & CIDR (step-by-step + worked examples)

Routing basics & default gateway

ARP (Address Resolution Protocol)

NAT (Network Address Translation) — definition & simple examples

TCP vs UDP — ports, sockets & connection states

MTU, fragmentation and common issues

DNS fundamentals (what, how, tools)

DHCP basics (how clients get addresses)

Linux network tools & commands (ip, ss, netstat, traceroute, ping, curl, dig, nslookup) — with examples

Firewalls basics (iptables/nftables, ufw/firewalld) — examples for DevOps

Virtual networking basics (VLANs, bonding/teaming, bridges)

Container & VM networking concepts (bridge, host, macvlan, overlay)

Quick troubleshooting workflows & checklist

1 — Network Models: OSI vs TCP/IP
Definition: conceptual frameworks that describe how network communication is layered.

OSI (7 layers): Physical → Data Link → Network → Transport → Session → Presentation → Application

TCP/IP (4 layers): Link (Network Interface), Internet (IP), Transport (TCP/UDP), Application (HTTP, DNS, etc.)

What it does / why it matters: Layers help you reason: is the problem physical (cable), link (MAC), routing (IP), transport (TCP), or application (HTTP)? DevOps troubleshooting uses layer thinking to isolate faults.

When DevOps uses it: Incident triage: packet loss (link layer), unreachable IP (network layer), TCP hangs (transport), 502 errors (application).

Example (diagnostic approach):

Layer 1: check ip a, ethtool eth0 — link up/down, speed, duplex.

Layer 2: check arp -a — MAC resolution.

Layer 3: check ip route, ping — IP routing.

Layer 4: check ss -tulnp or netstat — TCP/UDP sockets.

Layer 7: curl -I https://service or check application logs.

Notes: You’ll jump between layers during incidents — practice mapping symptoms to layers.

2 — Network Interfaces, MAC & Link Layer
Definition: A network interface (NIC) is the OS representation of a physical or virtual network adapter. A MAC (Media Access Control) address is the hardware address at the link layer.

What it does: NICs transmit/receive frames; the MAC address uniquely identifies an interface on a local link.

When DevOps uses it: Identifying physical/virtual NICs, bonding multiple NICs, diagnosing cable or switch port problems.

Commands / Examples:




# Show interfaces and addresses
ip link show
ip a show eth0

# Show MAC addresses
ip link show eth0 | grep link/ether

# Get low-level link info
ethtool eth0      # (may need package install)
Notes:

Virtual interfaces (docker0, cni0, veth*) also show here.

MACs are used only inside a broadcast domain — routers do not forward MACs.

3 — IP Addresses: IPv4 & IPv6
Definition:

IPv4: 32-bit addresses shown as dotted decimal (e.g., 192.168.1.10).

IPv6: 128-bit addresses shown hex (e.g., 2001:db8::1).

What it does: Identify hosts at the network layer; routing uses IP addresses.

When DevOps uses it: Assigning static IPs, configuring cloud NICs, diagnosing reachability, setting firewall rules.

Examples:


-

-
# Show IP addresses on interfaces
ip -4 addr show        # IPv4
ip -6 addr show        # IPv6

# Add a secondary IP
sudo ip addr add 192.168.100.10/24 dev eth0

# Remove
sudo ip addr del 192.168.100.10/24 dev eth0
Notes:

Use IPv6 in cloud where supported; be mindful of firewall differences.

Public vs private addresses: private ranges (RFC1918): 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16.

4 — Subnetting & CIDR (worked examples)
Definition: Subnetting divides an IP network into smaller networks. CIDR (Classless Inter-Domain Routing) uses suffix /N to denote network prefix length (e.g., /24).

What it does: Controls which hosts are in the same L3 network (subnet); determines routing and broadcast domains.

Why DevOps uses it: Planning VPC subnets, assigning service subnets, calculating IP ranges for clusters, isolating environments.

Quick rules:
/32 = 1 host (IPv4)

/31 = 2 hosts (special)

/30 = 4 addresses (2 usable)

/29 = 8 addresses (6 usable)

/24 = 256 addresses (254 usable)

Usable hosts = total addresses − network − broadcast (for IPv4)

Example 1 — /24 to /26 split (step-by-step)
Start: 192.168.1.0/24 (addresses 192.168.1.0–192.168.1.255)

Split into four /26 subnets (each has 64 addresses, 62 usable):


-

-
192.168.1.0/26     -> 192.168.1.0 - 192.168.1.63   (usable: .1 - .62)
192.168.1.64/26    -> 192.168.1.64 - 192.168.1.127 (usable: .65 - .126)
192.168.1.128/26   -> 192.168.1.128 - 192.168.1.191
192.168.1.192/26   -> 192.168.1.192 - 192.168.1.255
How to calculate binary quick trick:
/26 means 26 ones in netmask: 11111111.11111111.11111111.11000000 -> 255.255.255.192 -> block size 64.

Commands to inspect subnet info:

-

-
# Show routing table and connected networks
ip route show

# Calculate network info (using ipcalc if installed)
ipcalc 192.168.1.10/26
# or use 'sipcalc' if available
Notes:

Always reserve addresses for gateway (.1 or .254) and avoid .0/.255 as hosts in /24.

Cloud consoles often reserve first/last IPs in a subnet — check provider docs (AWS, GCP, Azure).

5 — Routing Basics & Default Gateway
Definition: Routing chooses paths packets follow between networks. A default gateway is the router an IP host sends traffic to when the destination is not on the local subnet.

What it does: Routes forward packets between subnets and to the Internet.

When DevOps uses it: Troubleshooting unreachable hosts, peering VPCs, configuring NAT gateways.

Commands / Examples:


-

-
# Show IP routing table
ip route show

# Typical default route output
# default via 10.0.0.1 dev eth0 proto dhcp metric 100

# Add a route (persistency differs by distro/cloud)
sudo ip route add 10.10.20.0/24 via 192.168.1.1 dev eth0

# Delete route
sudo ip route del 10.10.20.0/24
Notes:

Route priority uses metric; lower metric preferred.

Mistyped routes can blackhole traffic — be careful when scripting route changes.

6 — ARP (Address Resolution Protocol)
Definition: ARP maps IPv4 addresses to MAC addresses on the same broadcast domain.

What it does: When Host A wants to reach 192.168.1.10 in its subnet but only knows the IP, it broadcasts an ARP request; the owner replies with its MAC.

When DevOps uses it: Local network troubleshooting (duplicate IPs, stale ARP entries), debugging NIC problems, Docker overlay issues.

Commands / Examples:


-

-
# Show ARP table
ip neigh show
# or (older)
arp -a

# Example: ping to populate ARP
ping -c 1 192.168.1.10
ip neigh show

# Delete an ARP entry (if stale)
sudo ip neigh del 192.168.1.10 dev eth0
Pitfalls:

ARP spoofing can be a security issue.

Stale ARP entries can happen with VM migration — clear table if necessary.

7 — NAT (Network Address Translation)
Definition: NAT rewrites IP addresses and/or ports of packets crossing a router — common types: SNAT (source NAT) for outbound, DNAT (destination NAT) for inbound.

What it does: Allows multiple private hosts to share a public IP (masquerading), or forwards public traffic to internal hosts (port forwarding).

When DevOps uses it: Internet egress from private subnets, exposing services behind NAT, load balancer + reverse proxy setups.

Simple Linux example (iptables):


-

-
# Masquerade outbound traffic on eth0 (simplified)
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# DNAT: forward port 8080 on gateway to internal 10.0.1.10:80
sudo iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 10.0.1.10:80
sudo iptables -A FORWARD -p tcp -d 10.0.1.10 --dport 80 -j ACCEPT
Notes:

Cloud providers offer managed NAT gateways; prefer them to DIY NAT in production for reliability.

NAT breaks end-to-end IP visibility; use logging and port mapping carefully.

8 — TCP vs UDP — Ports, Sockets & Connection States
Definition:

TCP (Transmission Control Protocol): connection-oriented, reliable, ordered.

UDP (User Datagram Protocol): connectionless, lower overhead, no guarantees.

What it does: TCP for HTTP/HTTPS, SSH, database connections; UDP for DNS, syslog, some streaming.

When DevOps uses it: Choose protocol suitable for service; troubleshoot socket states (SYN, ESTABLISHED, TIME_WAIT).

Commands / Examples:


-

-
# Show listening sockets
ss -tuln        # t: tcp, u: udp, l: listening, n: numeric

# Show connections
ss -tnp         # active tcp connections with process info

# Sample output interpretation:
# LISTEN 0      128    0.0.0.0:22     0.0.0.0:*    users:(("sshd",pid=1234))
Common socket states to know:

LISTEN — waiting for incoming connections

SYN_SENT / SYN_RECV — connection handshake

ESTABLISHED — active connection

TIME_WAIT — waiting to ensure remote side received final ACK (normal after close)

Notes:

Excessive TIME_WAIT may indicate short-lived connections; tune tcp_tw_reuse with caution.

UDP is stateless — troubleshooting needs packet captures (tcpdump).

9 — MTU, Fragmentation & Common Issues
Definition: MTU (Maximum Transmission Unit) is the largest packet size that can be transmitted without fragmentation. Fragmentation occurs when a packet exceeds MTU and is split.

What it does: Correct MTU avoids fragmentation; mismatched MTU causes connectivity issues, especially with VPNs and tunnels.

When DevOps uses it: Troubleshooting slow connections, VPNs, overlay networks (VXLAN/Weave/Flannel), Docker overlay MTU issues.

Commands / Examples:


-

-
# Show MTU
ip link show eth0

# Ping with specific packet size to test MTU (Linux)
ping -M do -s 1472 8.8.8.8   # 1472 + 28 = 1500 (ICMP header = 28)

# Change MTU (temporary)
sudo ip link set dev eth0 mtu 1400
Notes:

Encapsulation (GRE/VXLAN) reduces usable MTU; reduce interface MTU accordingly (e.g., 1450).

ICMP "Fragmentation needed" messages must reach the source for Path MTU Discovery to work — blocked ICMP breaks PMTUD.

10 — DNS Fundamentals
Definition: DNS maps human names (example.com) to IP addresses (A/AAAA records) and other records (CNAME, MX, TXT).

What it does: Allows services to be addressed by names rather than IPs; critical for service discovery.

When DevOps uses it: Configure app domains, validate DNS propagation, troubleshoot name resolution.

Commands / Examples:


-

-
# Query A record
dig +short example.com A

# Full trace
dig +trace example.com

# nslookup interactive
nslookup
> server 8.8.8.8
> example.com

# check TXT or MX
dig example.com TXT
dig example.com MX
Common issues:

Misconfigured TTL causes stale records.

Missing records or wrong zone files cause failures.

Split-horizon DNS (different answers internally vs externally) can confuse troubleshooting.

11 — DHCP Basics
Definition: DHCP dynamically assigns IP addresses and network configuration (gateway, DNS) to clients.

What it does: Simplifies host provisioning and IP management.

When DevOps uses it: Cloud VMs often use DHCP; on-prem hosts and containers may use DHCP; know how DHCP impacts bootstrapping.

Commands / Examples:


-

-
# Check lease file (example for dhclient)
cat /var/lib/dhcp/dhclient.leases

# Force renew (Linux)
sudo dhclient -r eth0
sudo dhclient eth0
Notes:

In cloud environments, metadata services provide more than DHCP (e.g., user data).

Static IPs are preferable for critical services.

12 — Linux Network Tools & Commands (practical)
This is your daily toolkit — - these.

ip (modern replacement for ifconfig/route)

-

-
ip a               # show addresses
ip link show       # show interfaces & state
ip route show      # routing table
ip neigh show      # ARP table
ss / netstat

-

-
ss -tuln           # listening ports
ss -tnp            # tcp connections + processes
netstat -tulnp     # older systems
ping / traceroute / mtr

-

-
ping -c 4 google.com
traceroute google.com
mtr google.com     # real-time traceroute+ping (interactive)
curl / wget

-

-
curl -I https://example.com   # show headers
curl -sS http://api/endpoint | jq '.'
wget https://example.com/file
DNS tools

-

-
dig +short example.com
nslookup example.com 8.8.8.8
Packet capture

-

-
sudo tcpdump -i eth0 port 80 -w capture.pcap
# view live (text)
sudo tcpdump -i eth0 -n -vv
Inspect routing to a host

-

-
ip route get 8.8.8.8
L4 testing

-

-
# test TCP connect to port
nc -vz 10.0.0.5 443   # (netcat)
# test UDP (less reliable)
nc -vu 10.0.0.5 123
Notes:

Use sudo for privileged operations.

tcpdump outputs can be large — filter by host/port.

13 — Firewalls: iptables, nftables, ufw, firewalld
Definition: Firewalls enforce policies for traffic filtering (packet/connection level).

What it does: Allow/deny traffic based on IP, port, interface, state.

When DevOps uses it: Control service exposure, secure nodes, implement port-forwarding.

Simple examples (iptables):


-

-
# Allow incoming SSH
sudo iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

# Allow established/related
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Drop everything else
sudo iptables -P INPUT DROP
nftables (modern):


-

-
sudo nft list ruleset
# add rules via nft syntax (recommended to read docs)
UFW (Ubuntu simple firewall):


-

-
sudo ufw allow 22/tcp
sudo ufw enable
sudo ufw status
firewalld (RHEL/CentOS):


-

-
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --reload
Notes:

Cloud security groups are separate (AWS/GCP/Azure) — ensure both cloud and host firewall rules align.

Incorrect firewall rules can lock you out of remote servers — always keep console access or temporary rules.

14 — Virtual Networking: VLANs, Bonding/Teaming, Bridges
Definition & Use:

VLAN (802.1Q): logical segmentation of a physical network — multiple L2 networks on same cable.

Bonding / Teaming: combine multiple NICs for redundancy or throughput aggregation.

Bridge: L2 device in Linux that forwards frames between interfaces — used for VM/container networking.

When DevOps uses it: Data center network segmentation, high availability NIC setup, container networks.

Examples:


-

-
# create VLAN (example)
sudo ip link add link eth0 name eth0.100 type vlan id 100
sudo ip addr add 192.168.100.10/24 dev eth0.100
sudo ip link set dev eth0.100 up

# show bridges
bridge link
# create bridge (for VMs/containers)
sudo ip link add name br0 type bridge
sudo ip link set dev br0 up
sudo ip link set dev eth0 master br0
Notes:

Bonding modes matter (active-backup vs LACP) — coordinate with switch config.

Bridges are the basis for docker0 and many CNI plugins.

15 — Container & VM Networking (core concepts)
Definition: Containers and VMs use virtual networks — bridge, host, macvlan, overlay.

What it does:

bridge: containers get private NIC on host bridge (NAT to outside).

host: container uses host network namespace (no isolation).

macvlan: container appears as separate L2 device on network.

overlay (VXLAN/Weave): connect containers across hosts (used by Docker Swarm, older Kube CNI plugins).

Why DevOps cares: Troubleshooting pod-to-pod, node-to-node connectivity, Service/Ingress behavior, MTU issues on overlays.

Quick inspect examples:


-

-
# list docker networks
docker network ls
docker network inspect bridge

# check container IP
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_name
Kubernetes pointers (preview):

Pods have network namespace and virtual eth0; kubectl exec + ip a inside pod helps debug.

kubectl get svc, kubectl get endpoints, and kubectl describe svc are essential.

Notes:

Overlay networks often need reduced MTU due to encapsulation.

DNS inside containers: check /etc/resolv.conf in pod/container.

16 — Quick Troubleshooting Workflows & Checklist
When a service or host is unreachable, follow a layered checklist:

Is the interface up?


-

-
 ip link show eth0
 ip a show eth0
Does host have an IP & route to destination?


-

-
 ip addr show
 ip route
 ip route get <dest-ip>
Can you resolve DNS (if name used)?


-

-
 dig +short service.example.com
 nslookup service.example.com
Is the host reachable (ICMP)?


-

-
 ping -c 4 <ip-or-hostname>
If ping fails: try traceroute / mtr.
Is the port listening on the server?


-

-
 ss -tuln | grep :80
Are firewall or security groups blocking?

Check iptables/nft/ufw/firewalld and cloud security groups.
Is NAT/Load Balancer translating correctly?

Review NAT/DNAT rules, ELB/NLB target health.
Packet level check


-

-
 sudo tcpdump -i eth0 host <ip> and port <port>
Check ARP / local broadcast domain


-

-
 ip neigh show
 arp -a
If in containers/k8s: check CNI plugin logs, node routes, kube-proxy status.

Bonus: Small Useful Scripts / One-Liners
Count open connections to a host:


-

-
ss -tn state established '( dport = :443 or sport = :443 )' | wc -l
Show top talkers by bytes (netstat variant):


-

-
sudo ss -tanp | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head
Check for duplicate IPs (ARP)


-

-
arp -a | awk '{print $2}' | sort | uniq -d
Networking for DevOps — Part 2
DNS • Routing • NAT • Tools • Firewalls • Cloud Networking
(With Definitions, Deep Explanations & Real DevOps Examples)
By Ashish — Learn-in-Public DevOps Journey (Week 3)

📘 Table of Contents
1. DNS — Definition + Deep Explanation + Examples

2. Hostnames, resolv.conf & Name Resolution (Definitions + Examples)

3. Routing — Definition, Linux Routing, Cloud Routing

4. NAT — Definition + SNAT + DNAT + Masquerade

5. Firewalls — Definition + Linux + Cloud Firewalls

6. Networking Tools — Definitions + How They Work

7. Real DevOps Debugging Case Studies

8. Cloud Networking Summary (AWS / Azure / GCP)

1️⃣ DNS — Definition, Working & Practical DevOps Usage
📌 Definition: What is DNS?
DNS (Domain Name System) is a global distributed system that translates human-readable names into IP addresses.

Example:


-

-
www.google.com → 142.250.70.14
Without DNS, you would have to type IPs for every site—impossible at scale.

📌 Why DNS Matters for DevOps?
Because every cloud service, microservice, Kubernetes service, API, Git repo, load balancer, and CI/CD tool depends on DNS.

If DNS fails:

Apps fail

API calls fail

Load balancer health checks fail

Containers can’t resolve internal services

CI/CD webhooks break

🔹 How DNS Works (Step-by-Step + Diagram)

-

-
[Client] 
   ↓
[DNS Resolver]  (your ISP / /etc/resolv.conf)
   ↓
[Root Servers]  (.)
   ↓
[TLD Servers]  (.com)
   ↓
[Authoritative DNS]  (Cloudflare, Route53, GoDaddy)
   ↓
Final IP returned
Try checking a domain:


-

-
dig google.com
🔹 Important DNS Records (with Definitions & Examples)
Record	Definition	Example
A	Maps hostname → IPv4	api.app.com → 54.21.11.9
AAAA	Maps hostname → IPv6	app → 2607:f8b0...
CNAME	Alias pointing to another domain	www → app.com
MX	Mail routing	Gmail mail servers
NS	Nameserver for domain	ns1.cloudflare.com
TXT	Text records (SPF, DKIM, verification)	google-verification
SRV	Service discovery	sip.tcp.example.com
🔥 Real DevOps Example — ALB + CNAME
AWS ALB hostname:


-

-
myapp-alb-988.ap-south-1.elb.amazonaws.com
DNS record you create:


-

-
app.example.com → ALB CNAME above
If ALB changes, your app still works.

🔹 DNS Tools (Definitions + Examples)
✔ dig — Definition: DNS query tool
Examples:


-

-
dig linkedin.com
dig +short linkedin.com
dig +trace google.com   # full DNS chain
✔ nslookup — Definition: legacy DNS lookup tool

-

-
nslookup api.service.com
✔ host — Definition: simple reverse & forward DNS lookup

-

-
host google.com
2️⃣ Hostnames, resolv.conf & Name Resolution
📌 Definition: Hostname
A hostname is the human-readable name of a system in a network.

Check:


-

-
hostname
hostnamectl
📌 Definition: /etc/hosts
Local static DNS mapping file.

Example entry:


-

-
10.0.1.40   backend.internal
Now you can run:


-

-
curl http://backend.internal:8080
📌 Definition: resolv.conf
File that tells Linux which DNS servers to use.

Check:


-

-
cat /etc/resolv.conf
Example:


-

-
nameserver 8.8.8.8
nameserver 1.1.1.1
If this file is wrong → DNS will fail.

3️⃣ Routing — Definitions + Linux Routing + Cloud Routing
📌 Definition: Routing
Routing is the process of selecting which path a packet should take to reach its destination.

Every Linux system has a routing table.

✔ View routing table:

-

-
ip route
Example:


-

-
default via 192.168.1.1 dev eth0
10.0.0.0/24 dev eth0 proto kernel
Definition: Default Route
The path used when no specific route exists.

✔ Add route manually (used in hybrid cloud)

-

-
sudo ip route add 172.16.0.0/16 via 10.0.0.1
🔥 Cloud Routing Example (AWS VPC)

-

-
10.0.0.0/16   local
0.0.0.0/0     igw-abc123         # internet access
10.0.2.0/24   nat-xyz987         # private → internet
Definitions:

IGW: Internet Gateway

NAT: Outbound internet for private subnets

4️⃣ NAT — Definitions + SNAT + DNAT + Masquerade
📌 Definition: NAT (Network Address Translation)
Technique to modify IP addresses in packets.

Used for:

internet access

load balancers

proxies

Kubernetes

home routers

🔹 SNAT — Source NAT
Definition: Change source IP before sending to destination.

Used by:

AWS NAT Gateway

GCP Cloud NAT

Example:


-

-
Private: 10.0.1.10 → Public: 44.11.22.33
🔹 DNAT — Destination NAT
Definition: Change destination IP of incoming packets.

Example:


-

-
Public 44.22.13.7:443 → Private 10.0.1.25:443
Used by:

Reverse proxies

Load balancers

Ingress controllers

🔹 Masquerading
Definition: Dynamic SNAT on Linux.


-

-
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
5️⃣ Firewalls — Definitions + Linux + Cloud
📌 Definition: Firewall
A firewall controls which traffic is allowed or blocked.

🔥 Linux Firewall Tools
✔ iptables — packet-level filtering

-

-
sudo iptables -L -n
✔ ufw — simple firewall

-

-
sudo ufw allow 8080
🔥 Cloud Firewalls
AWS
Security Groups (SG): Stateful

NACLs: Stateless

Azure
NSG
GCP
VPC firewall rules
Example rule:


-

-
Allow inbound TCP 22 from 103.94.x.x
6️⃣ Networking Tools — Definitions + Practical Examples
🔸 ping
Definition: ICMP echo tool for basic reachability.


-

-
ping google.com
Checks:

DNS

ICMP

packet loss

latency

🔸 traceroute
Definition: Shows path packets take.


-

-
traceroute youtube.com
🔸 curl
Definition: HTTP client to test APIs and servers.


-

-
curl -I https://example.com
curl -v http://backend:8080/health
🔸 wget
Definition: network downloader


-

-
wget https://example.com/file.zip
🔸 ss
Definition: Shows open ports & sockets (modern netstat).


-

-
ss -tulnp
🔸 ip
Definition: Modern replacement for ifconfig/route.


-

-
ip a
ip link
ip route
🔸 arp
Definition: Maps IP ↔ MAC on local network.


-

-
arp -a
7️⃣ Real DevOps Debugging Scenarios
✔ App cannot reach database
Steps:

1️⃣ DNS


-

-
nslookup db.internal
2️⃣ Connectivity


-

-
ping db.internal
3️⃣ Port


-

-
ss -tulnp | grep 5432
4️⃣ Firewall
Check SG/NSG rules.

✔ Port already in use

-

-
ss -tulnp | grep 8080
kill -9 <PID>
✔ Pod cannot reach internet
Check node DNS:


-

-
cat /etc/resolv.conf
Check routing:


-

-
ip route
8️⃣ Cloud Networking Summary
AWS
VPC

Subnets

Route Tables

IGW

NAT Gateway

Security Groups

NACLs

ALB/NLB

PrivateLink / VPC Endpoints

Azure
VNet

Subnets

NSG

UDR

Application Gateway

Load Balancer

GCP
VPC

Global Subnets

Firewall Rules

Cloud NAT

Cloud Router

Networking for DevOps — Part 3
Load Balancers, VPC Design, Subnets, Kubernetes Networking (Ultra-Detailed)
By Ashish — Learn-in-Public DevOps Journey (Week 3)

Overview
This part covers the backbone of modern cloud networking:

Load Balancers (L4 vs L7)

VPCs (AWS/GCP/Azure)

Subnet types (Public, Private, Database, DMZ)

Routing tables, NAT gateways, Internet gateways

Kubernetes cluster networking (Pod CIDR, Service CIDR, CNI, kube-proxy)

Ingress Controllers (Nginx, Traefik, AWS ALB)

NodePort, ClusterIP, LoadBalancer — everything explained simply

Real diagrams + real DevOps troubleshooting examples

This is one of the most critical parts for DevOps engineers—you’ll use this knowledge daily in cloud, containers, and microservices.

📘 Table of Contents
Load Balancers

Definition

L4 vs L7

Health checks

Sticky sessions

SSL termination

Example in AWS / GCP / Azure

VPC Design for DevOps

What is a VPC?

CIDR selection

Public, private, database subnets

Internet Gateway, NAT Gateway

Route tables

Network ACLs vs Security Groups

Subnets — Deep Dive

Definition

Subnet CIDR design

Public vs Private vs Isolated

Best practices

Kubernetes Networking

Pod CIDR

Service CIDR

CNI (Calico, Flannel, Weave, Cilium)

kube-proxy

Types of Services

ClusterIP

NodePort

LoadBalancer

ExternalName

Ingress

Network Policies

Real DevOps Scenarios

Troubleshooting Checklist

PART 3 — Detailed Content
1. Load Balancers (LB) — Foundation of Modern Distributed Systems
Definition
A Load Balancer distributes incoming traffic across multiple backend servers to ensure:

High availability

Fault tolerance

Scalability

Better performance

Used heavily in microservices, cloud apps, and Kubernetes.

1.1 L4 Load Balancer (Transport Layer Load Balancer)
Definition:
Operates at Layer 4 (TCP/UDP) in the OSI model. It routes traffic only based on IP + Port.

What it does:
It doesn't inspect HTTP headers or URLs — only TCP/UDP ports.

Use Cases:

Database load balancing

TCP services

Game servers

High-speed low-latency systems

Examples:

AWS Network Load Balancer (NLB)

GCP Network TCP Load Balancer

Linux ipvs

Example — AWS NLB:

SSL termination NOT done here

Super low latency

Best for millions of requests per second

1.2 L7 Load Balancer (Application Layer Load Balancer)
Definition:
Operates at Layer 7 (HTTP/HTTPS). It routes traffic by:

Path

URL

Cookies

Host header

HTTP method

What it does:
Understands the HTTP protocol completely.

Use Cases:

Microservices (ex: /api → service A)

Routing based on URL path

Blue/green deployments

Canary releases

Examples:

AWS ALB

GCP HTTP(S) Load Balancer

Nginx / Envoy / HAProxy

Example:


-

-
/ -> frontend
/api -> backend
/auth -> auth-service
1.3 Health Checks
Definition:
Periodic tests by LB to check if backend is healthy.

Types:

TCP health check

HTTP health check

Command-based (K8s probes)

Example (HTTP check):


-

-
GET /health
200 OK → healthy
500 / timeout → unhealthy
1.4 Sticky Sessions (Session Affinity)
Definition:
A feature where LB routes same user to same backend server.

Used for:

Stateful applications

Legacy monoliths

Disabled in modern microservices.

1.5 SSL Termination
Definition:
LB decrypts HTTPS → HTTP between LB & backend.

Benefits:

Offload CPU

Central certificate management

Simpler backend setup

2. VPC Design for DevOps (Cloud Networking Core)
Definition — VPC
A Virtual Private Cloud (VPC) is an isolated virtual network you create inside a cloud provider.

Equivalent to:

Your own data center

Your own IP range

Your own routing, firewall, NAT, internet gateway

2.1 How VPC Works (Simplified Diagram)

-

-
+------------------ VPC (10.0.0.0/16) ------------------+
|                                                       |
|   Public Subnet          Private Subnet               |
|   10.0.1.0/24            10.0.2.0/24                  |
|                                                       |
|  [ EC2 Web ] <--> IGW      [ EC2 App ] <--> NAT GW    |
|                                                       |
+-------------------------------------------------------+
2.2 VPC Components (Definitions + Examples)
✔ CIDR Block
IP range of the VPC
Example:


-

-
10.0.0.0/16 → 65,536 IPs
✔ Subnets
Divide VPC into smaller networks.

✔ Route Table
Decides where traffic flows.

Example:


-

-
0.0.0.0/0 → igw-1234   (public)
0.0.0.0/0 → nat-5678   (private)
✔ Internet Gateway (IGW)
Allows public internet access.

✔ NAT Gateway
Allows outbound internet traffic from private subnets.

✔ Security Groups
Stateful firewalls.

✔ NACLs
Stateless subnet-level firewalls.

3. Subnets — Deep Explanation
Definition — Subnet
A subnet is a smaller network inside a VPC created from a larger CIDR.

Subnet Types
1. Public Subnet
Has route to internet via IGW
Used for:

ALB

Bastion host

Public-facing applications

2. Private Subnet
Outbound only via NAT gateway
Used for:

Application servers

Containers

Microservices

3. Database Subnet
Isolated, no internet
Used for:

RDS

MongoDB

Redis

Elasticsearch

4. DMZ Subnet
Used in highly secure architectures.

Subnet Allocation Example (AWS Best Practice)
Purpose	Subnet	Example CIDR
Public	2 subnets	10.0.1.0/24, 10.0.2.0/24
Private	2 subnets	10.0.3.0/24, 10.0.4.0/24
DB	2 subnets	10.0.5.0/24, 10.0.6.0/24
4. Kubernetes Networking (The Heart of Cloud-Native)
Kubernetes networking is where 90% DevOps engineers struggle.

Let’s make it simple.

4.1 Pod Networking (Pod CIDR)
Definition
Each pod gets its own IP address.

Requirement
Every pod must communicate with every other pod without NAT.
Example Pod CIDR

-

-
10.244.0.0/16 — Flannel
192.168.0.0/16 — Calico
Important Command:

-

-
kubectl exec -it pod -- ip a
4.2 CNI — Container Network Interface
Definition:
Plugin responsible for creating pod networks.

Popular CNIs:
Flannel (simple, overlay)

Calico (L3 routing + Network Policies)

Weave

Cilium (eBPF — fastest)

4.3 Service Networking (Service CIDR)
Definition:
Service abstracts pods behind stable virtual IPs.

Example CIDR:


-

-
10.96.0.0/12  (default in kubeadm)
4.4 kube-proxy
What it does:
Implements service load balancing via:

iptables (older)

ipvs (faster, production-grade)

4.5 Kubernetes Service Types
1. ClusterIP (default)
Only accessible inside the cluster.

Example:


-

-
type: ClusterIP
2. NodePort
Exposes service on each node’s port (30000–32767).

Example:


-

-
type: NodePort
3. LoadBalancer
Cloud LB creates automatically.

Used in AWS/GCP/Azure.

4. ExternalName
DNS CNAME mapping.

4.6 Ingress Controller
Definition:
L7 HTTP reverse proxy inside Kubernetes.

Used for:

Routing /api /auth

SSL termination

Multi-domain hosting

Examples:

NGINX Ingress

Traefik

HAProxy

AWS ALB Ingress Controller

4.7 Network Policies
Definition:
Firewall for pods.

Example:


-

-
Allow only app → db
Deny everything else
5. Real DevOps Scenarios
Scenario 1 — Pod can't reach Internet
Checklist:


-

-
CNI → Node routing → NAT Gateway → Route Table → IGW
Scenario 2 — App behind ALB returning 502
Possible:

Target group health check failing

Wrong security group

Timeout mismatch

Wrong VPC subnet

Scenario 3 — Microservices unable to talk
Check:


-

-
Network policy
Service CIDR
DNS resolution
Pod-to-pod communication
6. Troubleshooting Checklist
Basic:
kubectl get svc

kubectl get ep

kubectl describe svc <name>

kubectl exec -it pod -- curl <svc-ip>:<port>

ss -tulnp

ip route

LB Troubleshooting:
Check target health

Check SG/NACLs

Remove stickiness

Compare timeout values

VPC Troubleshooting:
Validate route tables

Confirm NATGW/IGW attachment

Check overlapping CIDRs

Networking for DevOps — Part 4
Firewalls, Security Groups, NACLs & Zero-Trust (Ultra Detailed, Beginner → Advanced)
By Ashish — Learn-in-Public DevOps Journey (Week 3)

📘 Overview
This part explains the security backbone of cloud networking:

What is a firewall? (simple definition + real examples)

Cloud firewalls vs Linux firewalls

Security Groups (AWS/GCP/Azure) & why they’re stateful

Network ACLs (NACLs) & why they’re stateless

SG vs NACL — clear comparison

Zero-Trust Networks

Bastion Hosts & Jumpboxes

Practical DevOps scenarios

Troubleshooting rules that break production

This section is designed so a complete beginner can understand, AND an advanced DevOps engineer can refine their mental model.

📘 Table of Contents
What is a Firewall? (Definition + Types + Examples)

Linux Firewalls

iptables

nftables

ufw

Cloud Security Groups (AWS/GCP/Azure)

Definition

How they work

Inbound/Outbound rules

Real examples

Network ACLs (NACLs)

Definition

Allow/Deny rules

Stateless behavior

SG vs NACL (Simple Comparison)

Zero-Trust Networking

Bastion Hosts / Jump Servers

Real DevOps Scenarios

Troubleshooting Security Issues Checklist

PART 4 — Full Breakdown
1. What is a Firewall?
Definition:
A firewall is a security system that filters inbound and outbound traffic based on predefined rules.

Simple explanation:

A firewall decides who is allowed in, who can go out, and which ports/protocols are allowed.

1.1 Types of Firewalls
Type	Meaning	Example
Network Firewall	Protects networks	AWS NACLs, Cisco ASA
Host Firewall	Protects a single machine	UFW, iptables
Application Firewall	Filters HTTP apps	WAF, Cloudflare
Cloud Firewalls	Built into cloud providers	Security Groups
1.2 Firewall Example (Real Life)
Imagine a building:

Security Guard = Firewall

ID Check = Authentication

Permission Check = Rules

Servers work the same way.

2. Linux Firewalls (Local Machine Level)
These run inside the server itself.

2.1 iptables (Legacy but widely used)
Definition:
iptables is a Linux firewall tool that filters packets using chains and rules.

Example — Allow SSH

-

-
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
Block everything else:

-

-
iptables -A INPUT -j DROP
View rules:

-

-
iptables -L -n
Used heavily in:

Bare-metal servers

Older Kubernetes nodes

Legacy deployments

2.2 nftables (Modern replacement for iptables)
Definition:
A newer, faster firewall framework that replaces iptables.

View rules:


-

-
nft list ruleset
2.3 UFW (Uncomplicated Firewall) — Ubuntu’s Easy Firewall
Enable:


-

-
sudo ufw enable
Allow SSH:


-

-
sudo ufw allow 22
Allow NGINX:


-

-
sudo ufw allow 'Nginx Full'
Disable:


-

-
sudo ufw disable
Used in Ubuntu servers for quick rule setup.

3. Cloud Security Groups (SGs)
Definition (VERY IMPORTANT):
A Security Group (SG) is a stateful firewall attached to cloud resources like:

EC2 instances

Load Balancers

RDS databases

EKS nodes

Azure VMs

GCP VMs

Stateful = automatically allows return traffic
If inbound rule allows port 80:

Response traffic automatically allowed outbound

No need to create reverse rule

3.1 AWS Security Group Example
Allow inbound HTTP & SSH

-

-
Inbound:
80/tcp → 0.0.0.0/0  
22/tcp → My-IP
Outbound (default allow)

-

-
0.0.0.0/0
3.2 Azure Network Security Group (NSG)
Same concept as AWS SGs, different naming.

3.3 GCP Firewall Rules
GCP uses project-level firewall rules, not instance-level.

3.4 Security Group Use Cases
✔ Allow ALB → EC2

-

-
SG-ALB → SG-EC2: 80
✔ Allow App → Database

-

-
SG-APP → SG-DB: 3306
✔ Allow Bastion → Private EC2

-

-
SG-BASTION → SG-PRIVATE: 22
✔ Block the world, allow private communication

-

-
10.0.0.0/16 only
4. Network ACLs (NACLs) — Subnet Level Firewall
Definition:
A NACL is a stateless firewall that controls traffic at the subnet level.

Stateless = NO automatic return traffic
If you allow inbound 80:
➡ You must manually allow outbound 80.

4.1 NACL Example
Allow HTTP:

-

-
Inbound:
80 ALLOW  
Outbound:
80 ALLOW
Deny everything else:

-

-
Inbound:
* DENY
Outbound:
* DENY
Used for:

Extra protection

Secure subnets

Blocking malicious CIDRs

5. Security Group vs NACL (Simple Chart)
Feature	SG	NACL
Level	Instance	Subnet
Stateful	✔ Yes	✖ No
Default	All deny	All allow
Best use	App-level control	Subnet-level restriction
Supports deny?	No	Yes
Complexity	Simple	More complex
Rule:

Use Security Groups for 90% of cases.
Use NACLs only when you must deny CIDRs or need subnet-wide rules.

6. Zero-Trust Networking — Cloud Security Standard
Definition
Zero-Trust means:

Trust no one, not even internal networks

Every connection must be authenticated

Least privilege access always

No implicit trust even inside VPC

Real applications:

AWS IAM roles

Pod identity in Kubernetes

Service mesh (Istio, Linkerd)

mTLS (mutual TLS)

Zero trust is the future of cloud security.

7. Bastion Hosts (Jump Servers)
Definition:
A server in public subnet used ONLY to SSH into private subnet servers.

Diagram:


-

-
Internet → Bastion Host → Private EC2
Why?

Secure 22/tcp access

No need to expose private instances to public

Can restrict SSH to your IP only

8. Real DevOps Scenarios
✔ Scenario 1 — App not accessible on port 8080
Troubleshooting:

SG inbound 8080 open?

SG outbound allowed?

NACL inbound/outbound both allowed?

App actually listening? (ss -tulnp)

Route table correct?

Service behind LB passing health checks?

✔ Scenario 2 — RDS cannot be accessed from EC2
Check:


-

-
SG-EC2 → SG-RDS : 3306
Same VPC?
Correct subnet routing?
No NACL deny rule?
✔ Scenario 3 — Kubernetes LoadBalancer stuck in “Pending”
Possible issues:

No public subnet tagged

Firewall blocking 30000–32767

Missing cloud controller

NACL blocking ports

✔ Scenario 4 — Private subnet EC2 has no internet
Check:

NAT gateway exists

Route table has 0.0.0.0/0 → NAT

NACL outbound allow

SG outbound allow

9. Troubleshooting Checklist
🔍 For Security Group Issues
Check explicit inbound allow

Check outbound (rare but important)

Check instance-level firewall (iptables)

Check if LB → target mapping exists

🔍 For NACL Issues
Must allow BOTH ways

Look for DENY rules

Confirm correct subnet association

🔍 For Linux host issues

-

-
sudo ss -tulnp
sudo ufw status
sudo iptables -L -n
🔍 For Kubernetes issues

-

-
kubectl describe svc
kubectl describe ingress
kubectl get endpoints
Networking for DevOps — Part 5
Monitoring, Observability & Packet Captures (tcpdump, ss, iperf, Wireshark)
By Ashish — Learn-in-Public DevOps Journey (Week 3)

📘 Overview
In modern DevOps, “networking” isn’t just configuring subnets and IPs — it’s being able to observe, measure, debug, and trace what’s happening inside the network.

This chapter covers the real debugging tools used in Cloud + Linux + Containers + Kubernetes + Production SRE environments:

You will learn:
What observability means in networking

Key metrics: latency, throughput, jitter, RTT, packet loss

Network debugging tools:

ping, traceroute, mtr

ss, netstat

iftop, nload, iperf3

Packet capture tools (tcpdump, tshark, Wireshark)

Deep dive into tcpdump filters with examples

Capturing packets inside containers (Docker/K8s)

Real DevOps troubleshooting scenarios

When to use which tool (flow diagram)

This is a long chapter — but it will make you significantly better than an average DevOps engineer.

📘 Table of Contents
What is Observability in Networking?

Key Network Metrics You Must Understand

Basic Network Monitoring Tools

Real-Time Bandwidth Monitoring Tools

Connection & Socket Monitoring

Packet Captures with tcpdump

Wireshark & tshark (GUI + CLI packet analysis)

Packet Captures Inside Docker & Kubernetes

Real DevOps Troubleshooting Case Studies

Tool Selection Cheat-Sheet

1. What is Observability in Networking?
Definition:
Network observability is the ability to see, measure, and understand network behavior in real-time and retroactively.

Why DevOps needs it:
Diagnose slow applications

Debug API failures

Fix DNS issues

Check load balancer routing

Investigate packet drops

Ensure firewall/NACL rules aren’t blocking traffic

Confirm microservices are communicating properly

Observability tools fall into three categories:

Category	Tools	Purpose
Monitoring	ping, traceroute, netstat, ss	Check status & health
Metrics	iftop, nload, iperf3	Bandwidth, throughput
Packet Capture	tcpdump, Wireshark	Deep inspection
2. Key Network Metrics for DevOps/SRE
These are the fundamentals behind all networking analysis.

2.1 Latency
Time taken for a packet to reach the destination.

Measured using:


-

-
ping google.com
2.2 Packet Loss
% of packets that never reach the server.

In mtr:


-

-
Loss% column
2.3 Jitter
Variation in latency — extremely important for VoIP, video, real-time apps.

2.4 Throughput
Amount of data transferred per second.

Measured using:


-

-
iperf3 -s
iperf3 -c server-ip
2.5 Bandwidth
Maximum theoretical data rate of a network link.

2.6 RTT (Round Trip Time)
Time taken for a request to go and return.

Shown in ping:


-

-
rtt min/avg/max/mdev
3. Basic Network Monitoring Tools (Every DevOps Must Know)
3.1 ping — Latency + Reachability Test
Definition:
Sends ICMP echo requests to test connection and latency.

Example:


-

-
ping google.com
Uses:

DNS test

Reachability test

Basic latency check

3.2 traceroute — Path Trace
Definition:
Shows each hop between you and the target.


-

-
traceroute google.com
3.3 mtr — ping + traceroute combined (best tool)

-

-
mtr google.com
Shows:

Packet loss

Latency per hop

Real-time route changes

Most useful tool for network debugging.

4. Real-Time Bandwidth Monitoring Tools
4.1 iftop — Real-time bandwidth “top”

-

-
sudo iftop
Shows:

Live traffic between IPs

Highest bandwidth users

4.2 nload — Live incoming/outgoing traffic graph

-

-
nload
Great for:

Debugging sudden spikes

Monitoring server saturation

4.3 iperf3 — Network speed testing
Server:


-

-
iperf3 -s
Client:


-

-
iperf3 -c <server-ip>
Useful for:

Testing between cloud regions

Benchmarking VPNs

Validating network throughput

5. Connection & Socket Monitoring
5.1 ss — Modern socket investigation tool
Definition:
Replaces netstat, faster & more detailed.

Show listening ports:


-

-
ss -tulnp
Find process using port:


-

-
ss -tulnp | grep 8080
5.2 netstat — Legacy tool

-

-
netstat -tulnp
Still used in many old systems.

6. Packet Captures with tcpdump (MOST IMPORTANT)
Packet capture = the only way to see exactly what is happening on the wire.

Definition:
tcpdump captures and displays packet-level network traffic.

6.1 Basic Capture
Capture all traffic:


-

-
sudo tcpdump -i eth0
Write to file:


-

-
sudo tcpdump -i eth0 -w capture.pcap
Stop after 100 packets:


-

-
sudo tcpdump -c 100
6.2 Filters (Critical for DevOps)
Capture only HTTP traffic:

-

-
sudo tcpdump -i eth0 port 80
Capture only SSL/TLS (HTTPS):

-

-
sudo tcpdump port 443
Capture specific IP:

-

-
sudo tcpdump host 10.0.1.15
Capture traffic between two hosts:

-

-
sudo tcpdump src 10.0.1.15 and dst 10.0.1.20
Capture DNS traffic:

-

-
sudo tcpdump port 53
Capture only SYN packets (TCP handshake):

-

-
tcpdump 'tcp[tcpflags] & tcp-syn != 0'
6.3 Analyse the pcap file in Wireshark
Open file:


-

-
File → Open → capture.pcap
Wireshark allows inspection of:

HTTP requests

TLS handshakes

DNS queries

Retransmissions

Packet loss

TCP window issues

7. Wireshark & tshark (GUI & CLI)
7.1 Wireshark (GUI)
Used for:

Deep packet inspection

Identifying slow backend services

Seeing encrypted vs unencrypted traffic

Troubleshooting TLS failures

7.2 tshark (CLI version of Wireshark)
Capture DNS traffic:


-

-
tshark -f "port 53"
List available interfaces:


-

-
tshark -D
Filter HTTP requests:


-

-
tshark -Y http
8. Packet Captures in Docker & Kubernetes
8.1 Capture packets in a Docker container
Find container PID:


-

-
pid=$(docker inspect -f '{{.State.Pid}}' container-name)
Capture:


-

-
sudo nsenter -t $pid -n tcpdump -i eth0 -w container.pcap
8.2 Capture packets in Kubernetes Pod
Get pod:


-

-
kubectl get po -A
Exec tcpdump:


-

-
kubectl exec -it pod-name -- tcpdump -i eth0 -w pod.pcap
9. Real DevOps Troubleshooting Case Studies
Case 1: Application is slow
Tools:


-

-
mtr
ss -tulnp
iftop
Check:

Packet loss?

High bandwidth consumption?

Port conflict?

Case 2: DNS Issues
Tools:


-

-
tcpdump port 53
dig +trace domain.com
Symptoms:

Slow API response

Curl fails randomly

Case 3: API unreachable from Kubernetes
Tools:


-

-
kubectl exec -- curl
tcpdump from node
ss -tulnp
Look for:

Firewall rules

Service endpoints missing

Wrong DNS names

Case 4: Load Balancer Health Checks Failing
Tools:


-

-
tcpdump port 80
curl -I localhost
ss -tulnp
10. Tool Selection Cheat-Sheet
Problem	Tool
Slow network	mtr, iftop
Port blocked	ss, tcpdump
API unreachable	curl, tcpdump
DNS issues	dig, tcpdump
Bandwidth high	iftop, nload
TCP handshake failing	tcpdump
Kubernetes network down	kubectl exec, tcpdump
Networking for DevOps — Part 6
SDLC + DevOps Architecture (Ultra-Detailed Week 3 Final Notes)
By Ashish — Learn-in-Public DevOps Journey

📘 Why This Part Matters
As a DevOps engineer, your entire job sits between:

SDLC (Software Development Life Cycle)
→ The complete process of building software from idea → production → maintenance.

DevOps Architecture
→ The tools, pipelines, environments, networks, and automation that turn SDLC into real deployments.

To build, deploy, scale, troubleshoot, and monitor modern cloud systems, you must deeply understand:

What happens in each SDLC stage

Where DevOps fits

How CI/CD automates the flow

How networking connects everything

How cloud-native architecture changes SDLC

How security integrates (DevSecOps)

How SRE extends DevOps in production

This part connects everything from Week 1 (Linux), Week 2 (Shell Scripting), and Week 3 (Networking) into one complete architecture understanding.

📘 Table of Contents
What is SDLC — DevOps Perspective

Waterfall SDLC vs DevOps SDLC

Detailed Breakdown of Each SDLC Phase

DevOps Architecture: Fully Explained

CI/CD Pipeline Architecture (Deep Dive)

Multi-Environment Flow (Dev → Test → Stage → Prod)

GitOps, IaC & Cloud-Native DevOps

DevSecOps (Security in Every Stage)

SRE vs DevOps

End-to-End DevOps Architecture Diagram

Real-World DevOps Pipeline Example

Week 3 Summary + Completion

1. SDLC (Software Development Life Cycle) — DevOps View
📌 Definition
SDLC is the complete roadmap for building and maintaining software.
It defines how software is:

Planned

Developed

Tested

Deployed

Released

Maintained

Traditional SDLC was designed for older systems where deployments happened once every few months.

⚠️ But DevOps changed SDLC completely.
Today companies like Netflix, Amazon, Meta ship hundreds of deployments per day — possible only because SDLC evolved through DevOps.

2. Classical SDLC vs DevOps SDLC
Waterfall SDLC (Old Model)

-

-
Requirements → Design → Coding → Testing → Deployment → Maintenance
Problems:
Dev & Ops are separate

Testing happens too late

Deployments are manual

Feedback comes after weeks/months

No automation

High risk, slow releases

DevOps SDLC (Modern Model)

-

-
PLAN → CODE → BUILD → TEST → RELEASE → DEPLOY → OPERATE → MONITOR → FEEDBACK → PLAN
All stages run continuously and automatically.

Key upgrades:
CI/CD automates build, test, deploy

Cloud infra makes deployments scalable

IaC (Terraform/Ansible) automates infra

Monitoring gives real-time feedback

Dev & Ops collaborate closely

3. Deep Dive: Each SDLC Stage with DevOps Context
Let’s break down each phase the way DevOps teams work in real companies.

3.1 PLAN — Product Requirements + Architecture
Definition:
The stage where teams define what to build and how to design the system.

In DevOps:
DevOps teams participate to:

Define infra needs

Plan environments (Dev/Test/Staging/Prod)

Estimate cloud resources (cost optimization)

Decide CI/CD tools

Decide branching strategy

Plan monitoring & logging

Tools:
Jira

Notion

Confluence

Lucidchart

Example:
A team plans a microservices-based eCommerce backend on AWS using:

EC2 / ECS / Kubernetes

RDS database

S3 storage

CloudFront CDN

Terraform for IaC

Jenkins + GitHub Actions for CI/CD

3.2 CODE — Version Control + Collaboration
Definition:
Writing the source code + storing it in version control.

DevOps Responsibilities:
Set up Git repo

Enforce branch protection

Implement Git branching strategy

GitFlow

Trunk-based development

Code scanning for vulnerabilities

Pre-commit hooks

Tools:
Git

GitHub / GitLab / Bitbucket

Real example:

-

-
feature/login-api → pull request → code review → merge → CI pipeline starts
3.3 BUILD — Compilation + Packaging + Containerization
Definition:
Build takes raw code → converts into executable artifact (binary, jar, image).

DevOps Tasks:
Create Dockerfiles

Optimize build caching

Automate builds in CI

Create repeatable builds

Tools:
Maven, Gradle (Java)

npm/yarn (Node)

Docker

Example:

-

-
docker build -t webshop/auth-service:v2 .
3.4 TEST — Automated Quality Gates
Definition:
Run automated tests on every code change.

DevOps Tasks:
Add test stages to CI

Fail pipeline if tests fail

Run parallel tests

Add security scans

Add code-quality analysis (SonarQube)

Example test types:
Unit Tests

Integration Tests

API Tests

Load testing

Static analysis

3.5 RELEASE — Versioning + Packaging
Definition:
Preparing artifacts to be stored or deployed.

Tools:
Docker Registry

Github Releases

JFrog Artifactory

AWS ECR / GCR / ACR

Example:

-

-
docker push <repo>/auth-service:v2
3.6 DEPLOY — Delivering Software to Cloud/Kubernetes
Definition:
Deploying the artifact to a target environment.

DevOps Responsibilities:
Manage zero-downtime rollouts

Implement deployment strategies

Rolling

Blue/Green

Canary

Database migrations

Infrastructure provisioning

Tools:
Terraform

Ansible

ArgoCD

Jenkins

Kubernetes

Example:

-

-
helm upgrade --install auth-service ./helm-chart
3.7 OPERATE — Running the System in Production
DevOps ensures:

Server uptime

Container orchestration (K8s)

Load balancers

Firewall rules

Auto-scaling

Backup and DR

Tools:
AWS EC2 / ECS / EKS

Azure AKS

GCP GKE

3.8 MONITOR — Observability + Insights
Definition:
Collect performance data + logs + alerts.

DevOps Tasks:
Set SLIs/SLOs

Configure dashboards

Create alert rules

Analyze logs

Find root causes

Tools:
Prometheus

Grafana

Loki

ELK Stack

CloudWatch

Example:

Alert if CPU > 85%

Alert if API latency > 200ms

Alert if pods crash repeatedly

4. DevOps Architecture — Detailed Breakdown
A complete DevOps architecture includes:


-

-
Developer → Git → CI Server → Artifact Registry → CD → Cloud Infra → Monitoring → Feedback
Let's break each:

4.1 Source Code Management (SCM)
GitHub, GitLab

Branching rules

Webhooks

Commit checks

4.2 Continuous Integration (CI)
Triggered on every commit or pull request.
Runs:

Linting

Unit tests

Build

Code scanning

Security scanning

4.3 Artifact Repository
Stores build outputs.

Examples:
ECR (AWS)

GCR (Google)

ACR (Azure)

Nexus

DockerHub

4.4 Continuous Delivery (CD)
Automatically deploys the artifact to environments.

Tools:

Jenkins

ArgoCD

Spinnaker

GitHub Actions

4.5 Observability Layer
Logs

Metrics

Traces

Tools:

ELK

Loki

Prometheus

Jaeger

4.6 Cloud Infrastructure
Compute (EC2, K8s, GKE)

Network (VPC, Subnets, SG, NACL)

Storage (S3/EBS)

LB (ALB/NLB)

5. CI/CD Pipeline Architecture (Deep Explanation)
Diagram:


-

-
GitHub → Jenkins → Unit Tests → Build Docker Image → Push to Registry → Deploy to K8s → Monitor
Detailed Flow:
Developer pushes code → main branch

Webhook triggers Jenkins

Jenkins pipeline starts

Pipeline stages:

Checkout code

Install dependencies

Unit tests

Build

Security scan

Docker build

Push to ECR

Deploy to K8s via Helm

Notify Slack

6. Environments Lifecycle: Dev → Test → Staging → Prod
Each environment serves a different purpose.


-

-
Dev → Test → Staging → Production
Dev:
Developers experiment.

Test:
QA tests feature behavior.

Staging:
Production replica.

Production:
Real users.

DevOps Responsibilities:
Maintain infra differences

Manage secrets per environment

Control release promotion

Enable rollback

7. GitOps + IaC + Cloud-Native DevOps
7.1 GitOps
Git is the single source of truth.
Tools:

ArgoCD

Flux

7.2 IaC (Infrastructure as Code)
Everything is code:

VPC

Subnets

EC2

LB

Security groups

K8s clusters

Tools:

Terraform

CloudFormation

Pulumi

7.3 Cloud-Native DevOps
Built around:

Containers

Kubernetes

Service Mesh

Observability

Auto-scaling

8. DevSecOps — Security Integrated Everywhere
Security now runs inside CI/CD.

SAST — Static Code Scans
DAST — Runtime Testing
Container Image Scanning
Dependency Scanning
Secrets Scanning
Example:


-

-
trivy image backend:v1
9. SRE (Site Reliability Engineering) vs DevOps
DevOps	SRE
Builds automation	Ensures reliability
Pipelines, IaC	Uptime, Error Budgets
Improves speed	Improves stability
Deployments	Incident response
SRE = advanced operational reliability layer on top of DevOps.

10. End-to-End DevOps Architecture Diagram

-

-
                PLAN
         +---------------+
         | Jira/Confluence|
         +---------------+
                 |
                 v
                CODE
         +---------------+
         | GitHub/GitLab |
         +---------------+
                 |
                 v
               BUILD
         +---------------+
         | Jenkins/GHA    |
         +---------------+
                 |
                 v
               TEST
         +----------------+
         | Unit/Integration|
         +----------------+
                 |
                 v
             RELEASE
         +-----------------+
         | Docker Registry |
         +-----------------+
                 |
                 v
              DEPLOY
         +----------------+
         | Terraform/Helm |
         +----------------+
                 |
                 v
              OPERATE
         +-----------------+
         | AWS/K8s/LoadBal |
         +-----------------+
                 |
                 v
             MONITOR
         +-----------------+
         | Grafana/ELK     |
         +-----------------+
                 |
                 v
           FEEDBACK → PLAN
11. Real-World DevOps Pipeline Example (Production Grade)
E-Commerce Backend Deployment (AWS Example)

-

-
GitHub → Jenkins Pipeline → Docker Build → Push to ECR →
Terraform deploys infra → ECS Fargate → ALB → RDS →
CloudWatch Monitoring → PagerDuty Alerts
What DevOps Would Debug:
AWS networking issues → mtr, ss, dig

Container crashes → docker logs, kubectl logs

High latency → check ALB target health, CloudWatch metrics

Autoscaling → HPA or ASG mismatches

DNS failures → Route53 health checks
