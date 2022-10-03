module "iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_arns = [
    "arn:aws:iam::307990089504:root",
    "arn:aws:iam::835367859851:user/anton",
  ]

  create_role = true

  role_name         = var.NAME
  role_requires_mfa = true

  custom_role_policy_arns = [module.iam_policy.id]
  number_of_custom_role_policy_arns = 1
}
#resource "aws_iam_instance_profile" "test_profile" {
#  name = "test_profile"
#  role = module.iam_role.id
#}

