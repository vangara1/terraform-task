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
  config_paths = [
    "/path/to/config_a.yaml",
    "/path/to/config_b.yaml"
  ]
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

