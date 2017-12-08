output "endpoint" {
  value = "${aws_db_instance.default.endpoint}"
}

output "address" {
  value = "${aws_db_instance.default.address}"
}

output "port" {
  value = "${aws_db_instance.default.port}"
}

output "arn" {
  value = "${aws_db_instance.default.arn}"
}
