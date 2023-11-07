terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.5.0"
    }
  }
}

# Provider Block
provider "aws" {
  # Configuration options
  region = "us-east-1" 
  profile = "357225030460_AWSAdministratorAccess"   
}