variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "tags" {
  description = "Tags to apply to the resource"
  type        = map(string)
}