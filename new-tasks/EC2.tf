resource "aws_instance" "instance" {
  ami                         = "ami-05a36e1502605b4aa"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  availability_zone           = var.az[0]
  key_name                    = "fresh"
  subnet_id                   = [aws_subnet.pub_subnet.id[0]]
  vpc_security_group_ids      = [aws_vpc.vpc.id]
}
