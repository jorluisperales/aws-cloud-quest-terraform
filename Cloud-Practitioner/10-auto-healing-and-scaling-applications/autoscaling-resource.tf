resource "aws_autoscaling_group" "gameserver_asg" {
  name                      = "RegularCustomerGameServer"
  desired_capacity          = 2
  max_size                  = 4
  min_size                  = 2
  vpc_zone_identifier       = [aws_subnet.gameserver_pubsub_1.id, aws_subnet.gameserver_pubsub_2.id]
  health_check_type         = "EC2"
  health_check_grace_period = 240

  # Launch Template
  launch_template {
    id      = aws_launch_template.gameserver_template.id
    version = aws_launch_template.gameserver_template.latest_version
  }

}
