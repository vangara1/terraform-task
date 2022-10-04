#module "iam_policy" {
#  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
#
#  name        = var.NAME
#  path        = "/"
#  description = "custom policy"
#
#  policy = <<EOF
#{
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Effect": "Allow",
#            "Action": [
#                "s3:*",
#                "s3-object-lambda:*"
#            ],
#            "Resource": "*"
#        }
#    ]
#}
#EOF
#}