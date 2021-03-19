# Terraform up a Linux and Windows box 
Terraform up a Linux and Windows EC2 box and configure the Windows box with the private SSH Key. 

The Private SSH Key / .pem resides in an S3 bucket. 

## Quick Start
From the terraform folder:

1. Create the Public / Private KeyPair (see below)
2. Copy the private .pem to an S3 bucket (this example doesnt add any policy to the S3 bucket; the assumption is that it already exists).
   The bucket is hardcoded (currently) in the role in stack.tf (TODO:)
3. Either create a terraform.tfvars or modify the variables.tf to include your values
4. terraform init
5. terraform plan
6. ... usual terraform lifecycle

## To create the Public / Private KeyPair
Run the following from the 'terraform' folder to generate the public / private key pair:

```bash
ssh-keygen.exe -b 2048 -t rsa -f ./ssh-windows-to-linux -N '""' -m PEM -C "private-key-to-access-linux-box"
mv ./ssh-windows-to-linux ./ssh-windows-to-linux.pem
```

## Connect from the Windows Box to Linux Box
After Terraforming up, RDP to the Windows Box and log in as Administrator. 

```powershell
ssh -o "StrictHostKeyChecking=no" ec2-user@the-public-or-internal-ip-of-the-linux-box
```

Depending on the alignment of the stars, direction of the wind and phase of the moon, you will get a shell to the Linux box. 
