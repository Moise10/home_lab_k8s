



module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  name = "single-instance"

  instance_type          = var.instance_type
  ami                    = "ami-0c55b159cbfafe1f0" 
  monitoring             = true
  vpc_security_group_ids = module.vpc.default_security_group_id
  subnet_id              = module.vpc.public_subnets[0]
}