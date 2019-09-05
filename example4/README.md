## Data Sources and Outputs

Data Sources are dynamic information that Terraform can obtain through provider's API, e.g. AWS. This example shows how get Amazon Linux AMI ID:

```
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}
```  

Each of resources has number of attributes that are kept by Terraform. They can be fetched and send to a screen or a file and then be used by external applications.
