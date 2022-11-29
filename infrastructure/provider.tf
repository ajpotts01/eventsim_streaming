terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider aws {
    region = "ap-southeast-2"
    access_key = var.aws_key_id
    secret_key = var.aws_key_secret
}