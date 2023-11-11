variable "vpc_cidr_block" {
  type        = string
  description = "(optional) describe your variable"
}

variable "vpc_tag" {
  type        = string
  description = "(optional) describe your variable"
}


variable "igw" {
  type        = string
  description = "(optional) describe your variable"
  default     = "training-igw"
}

variable "public_subnet_cidr" {
  type        = list(string)
  description = "(optional) describe your variable"
}

variable "public_subnet_tag" {
  type        = string
  description = "(optional) describe your variable"
}


variable "private_subnet_cidr" {
  type        = list(string)
  description = "(optional) describe your variable"
}

variable "private_subnet_tag" {
  type        = string
  description = "(optional) describe your variable"
}

variable "private_subnet_rt" {
    type = string
    description = "(optional) describe your variable"
}

variable "ami" {
    type = string
    description = "(optional) describe your variable"
}

variable "instance_type" {
    type = string
    description = "(optional) describe your variable"
}

variable "web_instance_tag" {
    type = string
    description = "(optional) describe your variable"
}
variable "app_instance_tag" {
    type = string
    description = "(optional) describe your variable"
}