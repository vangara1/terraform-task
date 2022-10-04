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

resource "aws_iam_role_policy_attachment" "wave-role" {
  role       = module.iam_role.iam_role_arn
  policy_arn = module.iam_policy.iam_policy_arn
}
