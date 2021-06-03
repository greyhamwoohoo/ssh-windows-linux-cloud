# Terraform up a Linux and Windows box 
Terraform up a Linux and Windows EC2 box, clone a Github repository (public/private) and run a script from the cloned repo on each box. 

Also configures the Windows box with the private SSH Key; see aws-tf for more information. 

## Quick Start
From the terraform folder:

1. Create the Public / Private KeyPair (see below)
2. Either create a terraform.tfvars or modify the variables.tf to include your values
3. terraform init
4. terraform plan
5. ... usual terraform lifecycle

## Private Github Repositories
Terraform will bootstrap both boxes with 'user-data' to clone a Github repo and run scripts from that repo. 

If the Github Repository is private, you will need to create a custom PAT and set the 'github_repo_is_private' variable to 'true'. 

See variables.tf for more information. 

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

## Considerations
If the bootstrapping/ files changes, the 'terraform plan' will detect it and recreate the instance. 

However: if changes are made in the remote repo, you will need to use 'terraform taint' to cause the instance to be recreated on the next 'terraform apply'.
