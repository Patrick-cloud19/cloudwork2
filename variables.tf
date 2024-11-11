variable "region" {
  description = "The region param of the AWS"
  type        = string
  default     = "us-east-2"
}
variable "availability_zone" {
  description = "The availability zone of the subnet"
  type        = string
  default     = "us-east-2a"
}
variable "cidr_block" {
  description = "The CIDR block of universal using"
  type        = string
  default     = "0.0.0.0/0"  
}
variable "cidr_vpc1" {
  description = "The CIDR block for VPC1"
  type = string
  default = "172.0.0.0/16"
}
variable "cidr_vpc2" {
  description = "The CIDR block for VPC2"
  type = string
  default = "172.1.0.0/16"
}
variable "cidr_vpc3" {
  description = "The CIDR block for VPC3"
  type = string
  default = "172.2.0.0/16"
}
variable "cidr_sub1" {
  description = "The CIDR block for subnet1"
  type = string
  default = "172.0.1.0/24"
}
variable "cidr_sub2" {
  description = "The CIDR block for subnet2"
  type = string
  default = "172.1.1.0/24"
}
variable "cidr_sub3" {
  description = "The CIDR block for subnet3"
  type = string
  default = "172.2.1.0/24"
}
variable "instance_type" {
  description = "The instance type of EC2"
  type = string
  default = "t2.micro"
}
variable "ami_id" {
  description = "The ami id of EC2"
  type = string
  default = "ami-00eb69d236edcfaf8"
}