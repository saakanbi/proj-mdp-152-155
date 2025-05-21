provider "aws" {
  region = "us-east-1"
}

# VPC
resource "aws_vpc" "project1_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "project1_vpc"
  }
}

# Subnet 1
resource "aws_subnet" "project1_subnet1" {
  vpc_id                  = aws_vpc.project1_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "project1_subnet1"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "project1_igw" {
  vpc_id = aws_vpc.project1_vpc.id

  tags = {
    Name = "project1_igw"
  }
}

# Route Table
resource "aws_route_table" "project1_rt" {
  vpc_id = aws_vpc.project1_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project1_igw.id
  }

  tags = {
    Name = "project1_rt"
  }
}

# Route Table Association
resource "aws_route_table_association" "project1_subnet1" {
  subnet_id      = aws_subnet.project1_subnet1.id
  route_table_id = aws_route_table.project1_rt.id
}

# Security Group
resource "aws_security_group" "project1_sg" {
  name        = "project1_sg"
  description = "Allow SSH, HTTP, HTTPS, Tomcat & App Ports"
  vpc_id      = aws_vpc.project1_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Tomcat"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App on 8081"
    from_port   = 8081
    to_port     = 8081
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
    Name = "project1_sg"
  }
}

# EC2 Instance for Maven CI Server
resource "aws_instance" "maven_server" {
  ami                         = "ami-0e58b56aa4d64231b" # Amazon Linux 2
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.project1_subnet1.id
  key_name                    = "sunday"
  vpc_security_group_ids      = [aws_security_group.project1_sg.id]
  associate_public_ip_address = true
  user_data                   = file("user_data/build_server.sh")

  tags = {
    Name = "maven_server"
  }
}
