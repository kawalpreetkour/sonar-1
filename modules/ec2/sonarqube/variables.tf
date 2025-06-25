variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "key_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "associate_public_ip" {
  type    = bool
  default = false
}

variable "project" {
  type = string
}

variable "sonar_password" {
  type        = string
  description = "PostgreSQL password for sonar user"
}
