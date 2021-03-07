#
# Script to run on Windows 2019. 
# Variables are passed with TF_ prefix (see terraform/bootstrapping/windows-2019-private-repo.txt for more info)
#
Set-Location $env:USERPROFILE

Set-Service -Name "ssh-agent" -StartupType Automatic
Start-Service ssh-agent

New-Item -Type Directory -Name ".ssh" -ErrorAction SilentlyContinue

$env:TF_PRIVATE_KEY_CONTENT | Out-File -FilePath ~/.ssh/ssh-windows-to-linux.pem -Encoding ASCII

ssh-add .ssh/ssh-windows-to-linux.pem 
