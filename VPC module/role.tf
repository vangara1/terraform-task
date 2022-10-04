#module "iam_role" {
#  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
#
#  trusted_role_arns = [
#    "arn:aws:iam::307990089504:root"
#  ]
#
#  create_role = true
#
#  role_name         = var.NAME
#  role_requires_mfa = true
#
#  custom_role_policy_arns = [module.iam_policy.id]
#  number_of_custom_role_policy_arns = 1
#}
#
#resource "aws_iam_instance_profile" "iam_instance_profile" {
#  role = aws_iam_role.iam_role.name
#}

resource "aws_iam_instance_profile" "profile" {
  name = "${var.NAME}-profile"
  role = aws_iam_role.role.name
}
resource "aws_iam_role" "role" {
  name = "${var.NAME}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_policy" "policy" {
  name        = "${var.NAME}-policy"
  description = "wave policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "attachment" {
  name       = "${var.NAME}-attachment"
  roles      = [aws_iam_role.role.name]
  policy_arn = aws_iam_policy.policy.arn
}