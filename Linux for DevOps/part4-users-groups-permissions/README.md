# Linux for DevOps — Part 4  
**User, Group & Permission Management**  
_By Ashish — Learn-in-Public DevOps Journey (Week 1)_  
LinkedIn: https://www.linkedin.com/in/ashish360/

---

## 📘 Table of Contents  
1. What Are Users & Groups?  
2. User Management Commands  
3. Group Management  
4. Permission Bits (rwx)  
5. `chmod` — Change Permissions  
6. `chown` — Change Ownership  
7. `chgrp` — Change Group  
8. `umask` — Default Permissions  
9. Special Permissions (SUID, SGID, Sticky Bit)  
10. DevOps Real-World Scenarios  
11. Next Steps  

---

# ⭐ 1. What Are Users & Groups?

Linux security is built around three permission layers:

- **User (owner)** — creator of the file  
- **Group** — team members  
- **Others** — everyone else  

Every file, directory, script, service, or process has:

- Owner  
- Group  
- Permission bits  

DevOps engineers must know:

- Who can run scripts?  
- Who can read logs?  
- Who can restart services?  
- Who can deploy to production servers?  

---

# ⭐ 2. User Management Commands

---

## 2.1 `useradd` — Create User (Low-Level)
```bash
sudo useradd -m ashish
```
Options:
```bash
useradd -s /bin/bash ashish
useradd -d /data ashish
useradd -u 1050 ashish
```

---

## 2.2 `adduser` — Create User (Recommended)
```bash
sudo adduser devopsuser
```

---

## 2.3 `passwd` — Set/Change Password
```bash
sudo passwd ashish
```

---

## 2.4 `userdel` — Delete User
```bash
sudo userdel ashish
sudo userdel -r ashish   # remove home directory
```

---

## 2.5 `su` — Switch User
```bash
su ashish
su -
```

---

## 2.6 `who` — Logged-In Users
```bash
who
```

## 2.7 `whoami` — Current User
```bash
whoami
```

---

## 2.8 `id` — User Identity Info
```bash
id ashish
```

---

# ⭐ 3. Group Management

---

## 3.1 `groupadd` — Create Group
```bash
sudo groupadd devops
```

---

## 3.2 `gpasswd` — Manage Group Members
Add user:
```bash
sudo gpasswd -a ashish devops
```

Remove user:
```bash
sudo gpasswd -d ashish devops
```

Set multiple users:
```bash
sudo gpasswd -m user1,user2 devops
```

---

## 3.3 `groupdel` — Delete Group
```bash
sudo groupdel devops
```

---

# ⭐ 4. Permission Bits (rwx)

Linux permission format example:

```
-rwxr-xr--
```

Breakdown:

| Position | Meaning |
|---------|---------|
| 1 | File type (`-`, `d`, `l`) |
| 2–4 | Owner permissions |
| 5–7 | Group permissions |
| 8–10 | Others permissions |

Permission values:

| Value | Permission |
|-------|------------|
| 4 | read |
| 2 | write |
| 1 | execute |

---

# ⭐ 5. `chmod` — Change Permissions

---

## 5.1 Numeric (Octal) Notation
```bash
chmod 755 script.sh
chmod 644 config.yaml
chmod 700 id_rsa
```

---

## 5.2 Symbolic Notation
```bash
chmod u+x script.sh
chmod g-w config.yaml
chmod o=r file
```

---

# ⭐ 6. `chown` — Change File Owner

Change user + group:
```bash
sudo chown ashish:devops file.txt
```

Change user only:
```bash
sudo chown ashish file.txt
```

Change group only:
```bash
sudo chown :devops file.txt
```

---

# ⭐ 7. `chgrp` — Change Group
```bash
sudo chgrp devops file.txt
```

---

# ⭐ 8. `umask` — Default File Permissions

Show current:
```bash
umask
```

Set default permissions:
```bash
umask 022
```

---

# ⭐ 9. Special Permissions (Advanced)

Used heavily in servers and shared environments.

---

## 9.1 SUID — Run as File Owner
```bash
chmod u+s /usr/bin/passwd
```

Allows normal users to change passwords.

---

## 9.2 SGID — Run as Group or Inherit Group
```bash
chmod g+s /shared
```

Shared team folders use this.

---

## 9.3 Sticky Bit — Protect Files in Shared Folders
```bash
chmod +t /tmp
```

Only owner can delete files.

---

# ⭐ 10. DevOps Use-Cases & Real Scenarios

---

## 10.1 Shared Deployment Folder
```bash
sudo mkdir /var/www/app
sudo chown -R deploy:devops /var/www/app
sudo chmod -R 775 /var/www/app
```

---

## 10.2 CI/CD Permission to Restart Services
```bash
sudo usermod -aG systemd-cgls jenkins
```

---

## 10.3 Make Script Executable
```bash
chmod +x deploy.sh
```

---

## 10.4 Fix Docker Volume Ownership
```bash
sudo chown -R $USER:$USER /var/lib/docker/volumes
```

---

## 10.5 Prevent File Deletion in Shared Projects
```bash
chmod +t /project/shared
```

---

# 📌 Next Steps  
Proceed to:  
➡ **Part 5 — Process, Job & Service Management**

---

## Author  
**Ashish — Learn-in-Public DevOps Journey**  
LinkedIn: https://www.linkedin.com/in/ashish360/
