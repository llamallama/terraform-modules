variable "name" {
  description = "Name of the role"
}

variable "effect" {
  default = "Deny"
}

variable "action" {
  default = "sts:AssumeRole"
}

variable "service" {
  description = "Service to allow role for"
}

variable "sid" {
  default = ""
}
