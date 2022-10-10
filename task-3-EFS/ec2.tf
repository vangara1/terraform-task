module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"


  name                                = "${var.NAME}-ec2"
  create_spot_instance                = true
  spot_type                           = var.spot_type
  spot_instance_interruption_behavior = var.spot_behavior
  associate_public_ip_address         = true
  key_name                            = aws_key_pair.key_pair.key_name
  ami                                 = var.ami
  instance_type                       = var.instance_type
  monitoring                          = true
  vpc_security_group_ids              = [module.sg.security_group_id]
  subnet_id                           = module.vpc.public_subnets[0]

  tags = {
    name = "${var.NAME}-ec2"
  }
  user_data = <<EOF
  #!/bin/bash
  sudo yum install ec2-instance-connect
    EOF
  }



