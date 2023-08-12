finance_vpc_details = {
  "cidr" = "172.31.0.0/16"
  "name" = "connecting-vpc/Finance VPC"
}

pub_finance_subnets = {
  "172.31.2.0/24" = "connecting-vpc/Finance VPC/FinancePublicSubnet1"
  "172.31.3.0/24" = "connecting-vpc/Finance VPC/FinancePublicSubnet2"
}

pri_finance_subnets = {
  "172.31.0.0/24" = "connecting-vpc/Finance VPC/FinancePrivateSubnet1"
  "172.31.1.0/24" = "connecting-vpc/Finance VPC/FinancePrivateSubnet2"

}

marketing_vpc_details = {
  "cidr" = "10.10.0.0/16"
  "name" = "connecting-vpc/Marketing VPC"
}

pub_marketing_subnets = {
  "10.10.0.0/24" = "connecting-vpc/Marketing VPC/MarketingPublicSubnet1"
  "10.10.1.0/24" = "connecting-vpc/Marketing VPC/MarketingPublicSubnet2"

}

developer_vpc_details = {
  "cidr" = "192.168.0.0/20"
  "name" = "connecting-vpc/Developer VPC"
}

pub_developer_subnets = {
  "192.168.0.0/24" = "connecting-vpc/Developer VPC/DeveloperPublicSubnet1"
  "192.168.1.0/24" = "connecting-vpc/Developer VPC/DeveloperPublicSubnet2"
}

all_tags = {
  "peering_mar_fin_name" = "Marketing <> Finance"
  "peering_dev_fin_name" = "Developer <> Finance"
  "mar_igw_name"         = "connecting-vpc/Marketing VPC"
  "dev_igw_name"         = "connecting-vpc/Developer VPC"
  "fin_igw_name"         = "connecting-vpc/Finance VPC"
}
