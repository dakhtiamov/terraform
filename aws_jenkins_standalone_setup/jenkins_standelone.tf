provider "aws" {
  access_key = ""
  secret_key = ""
  region = ""
}

resource "aws_instance" "JenkinsStandalone" {
  count = 1
  ami = "ami-067ee10914e74ffee" #Ubuntu 14
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.JenkinsStandaloneSecurityGroup.id]
  user_data = file("user_data.sh")
  tags = {
    Name = "JenkinsStandalone"
    Owner = "owner"
  }
}

resource "aws_security_group" "JenkinsStandaloneSecurityGroup" {
  name = "JenkinsStandaloneSecurityGroup"
  description = "JenkinsStandaloneSecurityGroup"

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
