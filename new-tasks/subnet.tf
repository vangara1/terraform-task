resource "aws_subnet" "subnet" {
  vpc_id                                         = aws_vpc.vpc.id
  count                                          = length(var.public_subnet)
  cidr_block                                     = element(var.public_subnet, count.index )
  availability_zone                              = element(var.az, count.index)
  enable_resource_name_dns_a_record_on_launch = true

  tags = {
    Name = "${var.NAME}-subnet"
  }
}

