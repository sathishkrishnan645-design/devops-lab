resource "aws_launch_template" "nginx_lt" {
  name_prefix   = "nginx-lt-"
  image_id      = "ami-0c55b159cbfafe1f0" # Amazon Linux 2
  instance_type = "t3.micro"

  iam_instance_profile {
    name = "ec2-ssm-profile"
  }

  user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
yum install -y nginx aws-cli
systemctl enable nginx
systemctl start nginx
aws s3 sync s3://${var.bucket_name}/ /usr/share/nginx/html/ --region ${var.region}
chown -R nginx:nginx /usr/share/nginx/html/
EOF
  )

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
  }
}

