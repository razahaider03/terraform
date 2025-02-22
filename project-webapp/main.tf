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

resource "aws_s3_bucket" "webapp-bucket" {
  bucket = "myubucket-${random_id.rand_id.hex}"
}

resource "aws_s3_bucket_public_access_block" "webapp" {
  bucket = aws_s3_bucket.webapp-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "webapp" {
  bucket = aws_s3_bucket.webapp-bucket.id
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid       = "PublicReadGetObject",
          Effect    = "Allow",
          Principal = "*",
          Action    = "s3:GetObject",
          Resource  = "arn:aws:s3:::${aws_s3_bucket.webapp-bucket.id}/*"
        }
      ]
    }
  )
}


resource "aws_s3_object" "txtfile" {
  bucket       = aws_s3_bucket.webapp-bucket.bucket
  source       = "./index.html"
  key          = "index.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "webapp" {
  bucket = aws_s3_bucket.webapp-bucket.id

  index_document {
    suffix = "index.html"
  }
}

output "url" {
  value = aws_s3_bucket_website_configuration.webapp.website_endpoint
}

