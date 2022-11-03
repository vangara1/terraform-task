resource "aws_subnet" "pub_subnet" {
  vpc_id                                         = aws_vpc.vpc.id
  count                                          = length(var.public_subnet)
  cidr_block                                     = element(var.public_subnet, count.index )
  availability_zone                              = element(var.az, count.index)
  enable_resource_name_dns_a_record_on_launch = true

  tags = {
    Name = "${var.NAME}-pub-subnet"
  }
}

resource "aws_subnet" "pvt-subnet" {
  vpc_id                                         = aws_vpc.vpc.id
  count                                          = length(var.private_subnet)
  cidr_block                                     = element(var.private_subnet, count.index )
  availability_zone                              = element(var.az, count.index)
  enable_resource_name_dns_a_record_on_launch = true

  tags = {
    Name = "${var.NAME}-pvt-subnet"
  }
}



