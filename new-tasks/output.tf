output "VPC_ID" {
  value = aws_vpc.vpc.id
}

output "PRIVATE_SUBNET_IDS" {
  value = aws_subnet.pvt-subnet.*.id
}

output "PUBLIC_SUBNET_IDS" {
  value = aws_subnet.pub_subnet.*.id
}

output "PRIVATE_SUBNET_CIDR" {
  value = aws_subnet.pvt-subnet.*.cidr_block
}

output "PUBLIC_SUBNET_CIDR" {
  value = aws_subnet.pub_subnet.*.cidr_block
}
output "public_ip" {
  value = aws_instance.instance.public_ip
}

#
#output "INTERNAL_HOSTEDZONE_ID" {
#  value = var.INTERNAL_HOSTEDZONE_ID
#}
