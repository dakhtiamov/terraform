provider "aws" {
  access_key = ""
  secret_key = ""
  region = ""
}

resource "aws_instance" "Ubuntu14Server" {
  count = 1
  ami = "ami-067ee10914e74ffee" #Ubuntu 14
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.MyUbuntuWebServerSecurityGroup.id]
  user_data = file("user_data.sh")
  tags = {
    Name = "Simple Ubuntu Servers"
    Owner = ""
  }
}

resource "aws_security_group" "MyUbuntu14ServerSecurityGroup" {
  name = "Ubuntu14ServerSecurityGroup"
  description = "Ubuntu14ServerSecurityGroup"

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
