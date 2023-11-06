terraform {
  backend "s3" {
    bucket = "terraform-backend1201"
    key    = "youtube/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "Terraform"
    # profile = "357225030460_AWSAdministratorAccess"
  }
}