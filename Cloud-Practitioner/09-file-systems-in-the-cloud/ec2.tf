resource "aws_instance" "WebServer1" {
  ami                    = "ami-0e1c5d8c23330dee3"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.petmodels_pubsub_1.id
  vpc_security_group_ids = [aws_security_group.petmodels_sg.id]
  availability_zone      = "us-east-1a"

  tags = {
    Name = "PetsModelStack/WebServer1"
  }

}

resource "aws_instance" "WebServer2" {
  ami                    = "ami-0e1c5d8c23330dee3"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.petmodels_pubsub_2.id
  vpc_security_group_ids = [aws_security_group.petmodels_sg.id]
  availability_zone      = "us-east-1b"

  tags = {
    Name = "PetsModelStack/WebServer2"
  }

}

resource "aws_instance" "WebServer3" {
  ami                    = "ami-0e1c5d8c23330dee3"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.petmodels_pubsub_3.id
  vpc_security_group_ids = [aws_security_group.petmodels_sg.id]
  availability_zone      = "us-east-1c"

  tags = {
    Name = "PetsModelStack/WebServer3"
  }

}
