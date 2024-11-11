variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "internet_gateway_id" {
  description = "The ID of the internet gateway"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

# variable "peering_connection_id" {
#   description = "The ID of the VPC peering connection"
#   type        = string
# }

# variable "peer_vpc_cidr_block" {
#   description = "The CIDR block of the peer VPC"
#   type        = string
# }

variable "tags" {
  description = "Tags to apply to the resource"
  type        = map(string)
}