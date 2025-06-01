variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "main-vpc"
  
}

variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t2.micro"
  
}

variable "ec2_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "single-instance"
  
}