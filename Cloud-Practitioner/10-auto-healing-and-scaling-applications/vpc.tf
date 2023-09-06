resource "aws_vpc" "gameserver_vpc" {
  cidr_block           = var.gameserver_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "auto-healing-and-scaling/GameServerVPC"
  }

}

resource "aws_subnet" "gameserver_pubsub_1" {
  vpc_id                  = aws_vpc.gameserver_vpc.id
  cidr_block              = var.gameserver_vpc_pubsubnets[0]
  map_public_ip_on_launch = true
  #availability_zone       = "us-east-1a"
  tags = {
    Name = "auto-healing-and-scaling/GameServerVPC/game-server-netSubnet1"
  }
}

resource "aws_subnet" "gameserver_pubsub_2" {
  vpc_id                  = aws_vpc.gameserver_vpc.id
  cidr_block              = var.gameserver_vpc_pubsubnets[1]
  map_public_ip_on_launch = true
  #availability_zone       = "us-east-1b"
  tags = {
    Name = "auto-healing-and-scaling/GameServerVPC/game-server-netSubnet2"
  }
}

resource "aws_internet_gateway" "gameserver_igw" {
  vpc_id = aws_vpc.gameserver_vpc.id

  tags = {
    Name = "auto-healing-and-scaling/GameServerVPC"
  }
}

resource "aws_route_table" "gameserver_pubsub_1_crt" {
  vpc_id = aws_vpc.gameserver_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gameserver_igw.id
  }

  tags = {
    Name = "auto-healing-and-scaling/GameServerVPC/game-server-netSubnet1"
  }
}

resource "aws_route_table" "gameserver_pubsub_2_crt" {
  vpc_id = aws_vpc.gameserver_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gameserver_igw.id
  }

  tags = {
    Name = "auto-healing-and-scaling/GameServerVPC/game-server-netSubnet2"
  }
}

resource "aws_route_table_association" "gameserver_pubsub_1_rta" {
  subnet_id      = aws_subnet.gameserver_pubsub_1.id
  route_table_id = aws_route_table.gameserver_pubsub_1_crt.id
}

resource "aws_route_table_association" "gameserver_pubsub_2_rta" {
  subnet_id      = aws_subnet.gameserver_pubsub_2.id
  route_table_id = aws_route_table.gameserver_pubsub_2_crt.id
}


resource "aws_security_group" "gameserver_sg" {
  name        = "WebServerSecurityGroup"
  description = "Security Group for Web Server"
  vpc_id      = aws_vpc.gameserver_vpc.id

  ingress {
    description = "Allow HTTP Access from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}
