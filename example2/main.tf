resource "aws_instance" "example" {
  ami           = var.AMIS[var.REGION]
  instance_type = "t2.micro"

  tags = {
    Name = "ec2-example-1"
  }
}

