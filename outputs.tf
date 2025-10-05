# outputs.tf

# Fetch the Auto Scaling Group
data "aws_autoscaling_group" "nginx_asg_data" {
  name = aws_autoscaling_group.nginx_asg.name
}

output "asg_instance_ids" {
  description = "List of instance IDs in the Auto Scaling Group"
  value       = [for i in data.aws_autoscaling_group.nginx_asg_data.instances : i.instance_id]
}

output "alb_dns_name" {
  description = "DNS name of the NGINX ALB"
  value       = aws_lb.nginx_alb.dns_name
}

output "target_group_arn" {
  description = "ARN of the NGINX Target Group"
  value       = aws_lb_target_group.nginx_tg.arn
}

