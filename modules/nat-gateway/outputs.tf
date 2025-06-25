output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

output "nat_eip" {
  description = "Elastic IP attached to NAT Gateway"
  value       = aws_eip.nat_eip.public_ip
}
