resource "aws_instance" "instance" {
  ami                         = "ami-05a36e1502605b4aa"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  availability_zone           = var.az[0]
  key_name                    = "fresh"
  security_groups             = [aws_security_group.sg.id]
  vpc_security_group_ids      = [aws_vpc.vpc.id]
}