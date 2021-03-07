# Terraform up a Linux box 
Terraform up a Linux box, clone a Git Repository on that box (via user-data) and run the setup scripts from that Repository. 

## Quick Start
From the terraform folder:

1. Create the Public / Private KeyPair (see below)
2. Either create a terraform.tfvars or modify the variables.tf to include your values
3. terraform init
4. terraform plan
5. ... usual terraform lifecycle

## To create the Public / Private KeyPair
Run the following from the 'terraform' folder to generate the public / private key pair:

```bash
ssh-keygen.exe -b 2048 -t rsa -f ./ssh-windows-to-linux -N '""' -m PEM -C "private-key-to-access-linux-box"
mv ./ssh-windows-to-linux ./ssh-windows-to-linux.pem
```

## Considerations
If the bootstrapping/ files changes, the 'terraform plan' will detect it and recreate the instance. 

However: if changes are made in the remote repo, you will need to use 'terraform taint' to cause the instance to be recreated and the new Git Repo scripts to run.
