terraform {
  backend "s3" {
    bucket = "terra-07009"
    key    = "task-2/wave-cycle/backend/data"
    region = "us-east-1"
  }
}
