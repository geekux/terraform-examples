variable "PROFILE" {
  default = "default"
}

variable "REGION" {
  default = "eu-central-1"
}

variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-0b898040803850657"
    eu-central-1 = "ami-0cc293023f983ed53"
  }
}
