variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "availability_zone_1" {
  default = "ap-south-1a"
}

variable "availability_zone_2" {
  default = "ap-south-1b"
}

variable "public_subnet_1_cidr" {
  default = "172.16.0.0/24"
}

variable "public_subnet_2_cidr" {
  default = "172.16.2.0/24"
}

variable "private_subnet_cidr" {
  default = "172.16.1.0/24"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "ami_id" {
  default = "ami-021a584b49225376d"
}

variable "key_name" {
  default = "ansiblekey"
}

variable "sonar_password" {
  description = "PostgreSQL password for SonarQube"
  default     = "sonar123"
}

variable "ansible_key_path" {
  description = "Path to Ansible private key file"
  type        = string
}

