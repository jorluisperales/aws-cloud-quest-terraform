resource "aws_vpc" "petmodelsvpc" {
  cidr_block           = var.petmodels_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "PetModels"
  }

}

resource "aws_subnet" "petmodels_pubsub_1" {
  vpc_id                  = aws_vpc.petmodelsvpc.id
  cidr_block              = var.petmodels_vpc_pubsubnets[0]
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "PetsModelStack/PetModelsVpc/PetModels-Subnet1"
  }
}

resource "aws_subnet" "petmodels_pubsub_2" {
  vpc_id                  = aws_vpc.petmodelsvpc.id
  cidr_block              = var.petmodels_vpc_pubsubnets[1]
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "PetsModelStack/PetModelsVpc/PetModels-Subnet2"
  }
}

resource "aws_subnet" "petmodels_pubsub_3" {
  vpc_id                  = aws_vpc.petmodelsvpc.id
  cidr_block              = var.petmodels_vpc_pubsubnets[2]
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"
  tags = {
    Name = "PetsModelStack/PetModelsVpc/PetModels-Subnet3"
  }
}

resource "aws_internet_gateway" "petmodels_igw" {
  vpc_id = aws_vpc.petmodelsvpc.id

  tags = {
    Name = "PetModels"
  }
}

resource "aws_route_table" "petmodels_pubsub_1_crt" {
  vpc_id = aws_vpc.petmodelsvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.petmodels_igw.id
  }

  tags = {
    Name = "PetsModelStack/PetModelsVpc/PetModels-Subnet1"
  }
}

resource "aws_route_table" "petmodels_pubsub_2_crt" {
  vpc_id = aws_vpc.petmodelsvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.petmodels_igw.id
  }

  tags = {
    Name = "PetsModelStack/PetModelsVpc/PetModels-Subnet2"
  }
}

resource "aws_route_table" "petmodels_pubsub_3_crt" {
  vpc_id = aws_vpc.petmodelsvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.petmodels_igw.id
  }

  tags = {
    Name = "PetsModelStack/PetModelsVpc/PetModels-Subnet3"
  }
}


resource "aws_route_table_association" "petmodels_pubsub_1_rta" {
  subnet_id      = aws_subnet.petmodels_pubsub_1.id
  route_table_id = aws_route_table.petmodels_pubsub_1_crt.id

}

resource "aws_route_table_association" "petmodels_pubsub_2_rta" {
  subnet_id      = aws_subnet.petmodels_pubsub_2.id
  route_table_id = aws_route_table.petmodels_pubsub_2_crt.id

}

resource "aws_route_table_association" "petmodels_pubsub_3_rta" {
  subnet_id      = aws_subnet.petmodels_pubsub_3.id
  route_table_id = aws_route_table.petmodels_pubsub_3_crt.id

}

resource "aws_security_group" "petmodels_sg" {
  name        = "webserver"
  description = "Security Group for Web Servers"
  vpc_id      = aws_vpc.petmodelsvpc.id

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

  tags = {
    Name = "Web_Server_SG"

  }

}



################################################################################
# EFS Config
################################################################################

resource "aws_security_group" "petmodels_efs_1_sg" {
  name        = "PetModels-EFS-1-SG"
  description = "Restrict access to webs ervers only"
  vpc_id      = aws_vpc.petmodelsvpc.id

  ingress {
    description     = "Allow NFS Access from anywhere"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.petmodels_sg.id]
  }

  tags = {
    Name = "PetModels-EFS-1-SG"

  }

}
