resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "Terraform"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"


  attribute {
    name = "LockID"
    type = "S"
  }

}