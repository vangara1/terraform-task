
#  module "s3_bucket" {
#    source = "terraform-aws-modules/s3-bucket/aws"
#
#    bucket = var.NAME
#    acl    = "private"
#
#    versioning = {
#      enabled        = true
#    }
#    lifecycle_rule = [
#      {
#        id      = var.NAME
#        enabled = true
#
#        expiration = {
#          days = var.day
#        }
#      }
#    ]
#
#  }
#

resource "aws_s3_bucket" "bucket" {
  bucket = "wave-cycle-terrafrom-test-bucket"
  tags = {
    name = "${var.NAME}-bucket"
  }
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
  tags = {
    name = "${var.NAME}-acl"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
  tags = {
    name = "${var.NAME}-versioning"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    id = "${var.NAME}-id"
    expiration {
      days = var.day
    }
    status = "Enabled"
  }
  tags = {
    name = "${var.NAME}-lifecycle"
  }
}