terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
    }
  }

  backend "s3" {
    bucket         = "kawal-sonarqube-tfstate-bucket"
    key            = "sonarqube/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  description = "AWS region where resources will be created"
  default     = "ap-south-1"
}
