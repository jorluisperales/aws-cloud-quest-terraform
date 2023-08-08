output "webserver01_ec2_public_ip" {
  description = "Public IP"
  value       = aws_instance.webserver01.public_ip
}

output "webserver01_ec2_public_dns" {
  description = "Public DNS"
  value       = aws_instance.webserver01.public_dns
}
