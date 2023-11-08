data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}


output "subnets" {
    value = data.aws_subnets.example.ids
}
resource "aws_instance" "web" {
    count = ceil(var.instance_count)
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = upper(var.instance_tag)
    Owner  = lower(var.email)
    Description = title("this is a server for jenkin")
  }
}

