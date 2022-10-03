module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name = var.NAME
  cidr = var.CIDR
  azs                = var.AZ
  private_subnets    = var.PVT-SUBNET
  public_subnets     = var.SUBNET
  enable_nat_gateway = true
  enable_vpn_gateway = true
  public_dns         = true

}
resource "aws_eip" "nat" {
  count = 1
  vpc   = true
  tags  = {
    name = var.NAME
  }
}



  enable_nat_gateway = var.vpc_enable_nat_gateway


