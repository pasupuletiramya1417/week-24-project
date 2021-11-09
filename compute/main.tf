# --- compute/main.tf ---
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ami-083654bd07b5da81d"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_launch_template" "web" {
  name_prefix            = "web"
  image_id               = "ami-083654bd07b5da81d"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [var.sg]
  user_data              = filebase64("install_apache.sh")

  tags = {
    Name = "web"
  }
}

resource "aws_autoscaling_group" "web" {
  name                = "web"
  vpc_zone_identifier = tolist(var.public_subnet)
  min_size            = 2
  max_size            = 3
  desired_capacity    = 2

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
}

