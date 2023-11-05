# VPC Variables
variable "vpc_cidr" {
    type = string
}

variable "vpc_tag" {
    type = string
}

# Subnets Variables
variable "subnet_cidr" {}
variable "subnet_tag" {}
variable "igw_tag" {}
variable "route_table_tag" {}
variable "ami" {}
variable "instance_type" {
    type = string
    default = "t2.micro"
}
variable "instance_tag" {}
