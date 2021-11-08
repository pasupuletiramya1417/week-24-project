# --- compute/main.tf ---

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "Ubuntu Server 20.04 LTS"
    values = ["ami-083654bd07b5da81d"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "web" {
  name_prefix            = "web"
  image_id               = data.ami-083654bd07b5da81d
  instance_type          = var.t2.micro
  vpc_security_group_ids = [var.web_sg]
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

