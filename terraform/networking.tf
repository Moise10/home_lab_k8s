data "aws_availability_zones" "available" {}





module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "5.21.0"
  name            = var.vpc_name
  cidr            = "10.0.0.0/16"
  public_subnets  = ["10.0.0.0/24"]
  private_subnets = ["10.0.128.0/24"]
  azs             = ["eu-west-1a"]
}