variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "availability_zone_1" {
  type        = string
  description = "First Availability Zone"
}

variable "availability_zone_2" {
  type        = string
  description = "Second Availability Zone"
}

variable "public_subnet_1_cidr" {
  type        = string
  description = "CIDR block for public subnet 1"
}

variable "public_subnet_2_cidr" {
  type        = string
  description = "CIDR block for public subnet 2"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block for private subnet"
}

variable "project" {
  type        = string
  description = "Project name for tags"
}
