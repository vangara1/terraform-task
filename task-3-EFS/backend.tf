terraform {
  backend "s3" {
    bucket = "terra-07009"
    key    = "task-3/efs-1/backend/data"
    region = "us-east-1"
  }
}
