resource "aws_instance" "example" {
  ami           = "ami-05c13eab67c5d8861"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main_subnet.id

  tags = {
    Name = "Terraform-managed-public-ec2"
  }
}