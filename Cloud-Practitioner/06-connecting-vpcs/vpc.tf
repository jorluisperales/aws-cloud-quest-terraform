### Finance ###
resource "aws_vpc" "finance_vcp" {
  cidr_block           = var.finance_vpc_details.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.finance_vpc_details.name
  }
}

resource "aws_subnet" "finance_public_subnets" {
  for_each   = var.pub_finance_subnets
  vpc_id     = aws_vpc.finance_vcp.id
  cidr_block = each.key
  tags = {
    Name = each.value
  }

}

resource "aws_subnet" "finance_private_subnets" {
  for_each                = var.pri_finance_subnets
  vpc_id                  = aws_vpc.finance_vcp.id
  cidr_block              = each.key
  map_public_ip_on_launch = false # This makes private subnet
  tags = {
    Name = each.value
  }

}

resource "aws_internet_gateway" "fin_igw" {
  vpc_id = aws_vpc.finance_vcp.id

  tags = {
    Name = var.all_tags.fin_igw_name
  }
}

resource "aws_route_table" "fin2mardev_rt" {
  vpc_id = aws_vpc.finance_vcp.id
  route {
    cidr_block                = "10.10.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.mar_fin.id
  }
  route {
    cidr_block                = "192.168.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.dev_fin.id
  }
  tags = {
    Name = "Finance 2 Marketing & Developer route"
  }
}

resource "aws_route_table_association" "fin2mardev_rta" {
  subnet_id      = aws_subnet.finance_private_subnets["172.31.0.0/24"].id
  route_table_id = aws_route_table.fin2mardev_rt.id

}

resource "aws_security_group" "fin_sg" {
  name        = "From_Mar_Dev_SG"
  description = "Allowing ICMP from Marketing and Developer "
  vpc_id      = aws_vpc.finance_vcp.id

  ingress {
    description = "Allowing ICMP from Marketing and Developer"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.10.0.0/16", "192.168.0.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "FinanceServerSecurityGroup"
  }

}

### Marketing ###
resource "aws_vpc" "marketing_vcp" {
  cidr_block           = var.marketing_vpc_details.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.marketing_vpc_details.name
  }
}

resource "aws_subnet" "marketing_public_subnets" {
  for_each                = var.pub_marketing_subnets
  vpc_id                  = aws_vpc.marketing_vcp.id
  map_public_ip_on_launch = true
  cidr_block              = each.key
  tags = {
    Name = each.value
  }

}

resource "aws_internet_gateway" "mar_igw" {
  vpc_id = aws_vpc.marketing_vcp.id

  tags = {
    Name = var.all_tags.mar_igw_name
  }
}

resource "aws_route_table" "mar2fin_rt" {
  vpc_id = aws_vpc.marketing_vcp.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mar_igw.id
  }
  route {
    cidr_block                = "172.31.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.mar_fin.id
  }
  tags = {
    Name = "Marketing 2 Finance route"
  }
}

resource "aws_route_table_association" "mar2fin_rta" {
  subnet_id      = aws_subnet.marketing_public_subnets["10.10.0.0/24"].id
  route_table_id = aws_route_table.mar2fin_rt.id

}

resource "aws_security_group" "mar_sg" {
  name        = "MarketingServerSecurityGroup"
  description = "Security Group for Marketing Server"
  vpc_id      = aws_vpc.marketing_vcp.id

  ingress {
    description = "Allowing ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MarketingServerSecurityGroup"
  }

}

### Developer ###
resource "aws_vpc" "developer_vcp" {
  cidr_block           = var.developer_vpc_details.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.developer_vpc_details.name
  }
}

resource "aws_subnet" "developer_public_subnets" {
  for_each                = var.pub_developer_subnets
  vpc_id                  = aws_vpc.developer_vcp.id
  map_public_ip_on_launch = true
  cidr_block              = each.key
  tags = {
    Name = each.value
  }

}

resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.developer_vcp.id

  tags = {
    Name = var.all_tags.dev_igw_name
  }
}

resource "aws_route_table" "dev2fin_rt" {
  vpc_id = aws_vpc.developer_vcp.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igw.id
  }
  route {
    cidr_block                = "172.31.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.dev_fin.id
  }
  tags = {
    Name = "Developer 2 Finance route"
  }
}

resource "aws_route_table_association" "dev2fin_rta" {
  subnet_id      = aws_subnet.developer_public_subnets["192.168.0.0/24"].id
  route_table_id = aws_route_table.dev2fin_rt.id

}

resource "aws_security_group" "dev_sg" {
  name        = "DeveloperServerSecurityGroup"
  description = "Security Group for Developer Server"
  vpc_id      = aws_vpc.developer_vcp.id

  ingress {
    description = "Allowing ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DeveloperServerSecurityGroup"
  }

}

### VPC Peering ###
resource "aws_vpc_peering_connection" "mar_fin" {
  peer_vpc_id = aws_vpc.finance_vcp.id
  vpc_id      = aws_vpc.marketing_vcp.id
  auto_accept = true

  tags = {
    Name = var.all_tags.peering_mar_fin_name
  }
}

resource "aws_vpc_peering_connection" "dev_fin" {
  peer_vpc_id = aws_vpc.finance_vcp.id
  vpc_id      = aws_vpc.developer_vcp.id
  auto_accept = true

  tags = {
    Name = var.all_tags.peering_dev_fin_name
  }
}
