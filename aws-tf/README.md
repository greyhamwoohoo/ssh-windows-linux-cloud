# Terraform up a Linux and Windows box 
Terraform up a Linux and Windows box, clone a Git Repository on each box (via user-data) and run the setup scripts from that Repository. 

Can clone Public or Private Github Repos

## Quick Start
From the terraform folder:

1. Create the Public / Private KeyPair (see below)
2. Either create a terraform.tfvars or modify the variables.tf to include your values
3. terraform init
4. terraform plan
5. ... usual terraform lifecycle

## Connect from the Windows Box to Linux Box
After Terraforming up, RDP to the Windows Box and log in as Administrator. 

```powershell
ssh -o "StrictHostKeyChecking=no" ec2-user@the-public-or-internal-ip-of-the-linux-box
```

Depending on the alignment of the stars, direction of the wind and phase of the moon, you will get a shell to the Linux box. 

## To create the Public / Private KeyPair
Run the following from the 'terraform' folder to generate the public / private key pair:

```bash
ssh-keygen.exe -b 2048 -t rsa -f ./ssh-windows-to-linux -N '""' -m PEM -C "private-key-to-access-linux-box"
mv ./ssh-windows-to-linux ./ssh-windows-to-linux.pem
```

## Considerations
If the bootstrapping/ files changes, the 'terraform plan' will detect it and recreate the instance. 

However: if changes are made in the remote repo, you will need to use 'terraform taint' to cause the instance to be recreated on the next 'terraform apply'.
