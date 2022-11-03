
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.NAME}-igw"
  }
}

resource "aws_eip" "lb" {
  vpc      = true
  tags = {
    Name = "${var.NAME}-lb"
  }

}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.pub_subnet.*.id[0]

  tags = {
    Name = "${var.NAME}-nat-gw"
  }

  depends_on = [aws_internet_gateway.igw]
}