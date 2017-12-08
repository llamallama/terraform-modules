variable "identifier" {
  default = ""
}

variable "engine" {
  default = ""
}

variable "engine_version" {
  default = ""
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "allocated_storage" {
  default = ""
}

variable "storage_encrypted" {
  default = false
}

variable "availability_zone" {
  default = ""
}

variable "multi_az" {
  default = false
}

variable "storage_type" {
  default = "gp2"
}

variable "name" {
  default = ""
}

variable "username" {
  default = ""
}

variable "password" {
  default = ""
}

variable "port" {
  default = "3306"
}

variable "maintenance_window" {
  default = ""
}

variable "backup_window" {
  default = ""
}

variable "backup_retention_period" {
  default = 0
}

variable "tags" {
  default = {}
}

variable "parameter_group_name" {
  default = ""
}

variable "db_subnet_group_name" {
  default = "db subnet group"
}

variable "subnet_ids" {
  type = "list"
}

variable "skip_final_snapshot" {
  default = true
}
