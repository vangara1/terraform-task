terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.6.1"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
#  config_context = "kubernetes-admin@kubernetes"
}


provider "aws" {
  region = "us-east-1"
}

