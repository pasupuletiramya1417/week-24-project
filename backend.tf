
terraform {
  backend "s3" {
    bucket = "kk-07162021"
    key    = "remote.tfstate"
    region = "us-east-1"
  }
}
