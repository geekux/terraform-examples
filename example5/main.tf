resource "aws_key_pair" "terraform" {
  key_name = "terraform"
  public_key = file(var.PUBLIC_KEY)
}

resource "aws_key_pair" "terraform-virginia" {
  provider = aws.virginia
  key_name = "terraform"
  public_key = file(var.PUBLIC_KEY)
}

module "ec2-example" {
  source = "./modules/ec2"
  key_name = aws_key_pair.terraform.key_name
  tags = {"Name" = "ec2-example", Project = "POC"}
  instance_type = "t2.micro"
  packages = ["httpd", "telnet"]
  services = ["httpd"]
}

module "ec2-example-virginia" {
  source = "./modules/ec2"
  providers = { aws = "aws.virginia" }
  key_name = aws_key_pair.terraform.key_name
  tags = {Name = "ec2-example-virginia", Project = "POC"}
  instance_type = "t2.micro"
  packages = ["httpd", "telnet"]
  services = ["httpd"]
}
