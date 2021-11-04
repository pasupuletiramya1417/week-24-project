
terraform {
  backend "s3" {
    bucket = "kk-07162021"
    key    = "kk_accessKeys"
    region = "us-east-1"
  }
}
