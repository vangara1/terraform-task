# Amazon EKS with AWS LoadBalancers

terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region = var.aws_region
}

# vpc
module "vpc" {
  source              = "Young-ook/spinnaker/aws//modules/spinnaker-aware-aws-vpc"
  version             = "2.3.1"
  name                = var.name
  tags                = merge(var.tags, module.eks.tags)
  azs                 = var.azs
  cidr                = var.cidr
  enable_igw          = var.enable_igw
  enable_ngw          = var.enable_ngw
  single_ngw          = var.single_ngw
  vpc_endpoint_config = []
}

# eks
module "eks" {
  source              = "Young-ook/eks/aws"
  version             = "1.7.5"
  name                = var.name
  tags                = var.tags
  subnets             = values(module.vpc.subnets["private"])
  kubernetes_version  = var.kubernetes_version
  managed_node_groups = var.managed_node_groups
  node_groups         = var.node_groups
  fargate_profiles    = var.fargate_profiles
}

provider "helm" {
  kubernetes {
    host                   = module.eks.helmconfig
    token                  = module.eks.helmconfig
    cluster_ca_certificate = base64decode(module.eks.helmconfig)
  }
}

module "lb-controller" {
  source       = "../../modules/lb-controller"
  cluster_name = module.eks.cluster
  oidc         = module.eks.oidc
  tags         = var.tags
  helm = {
    vars = module.eks.features ? {
      vpcId       = module.vpc.vpc
      clusterName = module.eks.cluster
      } : {
      clusterName = module.eks.cluster
    }
  }
}



eksctl create iamserviceaccount \
--cluster education-eks-xeeCWZk1
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
-n kube-system \
--set clusterName=education-eks-xeeCWZk1 \
--set serviceAccount.create=false \
--set serviceAccount.name=aws-load-balancer-controller