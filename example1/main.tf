provider "aws" {
  profile    = "default"
  region     = "eu-central-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0cc293023f983ed53"
  instance_type = "t2.micro"

  tags = {
    Name = "ec2-example-1"
  }
}
