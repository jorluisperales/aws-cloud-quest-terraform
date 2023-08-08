resource "aws_instance" "webserver" {
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.webserver_public.id
  user_data              = file("scripts/user-data-web")
  vpc_security_group_ids = [aws_security_group.sg_public.id]
  tags = {
    Name = "Web Server"
  }

}

resource "aws_instance" "dbserver" {
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.db_private.id
  user_data              = file("scripts/user-data-db")
  vpc_security_group_ids = [aws_security_group.sg_private.id]
  tags = {
    Name = "DB Server"
  }

}
