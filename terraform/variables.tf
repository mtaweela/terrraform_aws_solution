variable "aws_region" {
  description = "the aws region to build the infrastruture in"
}

variable "aws_access_key" {
  description = "aws access key"
}

variable "aws_secret_key" {
  description = "aws secret key"
}

variable "ec2_instance_type" {
  description = "determine the type of the ec2 instance"
  default     = "t2.micro"
}

variable "media_bucket_name" {
  description = "media bucket name"
}

variable "media_bucket_acl" {}