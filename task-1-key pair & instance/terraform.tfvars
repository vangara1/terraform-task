NAME          = "Wave-cycle"
CIDR          = "170.0.0.0/16"
AZ            = ["us-east-1a","us-east-1b" , "us-east-1c"]
SUBNET        = ["170.0.0.0/24", "170.0.1.0/24","170.0.2.0/24"]
PVT-SUBNET    = ["170.0.1.0/24"]
spot_type     = "persistent"
spot_behavior = "stop"
ami           = "ami-002070d43b0a4f171"
instance_type = "t2.micro"



