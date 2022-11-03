resource "aws_eip" "ngw-eip" {
  vpc = true
  tags = {
    Name = "${var.ENV}-ngw-eip"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw-eip.id
  subnet_id     = aws_subnet.public-subnet.*.id[0]

  tags = {
    Name = "${var.ENV}-ngw"
  }
}