resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.CIDR
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name ="${var.NAME}-route-table"
  }
}
resource "aws_route_table_association" "route-table-a" {
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.route_table.id
}

