


  subnets             = values(module.vpc.subnets["private"])
  kubernetes_version  = var.kubernetes_version
  managed_node_groups = var.managed_node_groups
  node_groups         = var.node_groups
  fargate_profiles    = var.fargate_profiles
}

provider "helm" {
  kubernetes {
    host                   = module.eks.helmconfig.host
    token                  = module.eks.helmconfig.token
    cluster_ca_certificate = base64decode(module.eks.helmconfig.ca)
  }
}

module "lb-controller" {
  source       = "../../modules/lb-controller"
  cluster_name = module.eks.cluster.name
  oidc         = module.eks.oidc
  tags         = var.tags
  helm = {
    vars = module.eks.features.fargate_enabled ? {
      vpcId       = module.vpc.vpc.id
      clusterName = module.eks.cluster.name
    } : {
      clusterName = module.eks.cluster.name
    }
  }
}