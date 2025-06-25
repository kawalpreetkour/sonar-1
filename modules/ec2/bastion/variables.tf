variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
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

variable "project" {
  type = string
}

variable "ansible_key" {
  description = "Private key content for Ansible to connect to Sonar EC2"
  type        = string
}

