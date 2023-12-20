terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.23.1"
    }
  }
}

# Provider Block
provider "aws" {
  # Configuration options
  region = "us-east-1" 
  profile = "<accountNUmber>_AWSAdministratorAccess"   
}
