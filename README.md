# ssh-windows-linux-cloud
Terraform manage Windows + Linux instances. The Linux Box acts as the 'server' with the public SSH key; the Windows Box acts as the 'client' with the private SSH Key placed and configured (or available). Various implementations are provided. 

## Security Caution
All of these solutions use instance 'meta-data' in some form (user-data in AWS; meta-data in GCP). Yes: the private key is available in the metadata and therefore available to anything running in the instance(s). The security implications vary depending on your cloud provider. For a more secure solution, use whatever least privelege techniques you normally use to secure your sensitive data.

Decide if you can live with these security implications (HINT: assume you can't in Production, but probably can in ephemeral test environments for a large class of use cases).

# AWS
| Folder | Implementation   |
| ------ | ---------------- |
| aws-tf | Creates a Windows + Linux box with SSH private key configured on the Windows box |
| aws-tf-github-pat | aws-tf + a Github repository is cloned on the Linux and Windows box using a PAT with user-data; scripts from the cloned repo are executed |
| aws-tf-github-deploy-key | aws-tf + a Github repository is cloned on the Linux and Windows box using a Github Deploy Key. Minimal (nothing is run from clone repo) |
| aws-tf-docker | Creates a Windows + Linux box with SSH private key configured on the Windows box; the Windows Docker Client can drive the Docker Daemon |

Other than security groups that wrap each instance (allowing RDP and SSH from anywhere in the world), no consideration has been paid to security. 

# GCP
| Folder | Implementation   |
| ------ | ---------------- |
| gcp-tf | Creates a Windows + Linux box with SSH private key accessible from the Windows box; sysprep and startup scripts run and log outputs |

# References
| Description | Link |
| ------------------------------------------- | ----------- |
| Using Git PAT from command line...          | https://stackoverflow.com/questions/18935539/authenticate-with-github-using-a-token |
| ... some security issues with using the PAT | https://stackoverflow.com/questions/10054318/how-do-i-provide-a-username-and-password-when-running-git-clone-gitremote-git |
| Dump the cloud-init / user-data logs        | cat /var/log/cloud-init-output.log |
| Location on Windows of cloud init / user data runs | C:\ProgramData\Amazon\EC2-Windows\Launch\Log | 
| Create SSH Key Pair within Terraform        | https://stackoverflow.com/questions/49743220/how-do-i-create-an-ssh-key-in-terraform |
| Install Docker on AWS Linux                 | https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html | 
| AWS: Security implications of metadata and userdata | https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html |
| GCP: Security implications of instances metadata | https://cloud.google.com/compute/docs/storing-retrieving-metadata |
