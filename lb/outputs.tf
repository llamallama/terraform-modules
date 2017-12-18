output "tg_arn" {
  value = "${aws_lb_target_group.tg.arn}"
}
output "dns_name" {
  value = "${aws_lb.lb.dns_name}"
}
output "zone_id" {
  value = "${aws_lb.lb.zone_id}"
}
