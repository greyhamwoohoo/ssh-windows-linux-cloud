# ssh-windows-linux-ssh
AWS Windows + Linux instances using Terraform with a few reference implementations:

1. Both instances are configured with the same KeyPair
2. The Windows Box is configured with the KeyPair Private Key (via user-data) so that direct access to the Linux Box is possible with ssh -o .. 
3. The Linux Box will clone a Git Repository (possibly Private) and run the setup script from that repository. 

## Implementations
| Folder | Implementation   |
| ------ | ---------------- |
| aws-tf | Terraform on AWS |

## Private Github Repositories
Terraform will add 'bootstrapping' code to the Linux machine that will clone a Github repository and then run scripts from that repository; if the setup scripts are in a private Github Repository, you will need to create a custom PAT and modify a few scripts in this repository. 

Search the repository for 'PrivateGithubRepo' for more information. 

# References
| Description | Link |
| ------------------------------------------- | ----------- |
| Using Git PAT from command line...          | https://stackoverflow.com/questions/18935539/authenticate-with-github-using-a-token |
| ... some security issues with using the PAT | https://stackoverflow.com/questions/10054318/how-do-i-provide-a-username-and-password-when-running-git-clone-gitremote-git |
| Dump the cloud-init / user-data logs        | cat /var/log/cloud-init-output.log |
| Location on Windows of cloud init / user data runs | C:\ProgramData\Amazon\EC2-Windows\Launch\Log | 
| Create SSH Key Pair within Terraform        | https://stackoverflow.com/questions/49743220/how-do-i-create-an-ssh-key-in-terraform |
| Install Docker on AWS Linux                 | https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html | 
