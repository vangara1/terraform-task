resource "aws_vpc" "vpc" {
  cidr_block           = var.CIDR
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    Name = " ${var.NAME}-vpc"
  }
}




