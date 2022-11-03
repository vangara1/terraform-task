resource "aws_instance" "instance" {
  ami                         = "ami-05a36e1502605b4aa"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "fresh"
  count                       = length(aws_subnet.pub_subnet)
  subnet_id                   = aws_subnet.pub_subnet[0].id
  vpc_security_group_ids      = [aws_vpc.vpc.id]
}
