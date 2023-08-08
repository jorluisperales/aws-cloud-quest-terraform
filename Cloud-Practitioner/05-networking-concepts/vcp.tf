resource "aws_vpc" "ncvpc" {
  cidr_block           = var.ncvpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "network-concepts/VPC"
  }

}

resource "aws_subnet" "webserver_public" {
  vpc_id                  = aws_vpc.ncvpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "network-concepts/VPC/web-server-netSubnet1"
  }
}

resource "aws_subnet" "db_private" {
  vpc_id     = aws_vpc.ncvpc.id
  cidr_block = var.private_subnet_cidr
  tags = {
    Name = "network-concepts/VPC/db-server-netSubnet1"
  }
}

resource "aws_internet_gateway" "ncvpc_iwg" {
  vpc_id = aws_vpc.ncvpc.id
  tags = {
    Name = "network-concepts/VPC"
  }
}

resource "aws_route_table" "ncvpc_rt" {
  vpc_id = aws_vpc.ncvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ncvpc_iwg.id
  }

  tags = {
    Name = "network-concepts/VPC/web-server-netSubnet1"
  }
}

resource "aws_route_table_association" "ncvpc_rta" {
  subnet_id      = aws_subnet.webserver_public.id
  route_table_id = aws_route_table.ncvpc_rt.id

}

resource "aws_security_group" "sg_public" {
  name        = "WebServerSecurityGroup"
  description = "Security Group for Web Server"
  vpc_id      = aws_vpc.ncvpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.sg_public_subnet]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "sg_private" {
  name        = "DbServerSecurityGroup"
  description = "Security Group for DB Server"
  vpc_id      = aws_vpc.ncvpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.sg_private_subnet]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
