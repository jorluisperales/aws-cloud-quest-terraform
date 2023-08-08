ec2_specs = {
  "ami"           = "ami-0f34c5ae932e6f0e4"
  "instance_type" = "t2.micro"
}

ncvpc_cidr = "10.10.0.0/16"

public_subnet_cidr = "10.10.0.0/24"

private_subnet_cidr = "10.10.2.0/24"

sg_public_subnet = "0.0.0.0/0"

sg_private_subnet = "10.10.0.0/24"
