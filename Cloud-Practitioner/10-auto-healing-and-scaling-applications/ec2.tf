resource "aws_instance" "gameserver" {
  ami                    = "ami-0e1c5d8c23330dee3"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.gameserver_pubsub_1.id
  vpc_security_group_ids = [aws_security_group.gameserver_sg.id]
  #  availability_zone      = "us-east-1a"

  tags = {
    Name = "Game Server"
  }

}

################################################################################
# AMI template
################################################################################


resource "aws_ami_from_instance" "gameserver" {
  name               = "GameServer"
  description        = "Regular customer game server"
  source_instance_id = aws_instance.gameserver.id

  tags = {
    Name = "GameServer"
  }

}

################################################################################
# # Launch Template Resource
################################################################################

resource "aws_launch_template" "gameserver_template" {
  name                   = "GameServerTemplate"
  description            = "Regular customer server game server template"
  vpc_security_group_ids = [aws_security_group.gameserver_sg.id]
  image_id               = aws_ami_from_instance.gameserver.id
  instance_type          = "t2.micro"

}
