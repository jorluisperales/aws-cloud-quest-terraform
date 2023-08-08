resource "aws_vpc" "csvpc" {
  cidr_block           = var.csvpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "computing-solutions/VPC"
  }

}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.csvpc.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[count.index]
  tags = {
    Name = var.az_tags[count.index]
  }
}

resource "aws_internet_gateway" "csvpc_igw" {
  vpc_id = aws_vpc.csvpc.id
  tags = {
    Name = "iwg vpc csvpc"
  }

}

resource "aws_route_table" "csvpc_crt" {
  vpc_id = aws_vpc.csvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.csvpc_igw.id
  }

  tags = {
    Name = "public crt"
  }
}

resource "aws_route_table_association" "csvpc_crta_public_subnet" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.csvpc_crt.id

}

resource "aws_security_group" "security_group_cs" {
  name        = "LabStack-0f74f3ac-f7a0-4981-b376-bc417beb2020-fgcL2ACbXAoN6tYZ9hEoGv-0-Ec2SecGroup55AA3894-VS3RIOS5BQ3V"
  description = "Security Group for Web Server"
  vpc_id      = aws_vpc.csvpc.id

  ingress {
    description = "Allow HTTP Access from anywhere"
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



}
