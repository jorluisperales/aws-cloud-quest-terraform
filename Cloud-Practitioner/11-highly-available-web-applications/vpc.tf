resource "aws_vpc" "travelagency_vpc" {
  cidr_block           = var.travelagency_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "lab/TravelAgencyVpc"
  }

}

### Public subnets

resource "aws_subnet" "travelagency_pubsub_1" {
  vpc_id                  = aws_vpc.travelagency_vpc.id
  cidr_block              = var.travelagency_vpc_pubsubnets[0]
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "lab/TravelAgencyVpc/PublicSubnet1"
  }
}

resource "aws_subnet" "travelagency_pubsub_2" {
  vpc_id                  = aws_vpc.travelagency_vpc.id
  cidr_block              = var.travelagency_vpc_pubsubnets[1]
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "lab/TravelAgencyVpc/PublicSubnet2"
  }
}

resource "aws_subnet" "travelagency_pubsub_3" {
  vpc_id                  = aws_vpc.travelagency_vpc.id
  cidr_block              = var.travelagency_vpc_pubsubnets[2]
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "lab/TravelAgencyVpc/PublicSubnet3"
  }
}

### Private subnets

resource "aws_subnet" "travelagency_prisub_1" {
  vpc_id            = aws_vpc.travelagency_vpc.id
  cidr_block        = var.travelagency_vpc_prisubnets[0]
  availability_zone = "us-east-1a"
  tags = {
    Name = "lab/TravelAgencyVpc/PrivateSubnet1"
  }
}

resource "aws_subnet" "travelagency_prisub_2" {
  vpc_id            = aws_vpc.travelagency_vpc.id
  cidr_block        = var.travelagency_vpc_prisubnets[1]
  availability_zone = "us-east-1b"

  tags = {
    Name = "lab/TravelAgencyVpc/PrivateSubnet2"
  }
}

resource "aws_subnet" "travelagency_prisub_3" {
  vpc_id            = aws_vpc.travelagency_vpc.id
  cidr_block        = var.travelagency_vpc_prisubnets[2]
  availability_zone = "us-east-1c"

  tags = {
    Name = "lab/TravelAgencyVpc/PrivateSubnet3"
  }
}

### IGW

resource "aws_internet_gateway" "travelagency_igw" {
  vpc_id = aws_vpc.travelagency_vpc.id

  tags = {
    Name = "lab/TravelAgencyVpc"
  }
}

### Public RT

resource "aws_route_table" "travelagency_pubsub_1_crt" {
  vpc_id = aws_vpc.travelagency_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.travelagency_igw.id
  }

  tags = {
    Name = "lab/TravelAgencyVpc/PublicSubnet1"
  }
}

resource "aws_route_table" "travelagency_pubsub_2_crt" {
  vpc_id = aws_vpc.travelagency_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.travelagency_igw.id
  }

  tags = {
    Name = "lab/TravelAgencyVpc/PublicSubnet2"
  }
}

resource "aws_route_table" "travelagency_pubsub_3_crt" {
  vpc_id = aws_vpc.travelagency_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.travelagency_igw.id
  }

  tags = {
    Name = "lab/TravelAgencyVpc/PublicSubnet3"
  }
}

### Nat GW

resource "aws_eip" "travelagency_1_nat_gateway" {
  domain = "vpc"
}

resource "aws_eip" "travelagency_2_nat_gateway" {
  domain = "vpc"
}

resource "aws_eip" "travelagency_3_nat_gateway" {
  domain = "vpc"
}

resource "aws_nat_gateway" "travelagency_pubsub_1_nat_gateway" {
  allocation_id = aws_eip.travelagency_1_nat_gateway.id
  subnet_id     = aws_subnet.travelagency_pubsub_1.id
  depends_on    = [aws_internet_gateway.travelagency_igw]

  tags = {
    "Name" = "lab/TravelAgencyVpc/PublicSubnet1"
  }
}

