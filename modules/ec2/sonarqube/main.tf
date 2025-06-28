resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = var.associate_public_ip

  user_data = templatefile("${path.module}/user_data.sh.tpl", {
    sonar_password = var.sonar_password
  })

  tags = {
    Name = "${var.project}-sonarqube"
    sonarqube  = "sonarqube"
  }
}
