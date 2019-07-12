resource "aws_iam_policy" "policy" {
  name        = var.name
  path        = var.path
  description = var.description
  policy      = data.aws_iam_policy_document.policy.json
}
