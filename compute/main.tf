# --- compute/main.tf ---
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ami-083654bd07b5da81d"]
  }
}



