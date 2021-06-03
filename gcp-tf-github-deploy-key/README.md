# Terraform up a Linux and Windows box 
Terraform up a Linux and Windows box and clones Github repo using a Github Deploy Key via meta-data. See the bootstrapping scripts for the cloned repo location (depends on Windows/Linux).

Also configures the Windows box with the private SSH Key to access the Linux box; see gcp-tf for more information. 

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

You must create a Github Deploy Key for a private repository. These scripts will add the private key called 'github-deploy-key.key' to each host. 

See variables.tf for more information. 

## To create the Public / Private KeyPair
Run the following from the 'terraform' folder to generate the SSH public / private key pair (.pub, .key):

```bash
ssh-keygen.exe -b 2048 -t rsa -f ./ssh-windows-to-linux -N '""' -m PEM -C "the-public-key"
mv ./ssh-windows-to-linux ./ssh-windows-to-linux.key
```

## To create the Github Deploy Key
Run the following from the 'terraform' folder to generate the Github deploy key:

```bash
ssh-keygen.exe -b 2048 -t rsa -f ./github-deploy-key -N '""' -m PEM -C "github-deploy-public-key"
mv ./github-deploy-key ./github-deploy-key.key
```

Then add the Public Key to Github.

## Connect from the Windows Box to Linux Box
After Terraforming up, RDP to the Windows Box and log in as the user.

To connect to the Linux box, can pull the private key right out of the meta-data yourself in your folder:

```powershell
Invoke-RestMethod "http://metadata.google.internal/computeMetadata/v1/instance/attributes/private-key-content" -Headers @{"Metadata-Flavor"="Google"} | Out-File -FilePath  ~/ssh-windows-to-linux.key -Encoding ASCII

ssh -o "StrictHostKeyChecking=no" -i ~/ssh-windows-to-linux.key youruser@the_ip_of_the_linux_box
```

Depending on the alignment of the stars, direction of the wind and phase of the moon, you will get a shell to the Linux box. 

## To view the Cloned Repository
The repo is cloned to the root folder of each machine. 

# References
| Description | Link |
| ----------- | ---- |
| Using Github Deploy Keys | https://gist.github.com/zhujunsan/a0becf82ade50ed06115 |
| Windows: set GIT_SSH first | https://stackoverflow.com/questions/57742378/git-clone-with-ssh-only-working-in-git-bash-not-on-windows-cmd |
