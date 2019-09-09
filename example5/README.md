## Modules, Templates and Locals

Module is analogy to functions in programming language. It allows to define reusable Terraform code. Modules can be stored locally or on git. There is number of modules avialable on github where some of them are verified by [Terraform Team](https://registry.terraform.io/).

```terraform
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

Variables can be created as a local ones. In such case they have limited scope to module where they were declared. Terraform supports JavaScript-like ternary operator: **condition ? expresionIfTrue : expresionIfFalse**.

```terraform
locals {
  ami = var.ami != "" ? var.ami : data.aws_ami.amazon-linux-2-x86_64-gp2.id
}
```

AWS use [cloud-init](https://cloud-init.io) for configuration of Linux instance at launch. Cloud-init has possibility to inject user configuration. Option is known as **user data** and it's supported by AWS API. It's possible to add custom script or **cloud-init** compatibile directive. 

```terraform
resource "aws_instance" "this" {
  ami = local.ami
  instance_type = "t2.micro"
  key_name = var.key_name
  tags = var.tags
  user_data = templatefile("${path.module}/script.tpl", { packages = var.packages, services = var.services })
}
``` 

In addition **user data** script can be parametrized with Terraform variables. In such form it's called a template.

```bash
#!/bin/bash

# update OS
yum -y update

# install packages
%{ for package in packages ~}
yum -y install ${package}
%{ endfor ~}

# start services
%{ for service in services ~}
systemctl enable ${service}
systemctl start ${service}
%{ endfor ~}
```
