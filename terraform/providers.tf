terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}

provider "aws" {
  region = "eu-central-1"
  # assume_role {
  #   role_arn     = "arn:aws:iam::122610524571:role/terraform-cli" # Or the actual ARN string
  #   session_name = "terraform-$(whoami)"
  }
