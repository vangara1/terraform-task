terraform {
  backend "s3" {
    bucket = "terra-07009"
    key    = "efs/backend/data"
    region = "us-east-1"
  }
}
