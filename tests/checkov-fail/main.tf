terraform {
  required_providers {
    aws    = { source = "hashicorp/aws" }
    random = { source = "hashicorp/random" }
  }
  backend "s3" {
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "random_uuid" "bucket_suffix" {
}

locals {
  bucket_rando_suffix = substr(random_uuid.bucket_suffix.result, 0, 8)
}

# Checkov is pretty unhappy with this bucket
# Check: CKV_AWS_21: "Ensure all data stored in the S3 bucket have versioning enabled"
# Check: CKV_AWS_18: "Ensure the S3 bucket has access logging enabled"
# Check: CKV_AWS_144: "Ensure that S3 bucket has cross-region replication enabled"
# Check: CKV_AWS_145: "Ensure that S3 buckets are encrypted with KMS by default"
# Check: CKV2_AWS_6: "Ensure that S3 bucket has a Public Access block"
# Check: CKV2_AWS_61: "Ensure that an S3 bucket has a lifecycle configuration"
# Check: CKV2_AWS_62: "Ensure S3 buckets should have event notifications enabled"
resource "aws_s3_bucket" "this" {
  bucket = "job-template-test-bucket-${local.bucket_rando_suffix}"
}
