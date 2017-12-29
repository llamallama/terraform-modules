resource "aws_security_group" "nextcloud" {
  name = "nextcloud-security-group"

  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.access_ip}"]
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/user-data.tpl")}"
}

resource "aws_instance" "nextcloud" {
  count = "${var.count_num}"
  ami = "${var.ami}"
  instance_type = "t2.micro"
  user_data = "${data.template_file.user_data.rendered}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_groups}","${aws_security_group.nextcloud.id}"]
  subnet_id = "${element(var.subnet_ids, count.index)}"
  iam_instance_profile = "${var.iam_instance_profile}"

  tags {
    Name = "NextCloud"
  }

  provisioner "file" {
    source = "${path.module}/provision.sh"
    destination = "/tmp/provision.sh"

    connection {
      type     = "ssh"
      user     = "ec2-user"
    }
  }

  provisioner "file" {
    source = "${path.module}/configs"
    destination = "/tmp/"

    connection {
      type     = "ssh"
      user     = "ec2-user"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/provision.sh",
      "sudo /tmp/provision.sh '${var.nextcloud_url}' '${var.domain_name}' '${var.efs_mount_target}'",
    ]

    connection {
      type     = "ssh"
      user     = "ec2-user"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
