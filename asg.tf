resource "aws_autoscaling_group" "nginx_asg" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = var.subnet_ids
  health_check_type    = "EC2"
  health_check_grace_period = 60
  launch_template {
    id      = aws_launch_template.nginx_lt.id
    version = "$Latest"
  }
  target_group_arns    = [aws_lb_target_group.nginx_tg.arn]

  tag {
    key                 = "Name"
    value               = "nginx-server"
    propagate_at_launch = true
  }
}

