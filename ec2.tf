data "aws_key_pair" "keypair" {
   key_name  = "Youtube-key2"
}
resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.main_subnet.id
  key_name = data.aws_key_pair.keypair.key_name
  tags = {
    Name = var.instance_tag    
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [ tags ]
  }
}