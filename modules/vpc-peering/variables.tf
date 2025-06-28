variable "name" {
  description = "Peering connection name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "requester_vpc_id" {
  description = "Jenkins VPC ID"
  type        = string
}

variable "accepter_vpc_id" {
  description = "SonarQube VPC ID"
  type        = string
}

variable "requester_route_table_id" {
  description = "Jenkins Route Table ID"
  type        = string
}

variable "accepter_route_table_id" {
  description = "SonarQube Route Table ID"
  type        = string
}

variable "requester_cidr" {
  description = "Jenkins VPC CIDR"
  type        = string
}

variable "accepter_cidr" {
  description = "SonarQube VPC CIDR"
  type        = string
}
