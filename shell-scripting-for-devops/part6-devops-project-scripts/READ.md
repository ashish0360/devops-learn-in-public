# Shell Scripting for DevOps — Part 6  
**DevOps Project Scripts, AWS Automation, Deployment, Error Handling & CI/CD Integration**  
_By Ashish — Learn-in-Public DevOps Journey (Week 2)_  
🔗 LinkedIn: https://www.linkedin.com/in/ashish360/

---

# 📘 Table of Contents
- Why DevOps Engineers Automate Cloud Tasks  
- AWS CLI Fundamentals  
- Installing AWS CLI via Shell Script  
- Authenticating AWS CLI  
- Writing Cloud-Safe Scripts  
- EC2 Automation (Full Breakdown)  
- EC2 Waiters — Wait Until Running  
- Tagging, Security Groups, Subnets  
- Docker + Nginx Deployment Automation  
- Real Cloud Deployment Script  
- Logging, Retries, Error Handling  
- CI/CD Integration Patterns  
- Production Template  
- Examples Folder Overview  
- Next: Part 7 Preview

---

# ⚡ 1. Why DevOps Engineers Automate Cloud Tasks

In real DevOps work, **manual AWS Console clicks must be replaced with automation**.

Automation gives:

✔ repeatability  
✔ faster deployments  
✔ fewer mistakes  
✔ better disaster recovery  
✔ CI/CD compatibility  
✔ cleaner environments  

As a DevOps engineer, you must automate:

- EC2 creation  
- S3 upload  
- Docker deployments  
- Nginx provisioning  
- log collection  
- health monitoring  

---

# 🧠 2. AWS CLI Fundamentals

AWS CLI is the command-line tool to control AWS using scripts.

Check installation:

```bash
aws --version
```

If not installed → script must handle installation.

---

# 🔑 3. AWS CLI Authentication

Configure once:

```bash
aws configure
```

Requires:

- AWS Access Key  
- AWS Secret Key  
- Region  
- Output format  

**Never** hardcode AWS keys inside scripts.

---

# ⚙️ 4. Installing AWS CLI Automatically

```bash
#!/bin/bash
set -euo pipefail

install_aws_cli() {
    echo "Installing AWS CLI v2..."
    curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    sudo apt-get install -y unzip &>/dev/null
    unzip -q awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip
    aws --version
}

check_aws() {
    if ! command -v aws &>/dev/null; then
        install_aws_cli
    else
        echo "AWS CLI already installed"
    fi
}

check_aws
```

✔ Safe  
✔ Idempotent  
✔ Works across environments  

---

# 🏗️ 5. EC2 Automation — The Real DevOps Flow

```
+-----------------------------+
| create_ec2_instance()       |
+-----------------------------+
              |
              v
+-----------------------------+
| wait_for_instance()         |
+-----------------------------+
              |
              v
+-----------------------------+
| fetch public IP             |
+-----------------------------+
              |
              v
+-----------------------------+
| deploy docker/nginx/app     |
+-----------------------------+
```

This is the pattern used in CI/CD pipelines.

---

# 🚀 6. Create EC2 Instance (Professional Script)

```bash
create_ec2_instance() {
    local ami="$1"
    local type="$2"
    local key="$3"
    local subnet="$4"
    local sg="$5"
    local name="$6"

    instance_id=$(aws ec2 run-instances \
        --image-id "$ami" \
        --instance-type "$type" \
        --key-name "$key" \
        --subnet-id "$subnet" \
        --security-group-ids "$sg" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$name}]" \
        --query 'Instances[0].InstanceId' \
        --output text)

    echo "Instance created: $instance_id"
}
```

---

# ⏳ 7. Wait for EC2 to Become Running

```bash
wait_for_instance() {
    local id="$1"

    echo "Waiting for EC2 instance $id..."

    while true; do
        state=$(aws ec2 describe-instances \
            --instance-ids "$id" \
            --query 'Reservations[0].Instances[0].State.Name' \
            --output text)

        [[ "$state" == "running" ]] && break

        echo "State: $state ...retrying"
        sleep 10
    done

    echo "Instance is running!"
}
```

