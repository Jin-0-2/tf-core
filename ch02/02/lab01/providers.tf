terraform {
  required_version = ">= 1.17.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
      # version = "6.0"
      # version = "= 6.0"
      # version = ">= 6.0, < 7.0"
      # ersion =">= 7.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}
