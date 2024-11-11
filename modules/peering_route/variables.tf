variable "route_table_id" {
  description = "The ID of the route table"
  type        = string
}
variable "destination_cidr_block" {
  description = "The CIDR block of the destination"
  type        = string
}
variable "vpc_peering_connection_id" {
  description = "The ID of the vpc peering connection"
  type        = string
}