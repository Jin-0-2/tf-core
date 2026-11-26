terraform {
    required_version = ">= 1.17.0"

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 6.0"
        }
    }
}

provider "aws" {
  region =  "ap-northeast-2"
}

resource "aws_security_group" "web1" {
    name = "tf-core-lab01-sg-web1"
}

resource "aws_security_group" "web2" {
    name = "tf-core-lab01-sg-web2"
}
