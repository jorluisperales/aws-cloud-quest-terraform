resource "aws_alb" "travelagency_alb" {
  name               = "TravelAgencyWebServer-1"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.travelagency_alb_sg.id]
  subnets            = [aws_subnet.travelagency_prisub_1.id, aws_subnet.travelagency_pubsub_2.id, aws_subnet.travelagency_pubsub_3.id]
}

# An example of target group
resource "aws_alb_target_group" "travelagency_target-group-1" {
  name     = "TravelAgencyWebServers"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.travelagency_vpc.id

  lifecycle { create_before_destroy = true }

  health_check {
    path                = "/health"
    port                = 80
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200" # has to be HTTP 200 or fails
  }
}
