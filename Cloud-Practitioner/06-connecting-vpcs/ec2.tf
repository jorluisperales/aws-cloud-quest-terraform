resource "aws_instance" "marketing_server" {
  ami                    = "ami-0f34c5ae932e6f0e4"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.marketing_public_subnets["10.10.1.0/24"].id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.mar_sg.id]
  tags = {
    Name = "connecting-vpc/MarketingServer"
  }

}

resource "aws_instance" "finance_server" {
  ami                    = "ami-0f34c5ae932e6f0e4"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.finance_private_subnets["172.31.1.0/24"].id
  vpc_security_group_ids = [aws_security_group.fin_sg.id]
  tags = {
    Name = "connecting-vpc/FinanceServer"
  }

}
