provider "aws" {
  profile = var.PROFILE
  region = "eu-central-1"
}

provider "aws" {
  alias = "virginia"
  region = "us-east-1"
}
