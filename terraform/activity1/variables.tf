/*#variable "region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet1_cidr" {
  description = "CIDR block for public subnet 1"
  default     = "10.0.1.0/24"
}

variable "subnet2_cidr" {
  description = "CIDR block for public subnet 2"
  default     = "10.0.2.0/24"
}

variable "key_name" {
  description = "SSH key pair name for EC2 instances"
  default     = "deployer-key"
}

variable "public_key_path" {
  description = "Path to your public SSH key file"
  type        = string
  default     = "/Users/wole/.ssh/id_rsa.pub" # Update if on Linux
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI ID for us-east-1"
  default     = "ami-0e58b56aa4d64231b" # Latest Amazon Linux 2
}
*/