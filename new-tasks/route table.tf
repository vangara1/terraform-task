resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name ="${var.NAME}-route-table"
  }
}

resource "aws_route_table_association" "route-table-pub" {
  count          = length(aws_subnet.pub_subnet.*.id)
  subnet_id      = aws_subnet.pub_subnet[count.index].id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "route-table-pvt" {
  count          = length(aws_subnet.pvt-subnet.*.id)
  subnet_id      = aws_subnet.pvt-subnet[count.index].id
  route_table_id = aws_route_table.route_table.id
}