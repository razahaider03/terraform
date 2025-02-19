terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.87.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  description = "region for S3 bucket"
  type        = string
  default     = "ap-south-1"
}

resource "random_id" "rand_id" {
  byte_length = 4
}

resource "aws_s3_bucket" "txtfilebucket03" {
  bucket = "myubucket-${random_id.rand_id.hex}"
}

resource "aws_s3_object" "txtfile" {
  bucket = aws_s3_bucket.txtfilebucket03.bucket
  source = "./demofile.txt"
  key    = "demofilex.txt"
  force_destroy = true
}
