## Create Scheduled Actions
### Create Scheduled Action-1: Increase capacity during business hours
resource "aws_autoscaling_schedule" "gameserver_asg_schedule" {
  scheduled_action_name  = "SecondWaveOfRegulars"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  start_time             = "2030-03-30T01:00:00Z" # Time should be provided in UTC Timezone (11am UTC = 7AM EST)
  recurrence             = "0 1 * * *"
  autoscaling_group_name = aws_autoscaling_group.gameserver_asg.id
}
