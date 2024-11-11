variable "ami" {
  description = "AMI ID"
  type        = string
}
variable "instance_type" {
  description = "Instance type"
  type        = string
}
variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}
variable "security_group_id" {
  description = "Security group ID"
  type        = string
}
variable "instance_name" {
  description = "Instance name tag"
  type        = string
}
variable "tags" {
  description = "Tags for EC2 instance"
  type        = map(string)
  default     = {}
}