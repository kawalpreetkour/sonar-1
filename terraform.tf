terraform {
  backend "s3" {
    bucket         = "kawal-sonarqube-tfstate-bucket"
    key            = "sonarqube/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}