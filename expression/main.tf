# resource "aws_instance" "example" {
#   count = var.instance_count
#   ami           = var.ami
#   instance_type =  var.environment == "dev" ? "t2.mciro" : "t2.large" //conditon ? true value : false value
#   tags = {
#     Name = "${var.instance_tag} ${count.index + 1}"
#     Environment = var.environment
#   }
# }

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0e5fa476762a4e498"
  
  dynamic "ingress" {
     for_each = [80, 22, 443, 3389, 53, 23]
     content {
        description      = "TLS from VPC"
        from_port        = ingress.value
        to_port          = ingress.value
        protocol         = "tcp"
        cidr_blocks      = ["10.10.0.0/16"]
     }

   }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"

  }

  tags = {
    Name = "allow_tls"
  }
}