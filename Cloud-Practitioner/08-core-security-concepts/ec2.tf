resource "aws_instance" "webserver" {
  ami                    = "ami-0f34c5ae932e6f0e4"
  instance_type          = "t2.micro"
  subnet_id              = aws_default_subnet.default.id
  vpc_security_group_ids = [aws_default_security_group.default.id]
  tags = {
    Name = "Web Server"
  }
}
