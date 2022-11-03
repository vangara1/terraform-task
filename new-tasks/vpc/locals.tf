locals {
  VPC_CIDR     = split(",", var.VPC_CIDR)
  ALL_VPC_CIDR = concat(local.VPC_CIDR, var.VPC_CIDR_ADDON)

}
#
#output "ALL_VPC_CIDR" {
#  value = [for s in local.ALL_VPC_CIDR : "CIDR = ${s}"]
#}

locals {
  association-list = flatten([
  for cidr in local.ALL_VPC_CIDR : [
  for route_table in tolist(data.aws_route_tables.default-vpc-routes.ids) : {
    cidr        = cidr
    route_table = route_table
  }
  ]
  ])
}

#output "sample" {
#  value = tomap(element(local.association-list,0))["cidr"]
#}