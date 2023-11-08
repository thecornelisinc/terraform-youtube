# locals {
#   key1 = "value1"
#   key2 = "value2"
#   key3 = "value3"
# }

module "statingec2" {
    source = "../cmodule"
    for_each = {
        # Keys=  Values
        "vm 1"= "t2.micro"
    }
    ami = "ami-05c13eab67c5d8861"
    instance_type = each.value
    tag = {
        Name = each.key
        environment = "staging"
    }   

}
