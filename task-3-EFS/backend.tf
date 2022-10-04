terraform {
  backend "s3" {
    bucket = "terra-07009"
    key    = "task-3/efs/backend/data"
    region = "us-east-1"
  }
}
