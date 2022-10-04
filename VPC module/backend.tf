terraform {
  backend "s3" {
    bucket = "wave-cycle-terraform-backend"
    key    = "wave-cycle/backend/data"
    region = "us-east-1"
  }
}
