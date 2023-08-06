variable "ec2_specs" {
  description = "Specs for the EC2 instance"
  type        = map(string)

}

variable "labvpc_cidr" {
  description = "labvpc cidr"
  type        = string

}

variable "public_subnets" {
  description = "subnets for labvpc"
  type        = list(string)

}

variable "sg_public_subnet" {
  description = "SG for LabVPC"
  type        = string

}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)

}

variable "az_tags" {
  description = "AZ tags"
  type        = list(string)

}
