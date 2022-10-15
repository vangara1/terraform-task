module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"
  name               = "${var.NAME}-vpc"
  cidr               = var.CIDR
  azs                = var.AZ
  private_subnets    = var.PVT-SUBNET
  public_subnets     = var.SUBNET
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true


  public_subnet_tags = {
    "kubernetes.io/cluster/${var.NAME}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.NAME}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}






