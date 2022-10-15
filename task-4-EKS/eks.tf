module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.26.6"

  cluster_name                    = var.NAME
  cluster_version                 = "1.22"
  vpc_id                          = module.vpc.vpc_id
  subnet_ids                      = module.vpc.private_subnets
  eks_managed_node_group_defaults = {
    ami_type                              = "AL2_x86_64"
    attach_cluster_primary_security_group = true
    create_security_group                 = false
  }
  eks_managed_node_groups = {
      name = "wave-node-${count.index}"
#      count = 2
      count = length(module.vpc.private_subnets)
      instance_types = ["t3.medium"]

      min_size     = 2
      max_size     = 10
      desired_size = 4


      vpc_security_group_ids = [
        module.sg.security_group_id
      ]


  }
}
