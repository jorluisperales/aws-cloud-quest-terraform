output "marketing_ec2_public_ip" {
  description = "Public IP"
  value       = aws_instance.marketing_server.public_ip
}

output "marketing_ec2_public_dns" {
  description = "Public DNS"
  value       = aws_instance.marketing_server.public_dns
}

output "developer_ec2_public_ip" {
  description = "Public IP"
  value       = aws_instance.developer_server.public_ip
}

output "developer_ec2_public_dns" {
  description = "Public DNS"
  value       = aws_instance.developer_server.public_dns
}
