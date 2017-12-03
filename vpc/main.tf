provider "aws" {
  region = "us-east-1"
  profile = "chris"
}

resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "Nextcloud ${var.environment_name} VPC"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "Nextcloud ${var.environment_name} VPC"
  }
}
resource "aws_route" "route" {
  route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}
resource "aws_subnet" "public_1a" {
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "us-east-1a"
  cidr_block = "${var.public_1a_cidr}"
  map_public_ip_on_launch = true

  tags {
    Name = "Public 1a - Nextcloud ${var.environment_name} VPC"
  }
}
resource "aws_subnet" "public_1b" {
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "us-east-1b"
  cidr_block = "${var.public_1b_cidr}"
  map_public_ip_on_launch = true

  tags {
    Name = "Public 1b - Nextcloud ${var.environment_name} VPC"
  }
}
resource "aws_subnet" "public_1c" {
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "us-east-1c"
  cidr_block = "${var.public_1c_cidr}"
  map_public_ip_on_launch = true

  tags {
    Name = "Public 1c Nextcloud ${var.environment_name} VPC"
  }
}
