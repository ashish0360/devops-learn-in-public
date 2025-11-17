Introduction · Filesystem & Directory Commands

By Ashish — Learn-in-Public DevOps Journey (Week 1)

LinkedIn: https://www.linkedin.com/in/ashish360/

📘 Table of Contents

Why Linux Matters in DevOps

Linux System Architecture (Overview)

Popular Linux Distributions for DevOps

Setting Up Linux (Quick Options)

Package Managers — Quick Summary

Filesystem & Directory Commands — Full Deep Dive

ls, pwd, cd, touch, mkdir, rmdir, rm, cp, mv, cat, tac, head, tail, wc, echo, cut, diff, ln, zcat, which, file

Practical Tips & Dangerous Flags to Avoid

Where to Go Next

Why Linux Matters in DevOps

Linux is the foundation of modern DevOps. Every major cloud provider (AWS, GCP, Azure), container runtime (Docker), orchestration system (Kubernetes), infra tool (Terraform), and automation platform (Ansible) runs on Linux. As a DevOps engineer, you’ll interact with Linux daily — servers, containers, CI runners, build agents — so mastering it is non-negotiable.

Key strengths

Cost-effective: Open source, no licensing fees.

High performance: Lightweight, efficient resource management.

Secure & reliable: Mature permission model, stable long-uptime systems.

Linux System Architecture (Overview)
+----------------------------------------------------+
| User Applications (Docker, Vim, Git, Apache, etc.) |
+----------------------------------------------------+
| Shell (Bash, Zsh, Fish, etc.)                      |
+----------------------------------------------------+
| System Libraries (glibc, OpenSSL, etc.)            |
+----------------------------------------------------+
| System Utilities (ls, grep, ps, systemctl, etc.)   |
+----------------------------------------------------+
| Linux Kernel (Processes, Memory, FS, Network)      |
+----------------------------------------------------+
| Hardware (CPU, RAM, Disk, NICs, Peripherals)       |
+----------------------------------------------------+


Kernel: scheduling, memory, drivers, syscalls.

Shell: user interface to run commands/scripts.

User apps: tools you use daily (Docker, Nginx, Terraform).

Popular Linux Distributions for DevOps

Ubuntu — Beginner friendly, widely used on cloud and desktops.

Debian — Stability-first, conservative releases.

Fedora — Cutting edge packages.

AlmaLinux / Rocky — RHEL-compatible enterprise replacement.

Arch — For advanced users who want control.

Alpine — Extremely light; great for container base images.

Kernel sources: https://git.kernel.org
 · https://github.com/torvalds/linux

Setting Up Linux (Quick Options)

Best method for practice: Use Docker — fast, sandboxed, consistent.

Alternatively: WSL2 on Windows, VirtualBox/VMware with a distro ISO, or native install.
(Commands for setup are environment-specific and covered elsewhere; Part 1 focuses on filesystem commands.)

Package Managers — Quick Summary
Distro family	Package Manager	Example
Ubuntu / Debian	apt	sudo apt install nginx
RHEL / CentOS	dnf / yum	sudo dnf install nginx
Arch	pacman	sudo pacman -S nginx
openSUSE	zypper	sudo zypper install nginx

Common workflow:

sudo apt update
sudo apt upgrade -y
sudo apt install <package>
sudo apt remove <package>
sudo apt autoremove

Filesystem & Directory Commands — Full Deep Dive

Every command below includes: what it does, why DevOps uses it, example(s), and notes/variations.

ls — List files

What: List files and directories.
Why: Inspect deployment folders, logs, mounted volumes.
Examples:

ls -ltr      # long format, newest last (useful to see last modified)
ls -a        # show hidden files
ls -lh       # human readable sizes
ls -R        # recursive

pwd — Print Working Directory

What: Shows absolute path of current dir.
Why: Confirm context before destructive operations.

pwd
# /var/www/app

cd — Change Directory

What: Navigate directories.
Examples:

cd /etc/nginx
cd ~          # home
cd ..         # parent
cd -          # previous directory

touch — Create/Update File Timestamp

What: Create an empty file or update mtime.
Why: Create placeholders, trigger timestamp-based builds.

touch app.log

mkdir — Create Directory

Examples:

mkdir logs
mkdir -p /opt/app/logs   # -p creates parent directories as needed

rmdir — Remove Empty Directory

Note: Only removes empty folders.

rmdir oldfolder

rm — Remove files or directories

Use with extreme care.
Examples:

rm file.txt
rm -r folder/       # recursive
rm -rf /tmp/data     # force + recursive (dangerous)


Danger: Never run rm -rf / or commands you don't fully understand.

cp — Copy files/directories
cp a.txt b.txt
cp -r /var/www /backup

mv — Move or rename
mv config.old config.yaml
mv /tmp/old /var/www/html/

cat — Concatenate / show files
cat /etc/hostname
cat file1 file2 > merged.txt

tac — Show file reversed (last lines first)
tac server.log

head / tail
head -n 20 file.txt
tail -n 20 access.log
tail -f /var/log/syslog   # live logs (very common in DevOps)

wc — Word/line/byte count
wc -l app.log   # number of lines

echo — Print or write text
echo "Hello World"
echo "PORT=8080" > app.env    # overwrite
echo "ENV=prod" >> app.env    # append

cut — Extract columns
cut -d',' -f2 users.csv

diff — Compare two files
diff old.conf new.conf

ln — Create links
ln -s /var/www/html index    # symbolic (soft) link
ln file1 file2               # hard link

zcat — View gzipped content
zcat access.log.gz

**which — Locate executable
**which python3

**file — Identify file type**
file script.sh

**Practical Tips & Dangerous Flags to Avoid**
Always pwd and ls before running destructive commands.
Prefer --dry-run or test scripts on non-production first.
Avoid rm -rf without full path verification; consider rm -rf ./folder vs rm -rf /folder.
Use ls -lh to check sizes in human-readable form — saves time diagnosing disk issues.
Use tail -f during deployments to watch logs live; combine with grep to filter.
Use symbolic links (ln -s) for maintenance-friendly releases (blue/green patterns).
