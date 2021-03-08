# Git Username
variable "github_user_name" {
  type    = string
  default = "greyhamwoohoo"
}

# Git Reponame
variable "github_repo_name" {
  type    = string
  default = "ssh-windows-linux-cloud"
}

# Git Branchname (or commit)
variable "github_commit" {
  type    = string
  default = "main"
}

# Fully qualified path of the .pem path. Probably: ./ssh-windows-linux-cloud.pem 
variable "ssh_windows_to_linux_private_key_path" {
  type    = string
  default = "not-a-valid-pem-path"
}

# Path of the Github Deploy Key .pem file
variable "github_deploy_key_private_key_path" {
  type    = string
  default = "not-a-valid-pem-path"
}
