output "dns_name" {
  value = "${aws_efs_mount_target.mount_target.*.dns_name[0]}"
}
