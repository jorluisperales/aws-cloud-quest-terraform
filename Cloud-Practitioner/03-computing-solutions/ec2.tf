resource "aws_instance" "webserver01" {
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  availability_zone      = var.availability_zones[0]
  subnet_id              = aws_subnet.public[0].id
  user_data              = file("scripts/user-data")
  vpc_security_group_ids = [aws_security_group.security_group_cs.id]

  tags = {
    Name = "AWS Computing Solutions"
  }

}
