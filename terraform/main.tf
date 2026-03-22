provider "aws" {
  region = "ap-south-1" 
}

# Dynamic AMI Lookup for Amazon Linux 2023 (x86_64)
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

# Create the EC2 Instance
resource "aws_instance" "devops_server" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t3.micro"
  key_name      = "my-key" # Ensure this matches your AWS Key Pair name

  tags = {
    Name = "DevOps-Lab-Server"
  }
}

# Output the Public IP for Ansible
output "instance_ip" {
  value = aws_instance.devops_server.public_ip
}
