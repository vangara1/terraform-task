data "aws_region" "current" {}

locals {
  name            = "EKS-test"
  cidr            = "10.0.0.0/16"
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  azs             = formatlist("${data.aws_region.current.name}%s", ["a", "b", "c"])
}

module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  name                   = "${local.name}-vpc"
  azs                    = local.azs
  cidr                   = local.cidr
  private_subnets        = local.private_subnets
  public_subnets         = local.public_subnets
  enable_dns_hostnames   = true
  enable_dns_support     = true
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
}