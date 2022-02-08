terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "ec2_instance" {
  count = 3
  source               = "./modules/ec2_instance"
  instance_type        = "t2.micro"
  hostname             = "host${count.index}"
  allow_incoming_http  = true
  allow_incoming_https = true
}

module "s3_media_bucket" {
  source            = "./modules/s3_media_bucket"
  media_bucket_name = "myb3288391827192"
  media_bucket_acl  = "public-read"
}
