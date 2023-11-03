resource "aws_s3_bucket" "backend" {
  bucket = "terraform-backend1201"
  
  tags = {
    Name        = "Terraform-backend"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "bucket" {
  bucket = aws_s3_bucket.backend.id

  versioning_configuration {
    status = "Enabled"
  }
}