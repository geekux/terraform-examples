## Modules, Templates and Locals

Module is analogy to functions in programming language. It allows to define reusable Terraform code. Modules can be stored locally or in git. There is number of modules avialable on github where some of them are verified by [https://registry.terraform.io/](Terraform Team). Local variables have limited scope to module where they were declared.

```
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
```

AWS use [https://cloud-init.io/](cloud-init) for configuration of Linux instance at launch. Cloud-init has possibility to inject user configuration. Option is known as *user data* and it's supported by AWS API. It's possible to add custom script or *cloud-init* compatibile directive. 

```
resource "aws_instance" "this" {
  ami = local.ami
  instance_type = "t2.micro"
  key_name = var.key_name
  tags = var.tags
  user_data = templatefile("${path.module}/script.tpl", { packages = var.packages, services = var.services })
}
``` 
