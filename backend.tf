
terraform {
  backend "s3" {
    bucket = "kk-07162021"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}
