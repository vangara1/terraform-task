module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = var.NAME

  create_spot_instance = true
  spot_type            = var.spot_type
  spot_instance_interruption_behavior = var.spot_behavior
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.NAME
  monitoring             = true
  vpc_security_group_ids = module.sg
  subnet_id              =  module.vpc.public_subnets


  tags = {
    name = var.NAME
  }
}


