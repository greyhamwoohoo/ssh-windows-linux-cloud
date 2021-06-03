## Quick Start
From the terraform folder:

1. Create the Public / Private KeyPair (see below)
2. Either create a terraform.tfvars or modify the variables.tf to include your values
3. terraform init
4. terraform plan
5. ... usual terraform lifecycle

## To create the Public / Private KeyPair
Run the following from the 'terraform' folder to generate the public / private key pair (.pub, .key):

```bash
ssh-keygen.exe -b 2048 -t rsa -f ./ssh-windows-to-linux -N '""' -m PEM -C "the-public-key"
mv ./ssh-windows-to-linux ./ssh-windows-to-linux.key
```

## Connect from the Windows Box to Linux Box
After Terraforming up, RDP to the Windows Box and log in as the user. 

To connect to the Linux box, can pull the private key right out of the meta-data yourself in your folder:

```powershell
Invoke-RestMethod "http://metadata.google.internal/computeMetadata/v1/instance/attributes/private-key-content" -Headers @{"Metadata-Flavor"="Google"} | Out-File -FilePath  ~/ssh-windows-to-linux.key -Encoding ASCII

ssh -o "StrictHostKeyChecking=no" -i ~/ssh-windows-to-linux.key youruser@the_ip_of_the_linux_box
```

Depending on the alignment of the stars, direction of the wind and phase of the moon, you will get a shell to the Linux box. 

# References
| Description | Link |
| ----------- | ---- |
| Identity Security (IAP) - RDP | https://cloud.google.com/blog/products/identity-security/zero-trust-remote-access-for-windows-vms |
