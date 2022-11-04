CIDR           = "16.0.0.0/16"
NAME           = "OnePlus"
public_subnet  = ["16.0.0.0/19", "16.0.32.0/19", "16.0.64.0/19"]
private_subnet = ["16.0.224.0/21", "16.0.232.0/21", "16.0.240.0/21"]
az             = ["us-east-2a", "us-east-2b", "us-east-2c"]
ami            = "ami-05a36e1502605b4aa"
type           = "t2.large"
key            = "/root/terraform-task/new-tasks/OnePlus.pem"