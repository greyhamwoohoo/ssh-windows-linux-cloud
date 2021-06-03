# ssh-windows-linux-cloud
Terraform manage Windows + Linux instances. The Linux Box acts as the 'server' with the public SSH key; the Windows Box acts as the 'client' with the private SSH Key placed and configured (or available). Various implementations are provided. 

## Naming conventions
.pub is used for all public keys; .key is used for all private keys.

The 'comment' in the public key has been made generic (via -C)

## User-Data: Security Notes
Many of these solutions use instance 'meta-data' in some form (user-data in AWS; meta-data in GCP). Yes: the private key is available in the metadata and therefore available to anything running in the instance(s). The security implications vary depending on your cloud provider. For a more secure solution, use whatever least privelege techniques you normally use to secure your sensitive data.

Decide if you can live with these security implications (HINT: assume you can't in Production, but probably can in ephemeral test environments for a large class of use cases).

## S3: Security Notes
The S3 examples do not put keys in the user-data; the .key is accessed from an S3 bucket that the Windows instance has access to via a Trusted Relationship Policy Document and Policy Document. The user-data copies the .key from s3 to the Windows host. The S3 bucket and .key is assumed to exist and is not in Terraform. 

# AWS
| Kind      | Folder | Implementation   |
| --------- | ------ | ---------------- |
| user-data | aws-tf | Creates a Windows + Linux box with SSH private key configured on the Windows box |
| user-data | aws-tf-github-pat | aws-tf + a Github repository is cloned on the Linux and Windows box using a PAT with user-data; scripts from the cloned repo are executed |
| user-data | aws-tf-github-deploy-key | aws-tf + a Github repository is cloned on the Linux and Windows box using a Github Deploy Key. Minimal (nothing is run from clone repo) |
| user-data | aws-tf-docker | Creates a Windows + Linux box with SSH private key configured on the Windows box; the Windows Docker Client can drive the Docker Daemon |
| s3        | aws-tf-s3 | Creates a Windows + Linux box with SSH private key configured on the Windows box; the .key is copied from the S3 bucket |

Other than security groups that wrap each instance (allowing RDP and SSH from anywhere in the world), no consideration has been paid to security. 

# GCP
| Folder | Implementation   |
| ------ | ---------------- |
| gcp-tf | Creates a Windows + Linux box with SSH private key accessible from the Windows box; sysprep and startup scripts run and log outputs |
| gcp-tf-deploy-key | gcp-tf + a Github repository is cloned on the Linux and Windows box using a Github Deploy Key. Minimal (nothing is run from clone repo)  |

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
| AWS: Grant access to an S3 Bucket           | https://aws.amazon.com/blogs/security/writing-iam-policies-how-to-grant-access-to-an-amazon-s3-bucket/ |
