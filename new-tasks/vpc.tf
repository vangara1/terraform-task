resource "aws_vpc" "main" {
  cidr_block           = var.CIDR
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = " ${var.NAME}-vpc"
  }
}




