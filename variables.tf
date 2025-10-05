variable "region" {
  default = "ap-southeast-1"
}

variable "vpc_id" {
  description = "VPC ID where resources will be deployed"
}

variable "subnet_ids" {
  description = "List of subnets for ASG and ALB"
  type        = list(string)
}

variable "bucket_name" {
  description = "S3 bucket containing website"
  default     = "my-terraform-lab-website-32aa0834"
}

