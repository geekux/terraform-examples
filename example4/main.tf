resource "aws_key_pair" "terraform" {
  key_name = "terraform"
  public_key = file(var.PUBLIC_KEY)
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

resource "aws_instance" "example" {
  ami = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.terraform.key_name

  tags = {
    Name = "ec2-example-1"
  }

  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > instance_ip.txt"
  }

  connection {
    host = self.public_ip
    user = var.USERNAME
    type = "ssh"
    private_key = file(var.PRIVATE_KEY)
  }
}

output "ip" {
  value = aws_instance.example.public_ip
}
