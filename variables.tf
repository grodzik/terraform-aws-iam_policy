variable "description" {
  description = "Description of the IAM policy."
  default     = null
  type        = string
}

variable "name" {
  description = "The name of the policy. If omitted, Terraform will assign a random, unique name."
  default     = null
  type        = string
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with name."
  default     = null
  type        = string
}

variable "path" {
  description = "Path in which to create the policy. See IAM Identifiers for more information."
  default     = "/"
  type        = string
}

variable "statements" {
  description = "List of statement maps"
  type        = list
}
