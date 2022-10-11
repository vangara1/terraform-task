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
  allowed_security_groups = [module.sg.security_group_id]
  subnets                 = module.vpc.public_subnets
  vpc_id                  = module.vpc.vpc_id
}
#resource "aws_efs_mount_target" "mount" {
#  file_system_id = module.efs.id
#  subnet_id      = module.vpc.s
#  security_groups = [aws_security_group.ec2_security_group.id]
#}

resource "aws_efs_access_point" "access-point" {
  file_system_id = module.efs.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/access"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "0777"
    }
  }
}