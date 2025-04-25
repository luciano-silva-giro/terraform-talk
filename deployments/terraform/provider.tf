provider "aws" {
  region  = "us-east-1"
  profile = "example"
}

terraform {
  required_version = ">=1.9.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.72.1"
    }
  }
}
