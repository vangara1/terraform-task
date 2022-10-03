module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"


  name = var.NAME

  create_spot_instance                = true
  spot_type                           = var.spot_type
  spot_instance_interruption_behavior = var.spot_behavior
  associate_public_ip_address = true
  ami                                 = var.ami
  instance_type                       = var.instance_type
  key_name                            = var.NAME
  monitoring                          = true
#  vpc_security_group_ids              = [module.sg.security_group_id]
  subnet_id                           = module.vpc.public_subnets[0]
  security_group_rules = [
    {
      type        = "egress"
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "ingress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]

  tags = {
    name = var.NAME
  }
}


