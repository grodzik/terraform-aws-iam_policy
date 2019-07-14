resource "aws_iam_policy" "policy" {
  name        = var.name
  name_prefix = var.name_prefix
  path        = var.path
  description = var.description
  policy      = data.aws_iam_policy_document.policy.json
}
