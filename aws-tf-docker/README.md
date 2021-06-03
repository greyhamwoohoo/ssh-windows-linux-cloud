# Terraform up a Linux and Windows box with SSH Linux Daemon Access from Windows
Terraform up a Linux and Windows EC2 box and configure the Windows box with the private SSH Key. 

The Windows Docker Client can drive the Linux Docker Daemon via SSH

## Quick Start
From the terraform folder:

1. Create the Public / Private KeyPair (see below)
2. Either create a terraform.tfvars or modify the variables.tf to include your values
3. terraform init
4. terraform plan
5. ... usual terraform lifecycle

## To create the Public / Private KeyPair
Run the following from the 'terraform' folder to generate the public / private key pair (.pub, .key):

```bash
ssh-keygen.exe -b 2048 -t rsa -f ./ssh-windows-to-linux -N '""' -m PEM -C "the-public-key"
mv ./ssh-windows-to-linux ./ssh-windows-to-linux.key
```

## Connect from the Windows Box to Linux Box
After Terraforming up, RDP to the Windows Box and log in as Administrator. 

```powershell
ssh -o "StrictHostKeyChecking=no" ec2-user@the-public-or-internal-ip-of-the-linux-box
```

Depending on the alignment of the stars, direction of the wind and phase of the moon, you will get a shell to the Linux box. 

## Connect to the Docker Daemon from Windows
After Terraforuming up (and assuming the SSH previously works) we can connect from the Windows Box to the Linux box with:

```powershell
# Add the authenticated host. ie: 
ssh -o "StrictHostKeyChecking=no" ec2-user@the-public-or-internal-ip-of-the-linux-box "docker --version"

# All docker commands are to target this host
$env:DOCKER_HOST="ssh://ec2-user@the-public-or-internal-ip-of-the-linux-box"

# Sanity
docker --version
docker ps
docker pull hello-world
docker run library/hello-world
```

# References
| Description | Link |
| ----------- | ---- |
| Connect to a remote docker host | https://gist.github.com/kekru/4e6d49b4290a4eebc7b597c07eaf61f2 |
