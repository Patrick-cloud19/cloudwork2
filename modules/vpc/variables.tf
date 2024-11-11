variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "tags" {
  description = "Tags for VPC resources"
  type        = map(string)
  default     = {}
}