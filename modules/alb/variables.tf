variable "project" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "alb_sg_id" {}
variable "sonarqube_instance_id" {}
