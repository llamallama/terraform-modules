output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
output "default_security_group_id" {
  value = "${aws_vpc.vpc.default_security_group_id}"  
}
output "public_subnet_1a" {
  value = "${aws_subnet.public_1a.id}"
}
output "public_subnet_1b" {
  value = "${aws_subnet.public_1b.id}"
}
output "public_subnet_1c" {
  value = "${aws_subnet.public_1c.id}"
}
output "public_subnet_ids" {
  value = [
    "${aws_subnet.public_1a.id}",
    "${aws_subnet.public_1b.id}",
    "${aws_subnet.public_1c.id}"
  ]
}
output "igw_id" {
  value = [
    "${aws_internet_gateway.gw.id}"
  ]
}
