resource "aws_sns_topic" "home_lab-alerts" {
  name = "k8s-alerts"
}

resource "aws_sns_topic_subscription" "alert_email" {
  topic_arn = aws_sns_topic.home_lab-alerts.arn
  protocol  = "email"
  endpoint  = var.alert_endpoint_email
}


# #Lets allow the EKS cluster to publish to the SNS topic



# resource "aws_iam_policy" "sns_publish" {
#   name   = "SNSPublishK8s"
#   policy = data.aws_iam_policy_document.sns_publish.json
# }


# resource "aws_iam_role_policy_attachment" "eks_nodes_sns" {
#   policy_arn = aws_iam_policy.sns_publish.arn
#   role       = module.eks.node_groups["default"].iam_role_name
# }


resource "aws_iam_policy" "k8s_sns_publish" {
  name        = "K8S-SNS-Publish"
  description = "Allow publishing to SNS topic from EKS pods"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "sns:Publish"
        Resource = aws_sns_topic.home_lab-alerts.arn
      }
    ]
  })
}


resource "aws_iam_role" "k8s_sns_irsa" {
  name = "k8s-sns-irsa-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = data.aws_iam_openid_connect_provider.oidc.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub" = "system:serviceaccount:observability/sns-publisher"
          }
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "k8s_sns_policy_attach" {
  role       = aws_iam_role.k8s_sns_irsa.name
  policy_arn = aws_iam_policy.k8s_sns_publish.arn
}


