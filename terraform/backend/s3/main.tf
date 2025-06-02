resource "random_id" "bucket_suffix" {
  byte_length = 8
}

resource "aws_s3_bucket" "s3_backend" {
  bucket        = "backend-s3-bucket-${random_id.bucket_suffix.hex}"
  force_destroy = true

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}


resource "aws_s3_bucket_versioning" "versioning_backend" {
  bucket = aws_s3_bucket.s3_backend.id
  versioning_configuration {
    status = "Enabled"
  }
}