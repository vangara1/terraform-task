resource "aws_instance" "instance" {
  ami                         = "ami-05a36e1502605b4aa"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "fresh"
  subnet_id                   = aws_subnet.pub_subnet.id
  vpc_security_group_ids      = [aws_vpc.vpc.id]
}
