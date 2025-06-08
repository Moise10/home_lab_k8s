
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

data "aws_iam_openid_connect_provider""oidc" {
  url= module.eks.cluster_oidc_issuer_url
}

data "aws_availability_zones" "AZs" {
  state = "available"
}

# data "aws_iam_policy_document" "sns_publish" {
#   statement {
#     actions = [
#       "sns:Publish"
#     ]
#     resources = [
#       aws_sns_topic.home_lab-alerts.arn
#     ]
#   }
# }