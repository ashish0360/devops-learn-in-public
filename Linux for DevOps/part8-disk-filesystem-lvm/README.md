# Linux for DevOps — Part 8  
**Disk, Filesystem & LVM Management (Complete Guide)**  
_By Ashish — Learn-in-Public DevOps Journey (Week 1)_  
LinkedIn: https://www.linkedin.com/in/ashish360/

---

## 📘 Table of Contents
1. Linux Storage Architecture  
2. Disk Information Commands  
3. Partitioning & Filesystems  
4. LVM (Logical Volume Manager)  
5. Swap Management  
6. Real DevOps Scenarios  
7. Troubleshooting One-Liners  
8. Next Steps  

---

# ⭐ 1. Understanding Linux Storage Architecture

```
+----------------------------+
| Application (Nginx, DBs)  |
+----------------------------+
| Filesystem (ext4, xfs)    |
+----------------------------+
| Logical Volume (LV)       |
+----------------------------+
| Volume Group (VG)         |
+----------------------------+
| Physical Volume (PV)      |
+----------------------------+
| Disk / Cloud Volume       |
+----------------------------+
```

Cloud mapping:

| Provider | Storage |
|----------|---------|
| AWS | EBS Volumes |
| Azure | Managed Disks |
| GCP | Persistent Disks |
| Kubernetes | PV/PVC |

---

# ⭐ 2. Disk Information Commands

---

## 2.1 `lsblk` — List Block Devices
```bash
lsblk
```
Shows:
- Disks  
- Partitions  
- LVM layout  
- Mount points  

---

## 2.2 `fdisk -l` — Partition Table
```bash
sudo fdisk -l
```

Used for:
- Checking raw disks  
- MBR/GPT partitions  
- Cloud disk verification  

---

## 2.3 `blkid` — Filesystem & UUID Info
```bash
blkid
```

Used for `/etc/fstab` entries.

---

## 2.4 `file` — Identify Block File
```bash
file /dev/sdb
```

---

## 2.5 `df -h` — Mounted Filesystems
```bash
df -h
```

---

## 2.6 `du` — Directory Size Usage
```bash
du -sh /var/log
```

---

# ⭐ 3. Partitioning & Filesystems

---

## 3.1 Create Partition — `fdisk`
```bash
sudo fdisk /dev/sdb
```

Important keys inside fdisk:

| Key | Meaning |
|-----|----------|
| n | new partition |
| d | delete |
| p | print table |
| w | write changes |
| q | quit |

After partition:
```bash
lsblk
```

---

## 3.2 Format Partition — `mkfs`
Format ext4:
```bash
sudo mkfs.ext4 /dev/sdb1
```

Format xfs:
```bash
sudo mkfs.xfs /dev/sdb1
```

---

## 3.3 Mount Partition
Temporary:
```bash
sudo mount /dev/sdb1 /mnt
```

Verify:
```bash
df -h | grep /mnt
```

---

## 3.4 Unmount
```bash
sudo umount /mnt
```

---

## 3.5 Permanent Mount — `/etc/fstab`
Add entry:
```
UUID=<disk-uuid>   /data   ext4   defaults   0 2
```

Get UUID:
```bash
blkid
```

---

# ⭐ 4. LVM — Logical Volume Manager  
(Used in production Linux servers)

---

## 4.1 Create Physical Volume (PV)
```bash
sudo pvcreate /dev/sdb
```
Verify:
```bash
pvs
```

---

## 4.2 Create Volume Group (VG)
```bash
sudo vgcreate vg_data /dev/sdb
```
Verify:
```bash
vgs
```

---

## 4.3 Create Logical Volume (LV)
```bash
sudo lvcreate -L 10G -n lv_storage vg_data
```
Verify:
```bash
lvs
```

---

## 4.4 Create Filesystem on LV
```bash
sudo mkfs.ext4 /dev/vg_data/lv_storage
```

---

## 4.5 Mount LV
```bash
sudo mount /dev/vg_data/lv_storage /mnt
```

---

## 4.6 Extend Logical Volume (VERY IMPORTANT)

Extend LV:
```bash
sudo lvextend -L +5G /dev/vg_data/lv_storage
```

Resize filesystem (ext4):
```bash
sudo resize2fs /dev/vg_data/lv_storage
```

Resize xfs:
```bash
sudo xfs_growfs /mnt
```

---

# ⭐ 5. Swap Management

---

## 5.1 Create Swap
```bash
sudo mkswap /dev/sdb2
```

---

## 5.2 Enable Swap
```bash
sudo swapon /dev/sdb2
```

---

## 5.3 Disable Swap
```bash
sudo swapoff /dev/sdb2
```

---

# ⭐ 6. Real DevOps Scenarios

---

## 6.1 Attach & Configure AWS EBS Volume
```bash
lsblk
fdisk /dev/nvme1n1
mkfs.ext4 /dev/nvme1n1p1
mount /dev/nvme1n1p1 /data
```

---

## 6.2 Expand Cloud Disk (AWS/GCP)
Increase disk size → then on Linux:
```bash
sudo growpart /dev/sda 1
sudo resize2fs /dev/sda1
```

---

## 6.3 Expand LVM Volume Live
```bash
pvcreate /dev/sdc
vgextend vg_data /dev/sdc
lvextend -l +100%FREE /dev/vg_data/lv_storage
resize2fs /dev/vg_data/lv_storage
```

---

## 6.4 Find Which Folder Filled Disk
```bash
du -sh /* | sort -h
```

---

## 6.5 Unmount Busy Filesystem
```bash
lsof | grep /mnt
```

---

# ⭐ 7. Troubleshooting One-Liners

### Check disk health
```bash
dmesg | grep sdb
```

### Show only mounted filesystems
```bash
df -h | grep -v tmpfs
```

### Show filesystem types
```bash
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT
```

### Check sector size
```bash
sudo blockdev --getbsz /dev/sdb
```

### Monitor IO wait
```bash
iostat -xz 1
```

---

# 📌 Next Steps  
Proceed to:  
➡ **Part 9 — Editors, Shell Scripting & Automation**

---

## Author  
**Ashish — Learn-in-Public DevOps Journey**  
LinkedIn: https://www.linkedin.com/in/ashish360/
