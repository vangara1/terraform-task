#module "vpc" {
#  source = "terraform-aws-modules/vpc/aws"
#
#  name = "my-vpc"
#  cidr = "10.0.0.0/16"
#
#  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
#  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
#
#  enable_dns_hostnames = true
#  enable_dns_support   = true
#  enable_nat_gateway = true
#  single_nat_gateway = true
#  one_nat_gateway_per_az = false
#
#
#  tags = {
#    Terraform = "true"
#    Environment = "dev"
#  }
#}
#


data "aws_vpc_ipam_pool" "ipv4_example" {
  filter {
    name   = "description"
    values = ["*mypool*"]
  }

  filter {
    name   = "address-family"
    values = ["ipv4"]
  }
}

# Preview next CIDR from pool
data "aws_vpc_ipam_preview_next_cidr" "previewed_cidr" {
  ipam_pool_id   = data.aws_vpc_ipam_pool.ipv4_example.id
  netmask_length = 24
}
data "aws_region" "current" {}

locals {
  partition       = cidrsubnets(data.aws_vpc_ipam_preview_next_cidr.previewed_cidr.cidr, 2, 2)
  private_subnets = cidrsubnets(local.partition[0], 2, 2)
  public_subnets  = cidrsubnets(local.partition[1], 2, 2)
  azs             = formatlist("${data.aws_region.current.name}%s", ["a", "b"])
}

module "vpc_cidr_from_ipam" {
  source            = "terraform-aws-modules/vpc/aws"
  name              = "vpc-cidr-from-ipam"
  ipv4_ipam_pool_id = data.aws_vpc_ipam_pool.ipv4_example.id
  azs               = local.azs
  cidr              = data.aws_vpc_ipam_preview_next_cidr.previewed_cidr.cidr
  private_subnets   = local.private_subnets
  public_subnets    = local.public_subnets
}