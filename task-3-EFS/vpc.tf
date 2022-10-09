module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = "${var.NAME}-vpc"
  cidr = var.CIDR
  azs                = var.AZ
  public_subnets     = var.SUBNET
  enable_nat_gateway = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
}
resource "aws_eip" "eip" {
  count = 1
  vpc   = true
  tags  = {
    name = "${var.NAME}-eip"
  }
}





