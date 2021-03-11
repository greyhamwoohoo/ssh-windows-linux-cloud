# ssh-windows-linux-cloud
Terraform manage AWS Windows + Linux EC2 instances with a few common use cases demonstrated:

| Folder | Implementation   |
| ------ | ---------------- |
| aws-tf | Creates a Windows + Linux box with SSH private key configured on the Windows box |
| aws-tf-github-pat | aws-tf + a Github repository is cloned on the Linux and Windows box using a PAT with user-data; scripts from the cloned repo are executed |
| aws-tf-github-deploy-key | aws-tf + a Github repository is cloned on the Linux and Windows box using a Github Deploy Key. Minimal (nothing is run from clone repo) |
| aws-tf-docker | Creates a Windows + Linux box with SSH private key configured on the Windows box; the Windows Docker Client can drive the Docker Daemon |

Other than security groups that wrap each instance (allowing RDP and SSH from anywhere in the world), no consideration has been paid to security. 

# References
| Description | Link |
| ------------------------------------------- | ----------- |
| Using Git PAT from command line...          | https://stackoverflow.com/questions/18935539/authenticate-with-github-using-a-token |
| ... some security issues with using the PAT | https://stackoverflow.com/questions/10054318/how-do-i-provide-a-username-and-password-when-running-git-clone-gitremote-git |
| Dump the cloud-init / user-data logs        | cat /var/log/cloud-init-output.log |
| Location on Windows of cloud init / user data runs | C:\ProgramData\Amazon\EC2-Windows\Launch\Log | 
| Create SSH Key Pair within Terraform        | https://stackoverflow.com/questions/49743220/how-do-i-create-an-ssh-key-in-terraform |
| Install Docker on AWS Linux                 | https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html | 
