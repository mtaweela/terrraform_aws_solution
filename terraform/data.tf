data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Access data about available availability zones in the current region
data "aws_availability_zones" "this" {}

# Retrieve info about the VPC this host should join
data "aws_vpc" "this" {
  default = var.vpc_id == "" ? true : false
  id      = var.vpc_id
}

data "aws_subnet" "this" {
  vpc_id            = data.aws_vpc.this.id
  availability_zone = local.availability_zone
}
