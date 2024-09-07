# create an aws launch template
resource "aws_launch_template" "asg_launch_template" {
  name          = "${var.project_name}-asg-lt-"
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = filebase64("../modules/asg/script.sh")

  vpc_security_group_ids = [var.client_security_group_id]

}

# create an aws autoscaling group
resource "aws_autoscaling_group" "asg" {
  name = "${var.project_name}-asg"

  min_size                  = 2
  max_size                  = 2
  desired_capacity          = 2
  vpc_zone_identifier       = [var.private_subnet_1a_id, var.private_subnet_1b_id]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  target_group_arns         = [var.target_group_arn]
  termination_policies      = ["OldestInstance"]
  wait_for_capacity_timeout = "10m"

  launch_template {
    id      = aws_launch_template.asg_launch_template.id
    version = aws_launch_template.asg_launch_template.latest_version
  }

  depends_on = [aws_launch_template.asg_launch_template]

}

# scaling up policy
resource "aws_autoscaling_policy" "asg_scale_up_policy" {
  name                   = "${var.project_name}-asg-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}


# Scale up alarm
resource "aws_cloudwatch_metric_alarm" "asg_scale_up_alarm" {
  alarm_name          = "${var.project_name}-asg-scale-up-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "This metric monitors ec2 instance CPU utilization"
  alarm_actions       = [aws_autoscaling_policy.asg_scale_up_policy.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }
}

# scaling down policy
resource "aws_autoscaling_policy" "asg_scale_down_policy" {
  name                   = "${var.project_name}-asg-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

# Scale down alarm
resource "aws_cloudwatch_metric_alarm" "asg_scale_down_alarm" {
  alarm_name          = "${var.project_name}-asg-scale-down-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 30
  alarm_description   = "This metric monitors ec2 instance CPU utilization"
  alarm_actions       = [aws_autoscaling_policy.asg_scale_down_policy.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }
}
