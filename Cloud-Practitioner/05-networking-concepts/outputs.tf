output "webserver_ec2_public_ip" {
  description = "Public IP"
  value       = aws_instance.webserver.public_ip
}

output "webserver_ec2_public_dns" {
  description = "Public DNS"
  value       = aws_instance.webserver.public_dns
}
