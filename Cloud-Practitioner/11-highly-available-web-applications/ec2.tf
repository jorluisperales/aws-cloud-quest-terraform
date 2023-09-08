resource "aws_instance" "travelagency" {
  ami                    = "ami-0e1c5d8c23330dee3"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.travelagency_prisub_1.id
  vpc_security_group_ids = [aws_security_group.travelagency_sg.id]
  user_data              = file("scripts/userdata.sh")

  tags = {
    Name = "lab/TravelAgencyWebServers"
  }

}


################################################################################
# # Launch Template Resource
################################################################################

resource "aws_launch_template" "travel_agency_template" {
  name_prefix   = "travelagency"
  image_id      = aws_instance.travelagency.ami
  instance_type = "t2.micro"
}
