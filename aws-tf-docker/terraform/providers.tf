terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.31.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}
