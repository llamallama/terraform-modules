resource "aws_db_subnet_group" "default" {
  name = "${var.db_subnet_group_name}"
  subnet_ids = ["${var.subnet_ids}"]

  tags {
    Name = "${var.db_subnet_group_name}"
  }
}

resource "aws_db_instance" "default" {
  depends_on =         ["aws_db_subnet_group.default"]

  identifier = "${var.identifier}"
  engine = "${var.engine}"
  engine_version = "${var.engine_version}"
  instance_class = "${var.instance_class}"
  allocated_storage = "${var.allocated_storage}"
  storage_encrypted = "${var.storage_encrypted}"
  availability_zone = "${var.availability_zone}"
  multi_az = "${var.multi_az}"
  storage_type = "${var.storage_type}"
  name = "${var.name}"
  username = "${var.username}"
  password = "${var.password}"
  port = "${var.port}"
  maintenance_window = "${var.maintenance_window}"
  backup_window = "${var.backup_window}"
  backup_retention_period = "${var.backup_retention_period}"
  tags = "${var.tags}"
  parameter_group_name = "${var.parameter_group_name}"
  db_subnet_group_name = "${var.db_subnet_group_name}"
  skip_final_snapshot = "${var.skip_final_snapshot}"
}
