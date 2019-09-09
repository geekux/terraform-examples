variable instance_type {
  type = string
  default = "t2.micro"
}

variable ami {
  type = string
  default = ""
}

variable tags {
  type = map
}

variable key_name {
  type = string
}

variable packages {
  type = list
  default = []
}

variable services {
  type = list
  default = []
}
