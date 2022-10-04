
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

resource "aws_s3_bucket" "wave-bucket" {
  bucket = "${var.NAME}-bucket"
}

resource "aws_s3_bucket_acl" "wave-acl" {
  bucket = aws_s3_bucket.wave-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "wave-versioning" {
  bucket = aws_s3_bucket.wave-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "wave-lifecycle" {
  bucket = aws_s3_bucket.wave-bucket.id

  rule = [
          {
            id      = var.NAME
            enabled = true

            expiration = {
              days = var.day
            }
          }
        ]

    status = "Enabled"
}