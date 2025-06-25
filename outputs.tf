# ─────────────────────────────────────────────
# Output
output "ec2_private_ip" {
  value = module.sonarqube_instance.private_ip
}


# ─────────────────────────────────────────────
# Output: Bastion Host Public IP
output "bastion_public_ip" {
  value = module.bastion_instance.public_ip
}
