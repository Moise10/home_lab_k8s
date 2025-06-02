data "aws_availability_zones" "AZs" {
  state = "available"

}


module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "5.21.0"
  name            = var.vpc_name
  cidr            = "10.0.0.0/16"
  public_subnets  = ["10.0.0.0/24", "10.0.1.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.5.0/24", "10.0.8.0/24", "10.0.16.0/24"]
  azs             = data.aws_availability_zones.AZs.names
  enable_dns_hostnames = true

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_support = true
  tags = {
    Project     = "kubernetes-home-lab"
    Terraform   = "true"
  }
}