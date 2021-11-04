# --- root/backend.tf ---

terraform {
  backend "s3" {
    bucket = "k-07162021"
    key    = "remote.tfstate"
    region = "us-east-1"
  }
}
