module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name               = "${var.NAME}-vpc"
  cidr               = var.CIDR
  azs                = var.AZ
  private_subnets    = var.PVT-SUBNET
  public_subnets     = var.SUBNET
  enable_nat_gateway = true
  enable_vpn_gateway = true

}
resource "aws_eip" "elastic-ip" {
  count = 1
  vpc   = true
  tags  = {
    name = "${var.NAME}-eip"
  }
}





