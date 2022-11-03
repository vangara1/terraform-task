output "VPC_ID" {
  value = aws_vpc.main.id
}

output "DEFAULT_VPC_ID" {
  value = var.VPC_DEFAULT_ID
}

output "PRIVATE_SUBNET_IDS" {
  value = aws_subnet.private-subnet.*.id
}

output "PUBLIC_SUBNET_IDS" {
  value = aws_subnet.public-subnet.*.id
}

output "PRIVATE_SUBNET_CIDR" {
  value = aws_subnet.private-subnet.*.cidr_block
}

output "PUBLIC_SUBNET_CIDR" {
  value = aws_subnet.public-subnet.*.cidr_block
}

output "DEFAULT_VPC_CIDR" {
  value = var.DEFAULT_VPC_CIDR
}

output "INTERNAL_HOSTEDZONE_ID" {
  value = var.INTERNAL_HOSTEDZONE_ID
}
 output "ALL_VPC_CIDR" {
   value = local.ALL_VPC_CIDR
 }