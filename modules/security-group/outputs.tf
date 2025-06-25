output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "sonarqube_sg_id" {
  value = aws_security_group.sonarqube_sg.id
}

