module "sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = var.NAME
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      rule        = "All traffic"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}