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
  ami             = "ami-075a72b1992cb0687"
  instance_type   = "t2.small"
  security_groups = [aws_security_group.allow_ssh_from_everywhere.name]
  key_name        = "ssh-windows-to-linux"

  depends_on = [aws_key_pair.ssh_windows_to_linux]
}

resource "aws_instance" "windows_box" {
  ami                  = "ami-0e952010fc45db537"
  instance_type        = "t2.small"
  security_groups      = [aws_security_group.allow_rdp_from_everywhere.name]
  user_data_base64     = base64encode(file("./bootstrapping/windows-2019.txt"))
  key_name             = "ssh-windows-to-linux"
  iam_instance_profile = aws_iam_instance_profile.windows_instance_profile.id
}

resource "aws_iam_instance_profile" "windows_instance_profile" {
  name = "windows-instance-profile"
  role = aws_iam_role.windows_instance_role.name
}

resource "aws_iam_role_policy" "windows_instance_role_policy" {
  name = "windows-instance-role-policy"
  role = aws_iam_role.windows_instance_role.id

  # Policy document
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
        ],
        "Resource" : ["arn:aws:s3:::ssh-windows-linux-cloud/ssh-windows-to-linux.pem"]
      }
    ]
  })
}

resource "aws_iam_role" "windows_instance_role" {
  name = "windows-instance-role"
  path = "/"

  # Trust relationship policy document
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }   
    ]
}
EOF
}

output "linux_box_public_ip" {
  value = aws_instance.linux_box.public_ip
}

output "windows_box_public_ip" {
  value = aws_instance.windows_box.public_ip
}
