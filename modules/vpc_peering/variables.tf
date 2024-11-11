variable "vpc_from_id" {
  description = "The ID of the VPC initiating the peering"
  type        = string
}

variable "vpc_from_name" {
  description = "The name of the VPC initiating the peering"
  type        = string
}

variable "vpc_to_name" {
  description = "The name of the VPC to peer with"
  type        = string
}

variable "vpc_to_id" {
  description = "The ID of the VPC to peer with"
  type        = string
}