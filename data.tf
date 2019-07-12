data "aws_iam_policy_document" "policy" {
  dynamic "statement" {
    for_each = var.statements
    content {
      sid       = lookup(statement.value, "sid", null)
      actions   = lookup(statement.value, "actions", null)
      effect    = lookup(statement.value, "effect", null)
      resources = lookup(statement.value, "resources", null)
      dynamic "principals" {
        for_each = lookup(statement.value, "principals", [])
        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }
      dynamic "condition" {
        for_each = lookup(statement.value, "condition", [])
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}
