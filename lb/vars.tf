variable "vpc_id" {
  type = "string"
}
variable "lb_arn" {
  type    = "string"
  default = ""
}
variable "lb_name" {
  type    = "string"
  default = "Nextcloud"
}
variable "environment" {
  type = "string"
  default = "staging"
}
variable "subnets" {
  type = "list"
}
variable "internal" {
  type = "string"
  default = ""
}
variable "use_tls" {
  default = 0
}
variable "certificate_arn" {
  type = "string"
  default = ""
}
variable "ssl_policy" {
  default = "ELBSecurityPolicy-2016-08"
}
variable "security_groups" {
  default = ""
}
