variable "environment_name" {
  description = "The name of the environment"
  default = ""
}

variable "vpc_cidr" {
  description = "The CIDR block range for the whole VPC"
  default = "10.0.0.0/16"
}

variable "public_1a_cidr" {
  description = "The CIRD block range for public subnet 1a"
  default = "10.0.0.0/24"
}

variable "public_1b_cidr" {
  description = "The CIRD block range for public subnet 1b"
  default = "10.0.1.0/24"
}

variable "public_1c_cidr" {
  description = "The CIRD block range for public subnet 1c"
  default = "10.0.2.0/24"
}
