resource "aws_key_pair" "mykey" {
  key_name   = "${var.project_name}-${var.project_env}-key"
  public_key = file("mykey.pub")

    tags = {
    Name    = "${var.project_name}-${var.project_env}"
    Project = var.project_name
    Env = var.project_env
    }
}

resource "aws_security_group" "frontend" {
  name        = "${var.project_name}.${var.project_env}-frontend"
  description = "${var.project_name}.${var.project_env}-frontend"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "${var.project_name}.${var.project_env}-frontend"
    Project = var.project_name
    Env     = var.project_env
  }
}


#remote access

resource "aws_security_group" "remote-access" {
  name        = "${var.project_name}.${var.project_env}-remote-access"
  description = "${var.project_name}.${var.project_env}-remote-access"


  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "${var.project_name}.${var.project_env}-remote-access"
    Project = var.project_name
    Env     = var.project_env
  }
}


#----------------------
#instance
#----------------------

resource "aws_instance" "frontend" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  user_data              = file("setup.sh")
  key_name               = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.frontend.id, aws_security_group.remote-access.id ]

  tags = {
    Name    = "${var.project_name}-${var.project_env}"
    Project = var.project_name
    Env = var.project_env
 }
}


