#module "sg" {
#  source = "terraform-aws-modules/security-group/aws"
#
#  name        = "${var.NAME}-sg"
#  vpc_id      = module.vpc.vpc_id
#
#  ingress_cidr_blocks      = ["190.0.0.0/16"]
#  ingress_with_cidr_blocks = [
#    {
#      from_port   = 0
#      to_port     = 0
#      protocol    = "tcp"
#      description = ""
#      cidr_blocks = "0.0.0.0/0"
#    },
#    {
#      from_port   = 22
#      to_port     = 22
#      protocol    = "tcp"
#      description = ""
#      cidr_blocks = "0.0.0.0/0"
#    }
#  ]
#}

resource "aws_security_group" "sg" {
  name        = "${var.NAME}-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.NAME}-sg"
  }
}