locals {
  ami = var.ami != "" ? var.ami : data.aws_ami.amazon-linux-2-x86_64-gp2.id
}

data "aws_ami" "amazon-linux-2-x86_64-gp2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm*-gp2"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "this" {
  ami = local.ami
  instance_type = "t2.micro"
  key_name = var.key_name
  tags = var.tags
  user_data = templatefile("${path.module}/script.tpl", { packages = var.packages, services = var.services })
}
