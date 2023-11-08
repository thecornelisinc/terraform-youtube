variable "ami" {
    type = string
    description = "This is a varible for instance ami"
}

variable "instance_type" {
    type = string
    description = "This is a variable for instance type"
}


variable "tag" {
    type = map(string)
    description = "(optional) describe your variable"
}

