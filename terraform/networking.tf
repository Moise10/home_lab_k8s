
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


module "web_access_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "web-access"
  description = "Allow HTTP and HTTPS access from anywhere"
  vpc_id      = module.vpc.vpc_id

  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules = ["all-all"]
}

