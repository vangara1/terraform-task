terraform {
  backend "s3" {
    bucket = "${var.NAME}-terraform-backend"
    key    = "wave-cycle/backend/data"
    region = "us-east-1"
  }
}
