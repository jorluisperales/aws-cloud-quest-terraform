csvpc_cidr = "10.10.0.0/16"

public_subnets = ["10.10.0.0/17", "10.10.128.0/17"]

availability_zones = ["us-east-1a", "us-east-1b"]

az_tags = ["computing-solutions/VPC/publicSubnet1", "computing-solutions/VPC/publicSubnet2"]

ec2_specs = {
  "ami"           = "ami-0f34c5ae932e6f0e4"
  "instance_type" = "t2.micro"
}

sg_public_subnet = "0.0.0.0/0"
