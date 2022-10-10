output "vpc_public_subnets" {
  value       = module.vpc.public_subnets
}
#output "private_key" {
#  value     = tls_private_key.key.private_key_pem
#  sensitive = true
#}


#output "iam_role" {
#  value = module.iam_role.arn
#}
