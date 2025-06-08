# resource "aws_sns_topic" "home_lab-alerts" {
#   name = "k8s-alerts"
# }

# resource "aws_sns_topic_subscription" "alert_email" {
#   topic_arn = aws_sns_topic.k8s_alerts.arn
#   protocol  = "email"
#   endpoint  = var.alert_endpoint_email
# }


# #Lets allow the EKS cluster to publish to the SNS topic



# resource "aws_iam_policy" "sns_publish" {
#   name   = "SNSPublishK8s"
#   policy = data.aws_iam_policy_document.sns_publish.json
# }


# resource "aws_iam_role_policy_attachment" "eks_nodes_sns" {
#   policy_arn = aws_iam_policy.sns_publish.arn
#   role       = module.eks.node_groups["default"].iam_role_name
# }


