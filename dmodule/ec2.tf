module "webapp" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"
  ami = "ami-05c13eab67c5d8861"
  tags = {
    Name = "Terraform default module"
    environment = "Develop"
  }
  # subnet_id = "10.10.0.0/24"
  instance_type = "t2.micro"
}