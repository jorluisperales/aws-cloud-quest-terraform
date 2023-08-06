resource "aws_vpc" "labvpc" {
  cidr_block           = var.labvpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "cloud-first-steps/LabVpc"
  }

}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.labvpc.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[count.index]
  tags = {
    Name = var.az_tags[count.index]
  }
}

resource "aws_internet_gateway" "labvpc_igw" {
  vpc_id = aws_vpc.labvpc.id
  tags = {
    Name = "iwg vpc labvpc"
  }

}

resource "aws_route_table" "labvpc_crt" {
  vpc_id = aws_vpc.labvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.labvpc_igw.id
  }

  tags = {
    Name = "public crt"
  }
}

resource "aws_route_table_association" "labvpc_crta_public_subnet" {
  count = length(var.public_subnets)
  #  subnet_id      = aws_subnet.public-subnet1.id
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.labvpc_crt.id

}

resource "aws_security_group" "security_group_lab" {
  name        = "Security-Group-Lab"
  description = "HTTP Security Group"
  vpc_id      = aws_vpc.labvpc.id

  ingress {
    description = "HTTP over Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.sg_public_subnet]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Allows_HTTP"
  }

}
