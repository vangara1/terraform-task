
  module "s3_bucket" {
    source = "terraform-aws-modules/s3-bucket/aws"

    bucket = var.NAME
    acl    = "private"

    versioning = {
      enabled        = true
    }
    lifecycle_rule = [
      {
        id      = var.NAME
        enabled = true

        expiration = {
          days = var.day
        }
      }
    ]

  }

