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
