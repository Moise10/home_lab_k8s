data "aws_ami" "example" {
  most_recent = true
  name_regex  = "bitnami-wordpresspro-6.8.0-r02-linux-debian-12-x86_64-hvm-ebs-nami-*"

  filter {
    name   = "name"
    values = ["bitnami-wordpresspro-6.8.0-r02-linux-debian-12-x86_64-hvm-ebs-nami-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "aws_ami_nginx" {
  value = data.aws_ami.example
}



module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  name = "single-instance"

  instance_type          = var.instance_type
  ami                    = data.aws_ami.example.id
  monitoring             = true
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
}


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa                              = true
  enable_cluster_creator_admin_permissions = true
  eks_managed_node_groups = {
    default = {
      desired_size   = var.node_desired_size
      min_size       = 1
      max_size       = 4
      instance_types = ["t3.large", "t3a.large"]
      capacity_type  = "SPOT"
    }
  }

  # Managed add-ons (auto‑updated by AWS)
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
  }

  tags = {
    Environment = "home-lab"
    Project     = "kubernetes-home-lab"
  }
}

module "endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "5.21.0"

  vpc_id = module.vpc.vpc_id
  endpoints = {
    ec2     = { service = "ec2" }
    sts     = { service = "sts" }
    ecr_api = { service = "ecr.api" }
    ecr_dkr = { service = "ecr.dkr" }
    s3 = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = module.vpc.private_route_table_ids
    }
  }
}
