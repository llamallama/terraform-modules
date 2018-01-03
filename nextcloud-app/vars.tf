variable "environment" {
  type = "string"
  default = ""
}
variable "vpc_id" {
  description = "The ID of the VPC"
}
variable "subnet_ids" {
  type = "list"
}
variable "ami" {
  description = "The AMI to use"
  default = "ami-55ef662f"
}
variable "key_name" {
  description = "The key name to allow access with"
  default = "chris"
}
variable "access_ip" {
  default = "0.0.0.0/0"
}
variable "nextcloud_url" {
  description = "The nextCloud release to download"
  default = "https://download.nextcloud.com/server/releases/latest.tar.bz2"
}
variable "domain_name" {
  description = "The domain to access Nextcloud at"
}
variable "security_groups" {
  description = "Security groups to use"
  default = ""
}
variable "iam_instance_profile" {
  default = ""
}
variable "count_num" {
  default = "1"
}
variable "efs_mount_target" {
  type = "string"
}
variable "config_bucket" {
  type = "string"
}
