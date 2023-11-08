variable "ami" {
    default = "ami-05c13eab67c5d8861"
}
variable "instance_type" {
    type = string
    default = "t2.micro"
}
variable "instance_tag" {
    default = "Webapp"
}
variable "vpc_id" {
    default = "vpc-005dc467fc0012f62"
}

variable "email" {
    default = "terra@gmail.com"
}
variable "instance_count" {}
