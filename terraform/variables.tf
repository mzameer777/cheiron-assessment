variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_id" {
  description = "VPC ID to deploy into"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for ALB and ASG"
  type        = list(string)
}

variable "availability_zone" {
  description = "AZ for EC2 instances"
  type        = string
  default     = "ap-south-1a"
}

variable "key_pair_name" {
  description = "EC2 key pair name for SSH access"
  type        = string
}

variable "my_ip" {
  description = "Your public IP for SSH access (e.g., 203.0.113.10/32)"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID for ECR URIs"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
