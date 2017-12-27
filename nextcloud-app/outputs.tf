output "instance_id" {
  value = "${aws_instance.nextcloud.*.id}"
}
output "address" {
  value = "${aws_instance.nextcloud.*.public_dns}"
}
output "public_ip" {
  value = "${aws_instance.nextcloud.*.public_ip}"
}
