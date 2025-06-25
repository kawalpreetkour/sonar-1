variable "public_subnet_id" {
  description = "Public subnet where NAT gateway will be placed"
  type        = string
}

variable "project" {
  description = "Project name for tagging"
  type        = string
}

variable "igw_id" {
  description = "Internet Gateway ID (to establish dependency)"
  type        = string
}
