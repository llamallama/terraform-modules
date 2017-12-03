provider "aws" {
 region = "us-east-1"
 profile = "chris"
}


resource "aws_security_group" "nextcloud" {
  name = "nextcloud-security-group"

  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/user-data.tpl")}"

  vars {
    nextcloud_url = "${var.nextcloud_url}"
  }
}

resource "aws_instance" "nextcloud" {
  ami = "${var.ami}"
  instance_type = "t2.micro"
  user_data = "${data.template_file.user_data.rendered}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.nextcloud.id}"]
  subnet_id = "${var.subnet_id}"

  tags {
    Name = "NextCloud"
  }
}
