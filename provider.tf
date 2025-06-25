provider "aws" {
  region = var.region
}


variable "region" {
  description = "AWS region where resources will be created"
  default     = "ap-south-1"
}
