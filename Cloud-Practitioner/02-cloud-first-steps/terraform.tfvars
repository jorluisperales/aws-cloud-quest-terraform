ec2_specs = {
  "ami"           = "ami-0f34c5ae932e6f0e4"
  "instance_type" = "t2.micro"
  "volume_size"   = "8"
  "volume_type"   = "gp2"
}

labvpc_cidr = "10.0.0.0/16"

public_subnets = ["10.0.0.0/26", "10.0.0.64/26"]

sg_public_subnet = "0.0.0.0/0"

availability_zones = ["us-east-1a", "us-east-1b"]

az_tags = ["Public-SubnetSubnet1", "Public-SubnetSubnet2"]
