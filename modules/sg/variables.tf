variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "cidr_blocks" {
  description = "Allowed CIDR blocks"
  type        = list(string)
}
variable "tags" {
  description = "Tags for Security Group resources"
  type        = map(string)
  default     = {}
}