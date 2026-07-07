# Copy of test/s3-simple. Used to test the default value for TERRAFORM_DIR.
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
  value = data.aws_region.current.region
}
