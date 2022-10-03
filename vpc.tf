module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.NAME
  cidr = var.CIDR

  azs                = var.AZ
  private_subnets    = var.PVT-SUBNET
  public_subnets     = var.SUBNET
  enable_nat_gateway = true
  enable_vpn_gateway = true

}


module "nat-gateway" {
  source              = "terraform-aws-modules/vpc/aws"
  enable_nat_gateway  = true
  single_nat_gateway  = false
  reuse_nat_ips       = true
  external_nat_ip_ids = "${aws_eip.nat.*.id}"
}

resource "aws_eip" "nat" {
  count = 1
  vpc   = true
  tags  = {
    name = var.NAME
  }
}