#resource "aws_efs_file_system" "efs" {
#  creation_token = "my-product"
#
#  lifecycle_policy {
#    transition_to_ia = "AFTER_30_DAYS"
#  }
#  tags = {
#    Name = "MyProduct"
#  }
#}

module "efs" {
  source = "rhythmictech/efs-filesystem/aws"

  name                    = var.NAME
  allowed_security_groups = [module.sg.security_group_id]
  subnets                 = ["190.0.1.0/16"]
  vpc_id                  = module.vpc.vpc_id
}