variable "finance_vpc_details" {
  description = "Developer VPC Details"
  type        = map(string)

}

variable "marketing_vpc_details" {
  description = "Developer VPC Details"
  type        = map(string)

}

variable "developer_vpc_details" {
  description = "Developer VPC Details"
  type        = map(string)

}

variable "pub_finance_subnets" {
  description = "Finance public and private subnets"
  type        = map(string)

}

variable "pri_finance_subnets" {
  description = "Finance public and private subnets"
  type        = map(string)

}

variable "pub_marketing_subnets" {
  description = "Marketing public and private subnets"
  type        = map(string)

}

variable "pub_developer_subnets" {
  description = "Developer public and private subnets"
  type        = map(string)

}

variable "all_tags" {
  description = "all tags"
  type        = map(string)

}

