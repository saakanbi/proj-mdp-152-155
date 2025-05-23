provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "kops_state_store" {
  bucket = "kops-state-wole9548"

  tags = {
    Name        = "KopsStateStore"
    Environment = "project2"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.kops_state_store.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.kops_state_store.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.kops_state_store.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_route53_zone" "k8s_zone" {
  name = "wole9548.com"
}
