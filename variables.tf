variable "description" {
  description = "Policy description"
  type        = string
}

variable "name" {
  description = "Name of the policy"
  type        = string
}

variable "path" {
  description = "Path of the policy"
  default     = "/"
  type        = string
}

variable "statements" {
  description = "List of statement maps"
  type        = list
}
