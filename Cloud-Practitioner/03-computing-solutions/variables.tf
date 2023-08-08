variable "csvpc_cidr" {
  description = "Compute Solutions VCP's cidr"
  type        = string

}

variable "public_subnets" {
  description = "subnets for computing solutions vpc"
  type        = list(string)

}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)

}

variable "az_tags" {
  description = "AZ tags"
  type        = list(string)

}

variable "ec2_specs" {
  description = "EC2 specs"
  type        = map(string)

}

variable "sg_public_subnet" {
  description = "SG for CSVPC"
  type        = string

}
