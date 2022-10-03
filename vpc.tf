module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.NAME
  cidr = var.CIDR

  azs                = var.AZ
  public_subnets    = var.SUBNET
  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
#
#module "vpc" {
#  source = "terraform-aws-modules/vpc/aws"
#
#  # The rest of arguments are omitted for brevity
#
#  enable_nat_gateway  = true
#  single_nat_gateway  = false
#  reuse_nat_ips       = true                    # <= Skip creation of EIPs for the NAT Gateways
#  external_nat_ip_ids = "${aws_eip.nat.*.id}"   # <= IPs specified here as input to the module
#}