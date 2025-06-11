terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

#   backend "s3" {
#     bucket         = "backend-s3-bucket-90778487453"
#     key            = "terraform/terraform.tfstate"
#     region         = "eu-central-1"
#     encrypt = true

# }

}

provider "aws" {
  region = "eu-central-1"
  }
