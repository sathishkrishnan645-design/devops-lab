#!/bin/bash
yum update -y
yum install -y nginx aws-cli
systemctl enable nginx
systemctl start nginx

# Sync website from your S3 bucket
aws s3 sync s3://my-terraform-lab-website-32aa0834/ /usr/share/nginx/html/ --region ap-southeast-1

# Ensure NGINX has correct permissions
chown -R nginx:nginx /usr/share/nginx/html/

