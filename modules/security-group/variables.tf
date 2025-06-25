variable "vpc_id" {
  description = "VPC ID where SGs will be created"
  type        = string
}

variable "project" {
  description = "Project prefix for naming"
  type        = string
  default     = "sonarqube"
}
