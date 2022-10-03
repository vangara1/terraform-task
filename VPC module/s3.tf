module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "lifecycle-test-rune-my-s3-bucket"
  acl    = "private"

  versioning = {
    enabled        = true
    lifecycle_rule = true

  }

}

#
#module "lifecycle" {
#  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
#
#  name        = "lifecycle"
#  path        = "/"
#  description = "lifecycle policy"
#
#  policy = <<EOF
#{
#	"Version": "2012-10-17",
#	"Statement": [
#		{
#			"Sid": "Statement1",
#			"Principal": {},
#			"Effect": "Allow",
#			"Action": [
#				"dlm:CreateLifecyclePolicy"
#			],
#			"Resource": []
#		}
#	]
#}
#EOF
#}