resource "aws_efs_file_system" "efs" {
  creation_token = "${var.creation_token}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_efs_mount_target" "mount_target" {
  count = "${var.num_mount_targets}"
  file_system_id = "${aws_efs_file_system.efs.id}"
  subnet_id = "${element(var.subnet_ids, count.index)}"
}
