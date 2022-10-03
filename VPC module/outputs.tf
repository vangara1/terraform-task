output "vpc_public_subnets" {
  value       = module.vpc.public_subnets
}

output "iam_role" {
  value = module.iam_role.name
}
