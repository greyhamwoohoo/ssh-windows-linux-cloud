resource "aws_security_group" "allow_ssh_from_everywhere" {
  name        = "allow_ssh_from_everywhere"
  description = "Allow SSH (22) from Everywhere"

  ingress {
    description = "SSH from Everywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_from_everywhere"
  }
}

resource "aws_security_group" "allow_rdp_from_everywhere" {
  name        = "allow_rdp_from_everywhere"
  description = "Allow RDP (3389) from Everywhere"

  ingress {
    description = "RDP from Everywhere"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_rdp_from_everywhere"
  }
}

resource "aws_key_pair" "ssh_windows_to_linux" {
  key_name   = "ssh-windows-to-linux"
  public_key = file("./ssh-windows-to-linux.pub")
}

resource "aws_instance" "linux_box" {
  ami              = "ami-075a72b1992cb0687"
  instance_type    = "t2.small"
  security_groups  = [aws_security_group.allow_ssh_from_everywhere.name]
  user_data_base64 = base64encode(templatefile("./bootstrapping/amazon-linux.txt", { github_deploy_private_key_content = base64encode(file(var.github_deploy_key_private_key_path)), github_user_name = var.github_user_name, github_repo_name = var.github_repo_name, github_commit = var.github_commit }))
  key_name         = "ssh-windows-to-linux"

  depends_on = [aws_key_pair.ssh_windows_to_linux]
}

resource "aws_instance" "windows_box" {
  ami              = "ami-0e952010fc45db537"
  instance_type    = "t2.small"
  security_groups  = [aws_security_group.allow_rdp_from_everywhere.name]
  user_data_base64 = base64encode(templatefile("./bootstrapping/windows-2019.txt", { private_key_content = file(var.ssh_windows_to_linux_private_key_path), github_deploy_private_key_content = file(var.github_deploy_key_private_key_path), github_user_name = var.github_user_name, github_repo_name = var.github_repo_name, github_commit = var.github_commit }))
  key_name         = "ssh-windows-to-linux"
}

output "linux_box_public_ip" {
  value = aws_instance.linux_box.public_ip
}

output "windows_box_public_ip" {
  value = aws_instance.windows_box.public_ip
}
