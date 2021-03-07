# ssh-windows-linux-cloud
Terraform up AWS Windows + Linux EC2 instances with a few golden threads for future reference:

1. Both instances are configured with the same KeyPair
2. The Windows Box is set up with the KeyPair Private Key (via user-data) so that zero manual configuration access to the Linux Box is possible with ssh -o .. ec2-user@...
3. Both boxes will clone a Git Repository (possibly Private) and run the setup script from that repository for that box type. 

Other than security groups that wrap each instance (allowing RDP and SSH from anywhere in the world), no consideration has been paid to security. 

## Implementations
| Folder | Implementation   |
| ------ | ---------------- |
| aws-tf | Terraform on AWS |

## Private Github Repositories
Terraform will add 'bootstrapping' code to the Linux and Windows machine (via user-data) that will clone a Github repository and then run scripts from that repository; if the Github Repository is private, you will need to create a custom PAT and set the 'github_repo_is_private' variable to 'true'. 

Search the repository for 'PrivateGithubRepo' / variables.tf for more information. 

# References
| Description | Link |
| ------------------------------------------- | ----------- |
| Using Git PAT from command line...          | https://stackoverflow.com/questions/18935539/authenticate-with-github-using-a-token |
| ... some security issues with using the PAT | https://stackoverflow.com/questions/10054318/how-do-i-provide-a-username-and-password-when-running-git-clone-gitremote-git |
| Dump the cloud-init / user-data logs        | cat /var/log/cloud-init-output.log |
| Location on Windows of cloud init / user data runs | C:\ProgramData\Amazon\EC2-Windows\Launch\Log | 
| Create SSH Key Pair within Terraform        | https://stackoverflow.com/questions/49743220/how-do-i-create-an-ssh-key-in-terraform |
| Install Docker on AWS Linux                 | https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html | 
