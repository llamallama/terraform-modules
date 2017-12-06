variable "vpc_id" {
  description = "The ID of the VPC"
}
variable "subnet_id" {
  description = "The ID of the subnet"
}
variable "ami" {
  description = "The AMI to use"
  default = "ami-55ef662f"
}
variable "key_name" {
  description = "The key name to allow access with"
  default = "chris"
}
variable "nextcloud_url" {
  description = "The nextCloud release to download"
  default = "https://download.nextcloud.com/server/releases/latest.tar.bz2"
}
variable "security_groups" {
  description = "Security groups to use"
  default = ""
}
