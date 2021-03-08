# Terraform up a Linux and Windows box 
Terraform up a Linux and Windows EC2 box and clones a Github repo (using a Github Deploy Key). 

STATUS: Windows Box (done); Linux Box (Todo)

Also configures the Windows box with the private SSH Key; see aws-tf for more information. 

## Quick Start
From the terraform folder:

1. Create the Github Deploy Key (see below)
2. Create the Public / Private KeyPair (see below)
3. Either create a terraform.tfvars or modify the variables.tf to include your values
4. terraform init
5. terraform plan
6. ... usual terraform lifecycle

## To create the Github Deploy Key
Terraform will bootstrap both boxes with the Github Deploy Key and clone the repo. 

You must create a Github Deploy Key for a private repository and add the private key called 'github-deploy-key.pem' to each host. 

See variables.tf for more information. 

## To create the Public / Private KeyPair
Run the following from the 'terraform' folder to generate the SSH public / private key pair:

```bash
ssh-keygen.exe -b 2048 -t rsa -f ./ssh-windows-to-linux -N '""' -m PEM -C "private-key-to-access-linux-box"
mv ./ssh-windows-to-linux ./ssh-windows-to-linux.pem
```

## To create the Github Deploy Key
Run the following from the 'terraform' folder to generate the Github deploy key:

```bash
ssh-keygen.exe -b 2048 -t rsa -f ./github-deploy-key -N '""' -m PEM -C "github-deploy-key"
mv ./github-deploy-key ./github-deploy-key.pem
```

Then add the Public Key to Github

## Connect from the Windows Box to Linux Box
After Terraforming up, RDP to the Windows Box and log in as Administrator. 

```powershell
ssh -o "StrictHostKeyChecking=no" ec2-user@the-public-or-internal-ip-of-the-linux-box
```

Depending on the alignment of the stars, direction of the wind and phase of the moon, you will get a shell to the Linux box. 

# References
| Description | Link |
| ----------- | ---- |
| Using Github Deploy Keys | https://gist.github.com/zhujunsan/a0becf82ade50ed06115 |
| Windows: set GIT_SSH first | https://stackoverflow.com/questions/57742378/git-clone-with-ssh-only-working-in-git-bash-not-on-windows-cmd |
