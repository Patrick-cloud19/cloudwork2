variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "cidr_block" {
  description = "Subnet CIDR block"
  type        = string
}
variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
}
variable "tags" {
  description = "Tags for Subnet resources"
  type        = map(string)
  default     = {}
}