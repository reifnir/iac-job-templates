terraform {
  required_providers {
    aws = { source = "hashicorp/aws" }
  }
  backend "s3" {
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_region" "current" {}

output "region" {
  value = data.aws_region.current.name
}
