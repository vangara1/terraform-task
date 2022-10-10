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
#
module "efs" {
  source = "rhythmictech/efs-filesystem/aws"

  name                    = var.NAME
  allowed_security_groups = [aws_security_group.sg.id]
  subnets                 =  module.vpc.public_subnets
  vpc_id                  = module.vpc.vpc_id
}