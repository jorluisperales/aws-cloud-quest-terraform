variable "ec2_specs" {
  description = "Description of the EC2 instances"
  type        = map(string)

}

variable "ncvpc_cidr" {
  description = "CIDR info for NC VPC"
  type        = string

}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  type        = string

}

variable "private_subnet_cidr" {
  description = "Private subnet CIDR"
  type        = string

}

variable "sg_public_subnet" {
  description = "value"

}

variable "sg_private_subnet" {
  description = "value"

}
