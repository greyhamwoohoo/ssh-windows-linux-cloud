variable "linux_username" {
    type = string
    default = "someusername"
}

variable "ssh_windows_to_linux_public_key_path" {
  type    = string
  default = "not-a-valid-pub-path"
}

variable "ssh_windows_to_linux_private_key_path" {
  type    = string
  default = "not-a-valid-key-path"
}
