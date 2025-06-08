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

variable "node_desired_size" {
  description = "Desired number of nodes in the default node group"
  type        = number
  default     = 2
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "home-lab"
}

variable "kubernetes_version" {
  description = "Kubernetes version for the control plane"
  type        = string
  default     = "1.32"
}

variable "region" {
  description = "AWS region for the resources"
  type        = string
  default     = "eu-central-1"
  
}

variable "alert_endpoint_email" {
  description = "Email endpoint for SNS alerts"
  type        = string
  default     = "moisembakop@yandex.com"
  
}