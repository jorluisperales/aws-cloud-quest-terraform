resource "aws_autoscaling_group" "travelagency_asg" {
  name                = "TravelAgencyWebServers"
  desired_capacity    = 3
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.travelagency_prisub_1.id, aws_subnet.travelagency_prisub_2.id, aws_subnet.travelagency_prisub_3.id]
  health_check_type   = "ELB"
  #load_balancers      = [aws_alb.travelagency_alb.id]
  target_group_arns = [aws_alb_target_group.travelagency_target-group-1.arn]
  depends_on        = [aws_alb.travelagency_alb]

  # Launch Template
  launch_template {
    id = aws_launch_template.travel_agency_template.id
  }

}
