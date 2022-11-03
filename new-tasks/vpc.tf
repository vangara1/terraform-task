data "aws_region" "current" {}

resource "aws_vpc" "main" {
  cidr_block       = "16.0.0.0/16"
  instance_tenancy = "default"
  region_name = data.aws_region.current.name
  enable_dns_hostnames  = true

tags = {
    Name = "main"
  }
}


resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "16.0.1.0/24"
  availability_zone= "us-east-2a"
  enable_resource_name_dns_aaaa_record_on_launch = true

  tags = {
    Name = "Main"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "16.2.0.0/16"
}

resource "aws_subnet" "in_secondary_cidr" {
  vpc_id     = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block = "16.2.0.0/24"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}