resource "aws_nat_gateway" "travelagency_pubsub_2_nat_gateway" {
  allocation_id = aws_eip.travelagency_2_nat_gateway.id
  subnet_id     = aws_subnet.travelagency_pubsub_2.id
  depends_on    = [aws_internet_gateway.travelagency_igw]
  tags = {
    "Name" = "lab/TravelAgencyVpc/PublicSubnet2"
  }
}

resource "aws_nat_gateway" "travelagency_pubsub_3_nat_gateway" {
  allocation_id = aws_eip.travelagency_3_nat_gateway.id
  subnet_id     = aws_subnet.travelagency_pubsub_3.id
  depends_on    = [aws_internet_gateway.travelagency_igw]
  tags = {
    "Name" = "lab/TravelAgencyVpc/PublicSubnet3"
  }
}

### Private RT

resource "aws_route_table" "travelagency_prisub_1_nat_gateway" {
  vpc_id = aws_vpc.travelagency_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.travelagency_pubsub_1_nat_gateway.id
  }

  tags = {
    Name = "lab/TravelAgencyVpc/PrivateSubnet1"
  }
}

resource "aws_route_table" "travelagency_prisub_2_nat_gateway" {
  vpc_id = aws_vpc.travelagency_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.travelagency_pubsub_2_nat_gateway.id
  }

  tags = {
    Name = "lab/TravelAgencyVpc/PrivateSubnet2"
  }
}

resource "aws_route_table" "travelagency_prisub_3_nat_gateway" {
  vpc_id = aws_vpc.travelagency_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.travelagency_pubsub_3_nat_gateway.id
  }

  tags = {
    Name = "lab/TravelAgencyVpc/PrivateSubnet3"
  }
}

### Public RTA

resource "aws_route_table_association" "travelagency_pubsub_1_rta" {
  subnet_id      = aws_subnet.travelagency_pubsub_1.id
  route_table_id = aws_route_table.travelagency_pubsub_1_crt.id
}

resource "aws_route_table_association" "travelagency_pubsub_2_rta" {
  subnet_id      = aws_subnet.travelagency_pubsub_2.id
  route_table_id = aws_route_table.travelagency_pubsub_2_crt.id
}

resource "aws_route_table_association" "travelagency_pubsub_3_rta" {
  subnet_id      = aws_subnet.travelagency_pubsub_3.id
  route_table_id = aws_route_table.travelagency_pubsub_3_crt.id
}

## Private RTA

resource "aws_route_table_association" "travelagency_prisub_1_rta" {
  subnet_id      = aws_subnet.travelagency_prisub_1.id
  route_table_id = aws_route_table.travelagency_prisub_1_nat_gateway.id
}

resource "aws_route_table_association" "travelagency_prisub_2_rta" {
  subnet_id      = aws_subnet.travelagency_prisub_2.id
  route_table_id = aws_route_table.travelagency_prisub_2_nat_gateway.id
}

resource "aws_route_table_association" "travelagency_prisub_3_rta" {
  subnet_id      = aws_subnet.travelagency_prisub_3.id
  route_table_id = aws_route_table.travelagency_prisub_3_nat_gateway.id
}


### Security Group

resource "aws_security_group" "travelagency_sg" {
  name        = "TravelAgencyWebServer"
  description = "Security Group used by the Travel Agency Web Servers"
  vpc_id      = aws_vpc.travelagency_vpc.id

  ingress {
    description = "Allow HTTP Access from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #    security_groups = [aws_security_group.travelagency_elb_sg.id] Removed this to avoid cycle dependencies.
  }

  egress {
    description = "Allow HTTP outbound so the instance can be configured on boot"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow HTTPS outbound so the instance can be configured on boot"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

###  Security Group for ELB
resource "aws_security_group" "travelagency_alb_sg" {
  name        = "TravelAgencyLoadBalancer"
  description = "Allow access to the Travel Agency Load Balancer from the Internet"
  vpc_id      = aws_vpc.travelagency_vpc.id
  # Inbound Rules
  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Outbound Rules
  # Internet access to Travel Agency SG
  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.travelagency_sg.id]
  }
}
