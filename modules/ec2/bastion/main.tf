resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/user_data.sh.tpl", {
  project     = var.project
  ansible_key = var.ansible_key
  })

  tags = {
    Name = "${var.project}-bastion"
  }
}
