terraform {
  backend "s3" {
    bucket = "${var.NAME}-terraform-backend"
    key    = "${var.NAME}/backend/data"
    region = "us-east-1"
  }
}
