# PrivateGithubRepo: Provide a Github PAT that is capable of cloning private repositories. 
variable "github_pat" {
  type    = string
  default = "not-a-valid-pat"
}

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

# Fully qualified path of the .pem path. Probably: ./ssh-windows-linux-cloud.pem 
variable "ssh_windows_to_linux_private_key_path" {
  type    = string
  default = "not-a-valid-pem-path"
}
