# If true, the Github Repository is Private. In which case: github_pat MUST be specified. 
variable "github_repo_is_private" {
  type    = bool
  default = false
}

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

# Git Branchname (or commit)
variable "github_commit" {
  type    = string
  default = "main"
}

# Fully qualified path of the .key path. Probably: ./ssh-windows-linux-cloud.key 
variable "ssh_windows_to_linux_private_key_path" {
  type    = string
  default = "not-a-valid-key-path"
}