Prevents CI/CD failures from early execution.

---

# 🌐 8. Get EC2 Public IP

```bash
get_public_ip() {
    aws ec2 describe-instances \
        --instance-ids "$1" \
        --query 'Reservations[0].Instances[0].PublicIpAddress' \
        --output text
}
```

---

# 🐳 9. Docker + Nginx Deployment Script

```bash
#!/bin/bash
set -euo pipefail

log() { echo "$(date) — $1"; }

install_requirements() {
    log "Installing Docker & Nginx..."
    sudo apt-get update
    sudo apt-get install -y docker.io docker-compose nginx
}

configure_docker() {
    log "Fixing Docker socket permissions"
    sudo chown "$USER" /var/run/docker.sock
}

deploy_app() {
    log "Deploying Docker application..."
    docker build -t myapp .
    docker-compose up -d
}

main() {
    install_requirements
    configure_docker
    deploy_app
}

main
```

---

# 📝 10. Django Notes App Deployment (Optimized)

```bash
#!/bin/bash
set -euo pipefail

repo="https://github.com/LondheShubham153/django-notes-app.git"

log(){ echo "$(date) — $1"; }

clone_code() {
    if [[ ! -d django-notes-app ]]; then
        log "Cloning repo..."
        git clone "$repo"
    else
        log "Repo exists — skipping clone."
    fi
}

install_dependencies() {
    log "Installing dependencies..."
    sudo apt-get update
    sudo apt-get install -y docker.io docker-compose nginx
}

deploy() {
    cd django-notes-app
    docker build -t notes-app .
    docker-compose up -d
}

main() {
    log "Starting deployment"
    clone_code
    install_dependencies
    deploy
    log "Deployment complete"
}

main "$@"
```

---

# 🔁 11. Retry Wrapper (Production-Grade)

```bash
retry() {
    local n=1 max=5 delay=5

    until "$@"; do
        if (( n == max )); then
            echo "Command failed after $n attempts"
            return 1
        fi
        echo "Retrying ($n/$max)..."
        ((n++))
        sleep $delay
    done
}
```

Use it in pipelines:

```bash
retry aws s3 ls
```

---

# 🔗 12. CI/CD Integration Patterns

Used in Jenkins, GitHub Actions, GitLab CI, Bitbucket:

- build artifacts  
- config promotions  
- deployment automation  
- health checks  
- docker builds  
- log parsing  

Example: extract version from JSON:

```bash
version=$(grep version package.json | cut -d '"' -f4)
echo "Deploying version: $version"
```

---

# 🧱 13. Production Template — Cloud-Safe Script

```bash
#!/bin/bash
set -euo pipefail

trap "echo 'Unexpected exit — cleaning up'; cleanup" EXIT

cleanup() {
    rm -f /tmp/*.tmp
}

log(){ echo "$(date) — $1"; }

main() {
    log "Starting automation..."
    # Add tasks here
}

main "$@"
```

---

# 📁 14. Examples Folder Overview

```
aws-automation/
  01-install-aws-cli.sh
  02-create-ec2-instance.sh
  03-wait-for-ec2.sh
  04-get-public-ip.sh
  05-ec2-full-provision.sh
  06-docker-nginx-deploy.sh
  07-django-notes-deploy.sh
  08-retry-wrapper.sh
  09-s3-upload.sh
  10-prod-template.sh
```

Scripts are fully commented & cloud-ready.

---

# 🎉 Part 6 Complete — Cloud Automation Achieved

You now understand:

✔ AWS automation  
✔ EC2 provisioning  
✔ Waiters  
✔ Deployment scripting  
✔ Retry logic  
✔ Logging  
✔ CI/CD patterns  
✔ Production-safe templates  

---
