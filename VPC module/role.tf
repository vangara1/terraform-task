module "iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_arns = [
    "arn:aws:iam::307990089504:root"
  ]

  create_role = true

  role_name         = var.NAME
  role_requires_mfa = true

  custom_role_policy_arns = [module.iam_policy.id]
  number_of_custom_role_policy_arns = 1
}


resource "aws_iam_instance_profile" "role_profile" {
  name = var.NAME
  role = module.iam_role
}
#
#resource "aws_iam_role" "role" {
#  name = "test_role"
#  path = "/"
#
#  assume_role_policy = <<EOF
#{
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Action": "sts:AssumeRole",
#            "Principal": {
#               "Service": "ec2.amazonaws.com"
#            },
#            "Effect": "Allow",
#            "Sid": ""
#        }
#    ]
#}
#EOF
#}